import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/controllers/login_controller.dart';
import 'package:orbit/helper/main_helper.dart';
import 'package:orbit/models/login_model.dart';
import 'package:orbit/repositories/login_repository.dart';
import 'package:orbit/utils/hr_app_internet_checker.dart';
import 'package:orbit/utils/hr_app_snack_bar.dart';
import 'package:orbit/utils/secure_storage.dart';
import 'package:orbit/utils/shared_prefrences.dart';
import '../constants/routes/routes_endpoints.dart';
import '../services/firebase_notification.dart';

class SplashScreenController extends GetxController {
  LoginController loginController = Get.put(
      LoginController(
        LoginRepository(Get.find<MainHelper>().apiServices),
      ),
      permanent: true);
  final secureStorage = SecureStorage();
  @override
  void onInit() {
    rememberMe();
    getDesignation();
    super.onInit();
    initializeApp();
  }


  Future<void> getDesignation() async {
    final designation = await SharedPrefs.getEmployeeDesignation();
    if (designation != null && designation.isNotEmpty) {
      AppColors().updatePrimaryColor(designation);
    }
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 1), () {
      FlutterNativeSplash.remove();
      Get.toNamed(RouteEndpoints.loginScreen);
    });
  }

  void rememberMe() async {
    await login();
    // final email = await SecureStorage().getEmail();
    // final password = await SecureStorage().getPassword();
    // print('rememberMe => $email');
    // print('rememberMe => $password');
    // if (email == null || password == null) {
    //   _navigateToHome();
    // } else {
    //   var decryptedPass = password;
    //   print('rememberMe => $decryptedPass');
    // await login(email, decryptedPass);
    // }
  }

  Future<void> login() async {
    final isConnectionAvailable =
        await Get.find<HrAppInternetChecker>().hasConnection();
    if (!isConnectionAvailable) {
      HrAppSnackBar.showSnackBar(
          title: "No Internet Available",
          message: "Please connect your internet",
          backgroundColor: Colors.red);
      return;
    }
    try {
      // var data = {
      //   "email": email,
      //   "password": pass,
      //   // "fcmToken": await _retrieveToken(),
      //   "origin": Platform.isAndroid ? 'A' : 'I',
      // };

      // var result = await loginController.repository
      //     .loginUser(NetworkEndpoints.login, data);
      // final status = result['statusCode'];
      // LoginModel loginModel = LoginModel.fromJson(result);
      final loggedInSession = await SharedPrefs().getLoggedInStatus();
      // if (loginModel.isError == false && status == 200) {
      print('=================$loggedInSession=======================');

      if (loggedInSession == true) {
        LoginModel loginModel =
            await SharedPrefs.getLoginModel() ?? LoginModel();
        Get.put(loginModel);

        Get.offAllNamed(RouteEndpoints.bottomNav);
      } else {
        Get.toNamed(RouteEndpoints.loginScreen);
      }
    } catch (e) {
      print(e);
    } finally {
      loginController.apiCalling.value = false;
    }
  }

  Future<String?> _retrieveToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    return token;
  }
final notificationServices = NotificationServices();
  void initializeApp() {
    notificationServices.firebaseInit();
    //notificationServices.isTokenRefresh();
    notificationServices.requestNotificationPermission();
    notificationServices.getDeviceToken().then((value){
      print("Device token");
      print(value);
    });
  }
}
