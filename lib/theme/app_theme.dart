import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:orbit/controllers/login_controller.dart';
import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData getLightTheme() {
    return ThemeData(
      // bottomNavigationBarTheme: _navigationBarTheme(),
      primaryColor: Colors.red,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      useMaterial3: true,

      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.white,
          fontSize: 23, //20
        ),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Colors.black),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
    );
  }

  static ThemeData getDarkTheme() {
    return ThemeData(
      primaryColor: Colors.red,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.black,
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.black,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.white,
          fontSize: 23, //20
        ),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Colors.black),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
    );
  }

  static BottomNavigationBarThemeData _navigationBarTheme() {
    return BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(
        color: AppColors.primaryColor.value,
        size: 35,
      ),
      selectedItemColor: AppColors.primaryColor.value,
      unselectedItemColor: AppColors.primarygreyColor,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
    );
  }
}
