import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/utils/hr_app_snack_bar.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class HrAppInternetChecker extends GetxController {
  final StreamSubscription<InternetConnectionStatus> listener =
      InternetConnectionChecker().onStatusChange.listen(
    (InternetConnectionStatus status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          print('Data connection is available.');
          HrAppSnackBar.showSnackBar(
              title: "Internet Connected",
              message: "Your Internet is connected successfuly");
          break;
        case InternetConnectionStatus.disconnected:
          print('You are disconnected from the internet.');
          HrAppSnackBar.showSnackBar(
              title: "No Internet Available",
              message: "Please connect your internet",
              backgroundColor: Colors.red);
          break;
      }
    },
  );

  Future<bool> hasConnection() async {
    return await InternetConnectionChecker().hasConnection;
  }
}
