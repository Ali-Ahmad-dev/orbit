import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/network/network_endpoints.dart';
import 'package:orbit/models/login_model.dart';
import 'package:orbit/utils/secure_storage.dart';
import 'package:orbit/utils/shared_prefrences.dart';
import '../constants/routes/routes_endpoints.dart';
import '../helper/main_helper.dart';

import '../repositories/login_repository.dart';
import '../utils/hr_app_internet_checker.dart';

class LoginController extends GetxController {
  final LoginRepository _repository;
  LoginController(this._repository);
  // Dependencies
  final MainHelper mainHelper = Get.find<MainHelper>();
  final SecureStorage secureStorage = SecureStorage();
  // Form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // Login model
  LoginModel loginModel = LoginModel();
  // Text controllers
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // State variables
  final RxString errorMessage = ''.obs;
  final RxBool apiCalling = false.obs;
  final RxBool isPasswordObsecure = true.obs;
  bool isFingerPrintEnabled = true;
  RxString designation = ''.obs;
  LoginRepository get repository => _repository;
  bool _isInitialized = false; //new
  // Toggles password visibility
  void togglePasswordVisibility() {
    isPasswordObsecure.value = !isPasswordObsecure.value;
  }

  @override
  void onInit() {
    super.onInit();
    if (!_isInitialized) {
      //new
      FlutterNativeSplash.remove();
      _initializeFingerPrint();
      _isInitialized = true;
    }
    // FlutterNativeSplash.remove();
    // _initializeFingerPrint();
  }

  // Initializes fingerprint authentication state
  Future<void> _initializeFingerPrint() async {
    final fingerPrintState = await secureStorage.getFingerprint();
    isFingerPrintEnabled = fingerPrintState == 'ON';
  }

  @override
  void dispose() {
    emailAddressController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Handles login process
  Future<void> login() async {
    if (!await _checkInternetConnection()) return;
    if (formKey.currentState!.validate() && !apiCalling.value) {
      _performLogin();
    }
  }

// Helper method to check internet connection
  Future<bool> _checkInternetConnection() async {
    final isConnectionAvailable =
        await Get.find<HrAppInternetChecker>().hasConnection();
    if (!isConnectionAvailable) {
      return false;
    }
    return isConnectionAvailable;
  }

// Helper method to perform login
  Future<void> _performLogin() async {
    apiCalling.value = true;
    errorMessage.value = '';
    // final fcmFuture = Get.find<OrbitPushNotificationService>().getToken();
    final email = emailAddressController.text.trim();
    final password = passwordController.text.trim();
    final loginData = {
      "email": email,
      "password": password,
      // "fcmToken": await fcmFuture, // Ensure FCM token is fetched
      "origin": Platform.isAndroid ? 'A' : 'I',
    };
    try {
      final result =
          await _repository.loginUser(NetworkEndpoints.login, loginData);
      print(json.encode(result));
      await _handleLoginResult(result, email, password);
    } catch (error) {
      _handleLoginError(error);
    } finally {
      apiCalling.value = false;
    }
  }

// Helper method to handle login result
  Future<void> _handleLoginResult(
      Map<String, dynamic> result, String email, String password) async {
    final status = result['statusCode'];
    loginModel = LoginModel.fromJson(result);
    if (!loginModel.isError! && status == 200) {
      _onLoginSuccess(email, password);

      SharedPrefs.saveLoginModel(loginModel);
      await _saveEmployeeDesignation();
      await _saveEmployeeId();
      getDesignation();
    } else {
      _onLoginFailure();
    }
  }

  Future<void> _onLoginSuccess(String email, String password) async {
    await _isLoggedIn();
    Get.put(loginModel, permanent: true);
    Get.offAllNamed(RouteEndpoints.bottomNav);
  }

// Actions to perform on login failure
  void _onLoginFailure() {
    errorMessage.value = loginModel.message ?? 'Email or password is invalid';
  }

// Helper method to handle login errors
  void _handleLoginError(dynamic error) {
    print('Error: $error');
    errorMessage.value = loginModel.message ?? 'An error occurred';
  }

  Future<void> _saveEmployeeDesignation() async {
    await SharedPrefs().setEmployeeDesignation(loginModel);
  }

  Future<void> _saveEmployeeId() async {
    await SharedPrefs().setEmployeeId(loginModel);
  }

  Future<void> _isLoggedIn() async {
    await SharedPrefs().saveLoggedInSession(true);
  }

  Future<void> getDesignation() async {
    designation.value = (await SharedPrefs.getEmployeeDesignation())!;
    AppColors().updatePrimaryColor(designation.value);
  }
}
