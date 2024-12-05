import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/fonts/true_book_font_family.dart';
import '../../helper/main_helper.dart';

class ButtonTextStyles {
  static final _fontSize = Get.find<MainHelper>().mScreenWidth +
      Get.find<MainHelper>().mScreenHeight;

  static final heading1 = TextStyle(
      color: Colors.white,
      fontSize: _fontSize * 0.015,
      fontFamily: TrueBookFontFamily.gUbuntuBold);

  static final heading2 = TextStyle(
      color: Colors.white,
      fontSize: _fontSize * 0.015,
      fontFamily: TrueBookFontFamily.gUbuntuLight);
}
