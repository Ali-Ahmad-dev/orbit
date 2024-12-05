import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/hr_app_text.dart';

class HrAppLeaveHistoryContainer extends StatelessWidget {
  final String? text;
  final String? text1;
  final String? text2;
  final String? text3;
  final String? text4;
  final String? text5;

  const HrAppLeaveHistoryContainer({
    Key? key,
    this.text,
    this.text1,
    this.text2,
    this.text3,
    this.text4,
    this.text5,
  }) : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    final mLocaleData =
        OrbitClientApp.mLocale[ConfigKeysTitle.evaluationScreen];
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          height: height * 0.1,
          width: width * 0.9,
          decoration: BoxDecoration(
              color: AppColors.primaryColor.value,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HrAppText(
                    text: text!,
                    style: HeadingTextStyles.heading6.copyWith(
                        color: AppColors.walletColor2,
                        fontFamily: TrueBookFontFamily.gUbuntuMedium),
                  ),
                  HrAppText(
                    text: text1!,
                    style: HeadingTextStyles.heading2.copyWith(
                        color: AppColors.walletColor2,
                        fontFamily: TrueBookFontFamily.gUbuntuMedium),
                  ),
                ],
              ),
              SizedBox(
                width: width * 0.01,
              ),
              Container(
                width: width * 0.002,
                height: height * 0.05,
                color: AppColors.walletColor2,
              ),
              SizedBox(
                width: width * 0.01,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HrAppText(
                    text: text2!,
                    style: HeadingTextStyles.heading6.copyWith(
                        color: AppColors.walletColor2,
                        fontFamily: TrueBookFontFamily.gUbuntuMedium),
                  ),
                  HrAppText(
                    text: text3!,
                    style: HeadingTextStyles.heading2.copyWith(
                        color: AppColors.walletColor2,
                        fontFamily: TrueBookFontFamily.gUbuntuMedium),
                  ),
                ],
              ),
              SizedBox(
                width: width * 0.01,
              ),
              Container(
                width: width * 0.002,
                height: height * 0.05,
                color: AppColors.walletColor2,
              ),
              SizedBox(
                width: width * 0.01,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HrAppText(
                    text: text4!,
                    style: HeadingTextStyles.heading6.copyWith(
                        color: AppColors.walletColor2,
                        fontFamily: TrueBookFontFamily.gUbuntuMedium),
                  ),
                  HrAppText(
                    text: text5!,
                    style: HeadingTextStyles.heading2.copyWith(
                        color: AppColors.walletColor2,
                        fontFamily: TrueBookFontFamily.gUbuntuMedium),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
