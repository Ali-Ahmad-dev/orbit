import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/fonts/true_book_font_family.dart';
import '../../helper/main_helper.dart';

class HeadingTextStyles {
  static final fontSize = Get.find<MainHelper>().mScreenWidth +
      Get.find<MainHelper>().mScreenHeight;

  static final heading1 = TextStyle(
      color: AppColors.primaryTextColor,
      fontSize: fontSize * 0.025,
      fontFamily: TrueBookFontFamily.gUbuntuBold);
  static final heading2 = TextStyle(
      color: AppColors.textColorTextFormField,
      fontSize: fontSize * 0.012,
      fontFamily: TrueBookFontFamily.gUbuntuLight);

  static final heading3 = TextStyle(
      color: AppColors.descriptionColor,
      fontSize: fontSize * 0.010,
      fontFamily: TrueBookFontFamily.gUbuntuLight);

  static final footerText = TextStyle(
      color: AppColors.descriptionColor,
      fontSize: fontSize * 0.012,
      fontFamily: TrueBookFontFamily.gUbuntuBold);
  static final heading4 = TextStyle(
      color: AppColors.primaryTextColor,
      fontSize: fontSize * 0.017,
      fontFamily: TrueBookFontFamily.gUbuntuBold);
  static final heading5 = TextStyle(
      color: AppColors.primaryTextColor,
      fontSize: fontSize * 0.02,
      fontFamily: TrueBookFontFamily.gUbuntuLight);
  static final heading6 = TextStyle(
      color: AppColors.primaryTextColor,
      fontSize: fontSize * 0.014,
      fontFamily: TrueBookFontFamily.gUbuntuLight);
  static final heading7 = TextStyle(
      color: AppColors.primaryTextColor,
      fontSize: fontSize * 0.0010,
      fontFamily: TrueBookFontFamily.gUbuntuLight);
}
