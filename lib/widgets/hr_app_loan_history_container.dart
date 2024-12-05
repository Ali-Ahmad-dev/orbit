import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/hr_app_text.dart';

class HrAppLoanHistoryContainer extends StatelessWidget {
  final String? text;
  final String? text1;
  final String? text2;

  const HrAppLoanHistoryContainer({this.text, this.text1, this.text2, Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    final mLocaleData =
        OrbitClientApp.mLocale[ConfigKeysTitle.applyLeaveContainerOne];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        HrAppText(
          text: text!,
          style: HeadingTextStyles.heading3.copyWith(
              color: AppColors.walletColor2,
              fontFamily: TrueBookFontFamily.gUbuntuMedium),
        ),
        HrAppText(
          text: text1!,
          style: HeadingTextStyles.heading3.copyWith(
              color: AppColors.walletColor2,
              fontFamily: TrueBookFontFamily.gUbuntuMedium),
        ),
        HrAppText(
          text: text2!,
          style: HeadingTextStyles.heading3.copyWith(
              color: AppColors.walletColor2,
              fontFamily: TrueBookFontFamily.gUbuntuMedium),
        ),
      ],
    );
  }
}
