import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/controllers/login_controller.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:intl/intl.dart';

class MonthYearSelector extends StatelessWidget {
  final int displayedDateMonth;
  final DateTime displayedDate;
  final Function()? onPressedPrevious;
  final Function()? onPressedNext;
  const MonthYearSelector({
    super.key,
    required this.displayedDateMonth,
    required this.displayedDate,
    required this.onPressedPrevious,
    required this.onPressedNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.75,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      decoration: BoxDecoration(
        color: Get.find<LoginController>().designation.value == 'Team Lead'
            ? AppColors.primaryGreenColor
            : Get.find<LoginController>().designation.value == 'HR'
                ? AppColors.primaryBlue
                : AppColors.primaryColor.value,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(1, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 15,
              ),
              onPressed: onPressedPrevious),
          SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: ModalRoute.of(context)!.animation!,
              curve: Curves.easeInOut,
            )),
            child: Text(
              DateFormat('MMMM yyyy').format(displayedDate),
              textAlign: TextAlign.center,
              style: HeadingTextStyles.heading4.copyWith(
                  color: AppColors.backgroundColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  fontFamily: TrueBookFontFamily.gUbuntuBold),
              key: ValueKey<int>(displayedDateMonth),
            ),
          ),
          IconButton(
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 15,
              ),
              onPressed: onPressedNext),
        ],
      ),
    );
  }
}
