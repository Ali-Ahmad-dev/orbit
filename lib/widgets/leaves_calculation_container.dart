import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/controllers/login_controller.dart';
import 'package:orbit/helper/main_helper.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/hr_app_text.dart';
import 'package:intl/intl.dart';

class LeavesCalculationContainer extends StatelessWidget {
  final String? text1;
  final String? text2;
  final int? text3;
  final String? desc1;
  final String? desc2;
  final String? desc3;
  LeavesCalculationContainer(
      {this.text2 = '0',
      this.text3 = 1,
      this.desc2 = 'Hours',
      this.desc3 = 'Leaves',
      super.key})
      : text1 = DateFormat('MMMM').format(DateTime.now()),
        desc1 = DateTime.now().year.toString();

  @override
  Widget build(BuildContext context) {
    final height = Get.find<MainHelper>().mScreenHeight;
    final width = Get.find<MainHelper>().mScreenWidth;

    return Container(
      height: height * 0.1,
      width: width * 0.9,
      decoration: BoxDecoration(
          color: Get.find<LoginController>().designation.value == 'Team Lead'
              ? AppColors.primaryGreenColor
              : Get.find<LoginController>().designation.value == 'HR'
                  ? AppColors.primaryBlue
                  : AppColors.primaryColor.value,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.06),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HrAppText(
                  text: '$text1',
                  style: HeadingTextStyles.heading6.copyWith(
                      color: AppColors.walletColor2,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: TrueBookFontFamily.gUbuntuBold),
                ),
                HrAppText(
                  text: '$desc1',
                  style: HeadingTextStyles.heading2.copyWith(
                      color: AppColors.walletColor2,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: TrueBookFontFamily.gUbuntuBold),
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
                  text: '$desc2',
                  style: HeadingTextStyles.heading6.copyWith(
                      color: AppColors.walletColor2,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: TrueBookFontFamily.gUbuntuBold),
                ),
                HrAppText(
                  text: '$text2',
                  style: HeadingTextStyles.heading2.copyWith(
                      color: AppColors.walletColor2,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: TrueBookFontFamily.gUbuntuBold),
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
                  text: '$desc3',
                  style: HeadingTextStyles.heading6.copyWith(
                      color: AppColors.walletColor2,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: TrueBookFontFamily.gUbuntuBold),
                ),
                HrAppText(
                  text: '$text3',
                  style: HeadingTextStyles.heading2.copyWith(
                      color: AppColors.walletColor2,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: TrueBookFontFamily.gUbuntuBold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
