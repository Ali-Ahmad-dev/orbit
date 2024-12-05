import 'dart:convert';
import 'package:orbit/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static final SharedPrefs _instance = SharedPrefs._internal();

  factory SharedPrefs() {
    return _instance;
  }

  SharedPrefs._internal();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  SharedPreferences? get prefs => _prefs;
  // static const String _keyLoginModel = 'loginModel';
  Future<void> setEmployeeDesignation(LoginModel loginModel) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String employeeDesignation = loginModel.employeeDetails!.designation ?? "";
    await sharedPrefs.setString('employeeDesignation', employeeDesignation);
  }

  Future<void> saveLoggedInSession(bool isLoggedIn) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setBool('isLoggedIn', true);
  }

  Future<void> removeLoggedInSession(bool isLoggedIn) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setBool('isLoggedIn', false);
  }

  Future<bool?> getLoggedInStatus() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getBool('isLoggedIn');
  }

  Future<void> setEmployeeId(LoginModel loginModel) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    int employeeId = loginModel.employeeDetails!.employeeId ?? 0;
    await sharedPrefs.setInt('employeeId', employeeId);
  }

// Save model to SharedPreferences
  static Future<void> saveLoginModel(LoginModel loginModel) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(loginModel.toJson());
    await prefs.setString('loginModel', jsonString);
  }

  static Future<LoginModel?> getLoginModel() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String? jsonString = sharedPrefs.getString('loginModel');
    if (jsonString != null) {
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return LoginModel.fromJson(jsonMap);
    }
    return null;
  }

  static Future<String?> getEmployeeDesignation() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String? employeeDesignation = sharedPrefs.getString('employeeDesignation');
    return employeeDesignation;
  }

  static Future<int?> getEmployeeId() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    int? employeeDesignation = sharedPrefs.getInt('employeeId');
    return employeeDesignation;
  }
}
