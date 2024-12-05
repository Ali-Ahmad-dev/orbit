import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/controllers/apply_leave_controller.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/hr_app_text.dart';
import 'package:orbit/widgets/hr_text.dart';
import '../widgets/orbit_client_apply_leave_container.dart';

class ApplyLeaveContainerOne extends StatelessWidget {
  final ApplyLeaveController controller;
  const ApplyLeaveContainerOne({required this.controller, Key? key})
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            HrAppText(
              text: "Select Half",
              style: HeadingTextStyles.heading6.copyWith(
                  color: AppColors.payment1,
                  fontFamily: TrueBookFontFamily.gUbuntuBold),
            ),
            const HrText()
          ],
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.07),
            width: width * 0.9,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white)),
            child: Row(
              children: [
                Obx(
                  () => Expanded(
                    flex: 1,
                    child: OrbitClientApplyLeaveContainer(
                      text: "First Half",
                      style: HeadingTextStyles.heading3.copyWith(
                        color: AppColors.payment1,
                      ),
                      radioValue: 1,
                      selectedValue: controller.selectedValueContainerOne.value,
                      onChanged: (value) {
                        controller.checkAndSelectFirstHalf(value!);
                        print(value);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.08,
                ),
                Obx(
                  () => Expanded(
                    flex: 1,
                    child: OrbitClientApplyLeaveContainer(
                      text: "Second Half",
                      style: HeadingTextStyles.heading3.copyWith(
                        color: AppColors.payment1,
                      ),
                      radioValue: 2,
                      selectedValue: controller.selectedValueContainerOne.value,
                      onChanged: (value) {
                        controller.selectedValueContainerOne.value = value!;
                        print(value);
                      },
                    ),
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
