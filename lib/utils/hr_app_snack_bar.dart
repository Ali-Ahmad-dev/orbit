import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/utils/hr_toast.dart';

class HrAppSnackBar {
  static showSnackBar(
      {title,
      message,
      color = Colors.black,
      duration = 2,
      snackPosition = SnackPosition.BOTTOM,
      backgroundColor = Colors.green}) {
    HrToast.showToast(msg: message, backgroundColor: backgroundColor);
  }
}
