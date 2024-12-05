import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/config/config_keys_body.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/controllers/login_controller.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/hr_app_text.dart';

class SpecialContainer extends StatelessWidget {
  final double height;
  const SpecialContainer({super.key, this.height = 0.15});

  @override
  Widget build(BuildContext context) {
    final mLocaleData2 =
        OrbitClientApp.mLocale[ConfigKeysTitle.salarySlipScreen];
    final heightM = MediaQuery.of(context).size.height;
    return Container(
      height: height * heightM,
      decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurStyle: BlurStyle.outer,
              spreadRadius: 2.0,
              blurRadius: 15,
              offset: const Offset(2, 6),
            )
          ]),
      child: Center(
        child: HrAppText(
          text: mLocaleData2![ConfigKeysBody.salarySlipScreenContainer]!,
          style: HeadingTextStyles.heading4.copyWith(
              color:
                  Get.find<LoginController>().designation.value == 'Team Lead'
                      ? AppColors.primaryGreenColor
                      : Get.find<LoginController>().designation.value == 'HR'
                          ? AppColors.primaryBlue
                          : AppColors.primaryColor.value,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: TrueBookFontFamily.gUbuntuBold),
        ),
      ),
    );
  }
}
