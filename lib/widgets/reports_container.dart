import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/helper/main_helper.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/hr_app_text.dart';

class ReportsContainer extends StatelessWidget {
  final String? centerText;
  final Color? color;
  final Widget? image;
  final VoidCallback? onTap;

  const ReportsContainer({
    super.key,
    this.centerText = 'Default',
    this.color,
    this.image,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    final height = Get.find<MainHelper>().mScreenHeight * 0.5;
    final width = Get.find<MainHelper>().mScreenWidth * 0.5;
    return Container(
      height: height * 0.1,
      width: width * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            child: Container(
              height: height * 0.085,
              width: width * 0.65,
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Padding(
                padding: EdgeInsets.only(left: width * 0.06),
                child: Center(
                  child: HrAppText(
                    text: centerText ?? '',
                    style: HeadingTextStyles.heading4.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: AppColors.backgroundColor,
                      fontFamily: TrueBookFontFamily.gUbuntuBold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: -height * 0.045,
            top: height * 0.0006,
            child: GestureDetector(
              onTap: onTap,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: height * 0.05,
                    backgroundColor: const Color.fromARGB(255, 251, 251, 251),
                  ),
                  image!
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
