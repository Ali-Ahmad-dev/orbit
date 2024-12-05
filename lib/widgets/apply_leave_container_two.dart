import 'package:flutter/material.dart';
import 'package:flutter_spinner_time_picker/flutter_spinner_time_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/controllers/apply_leave_controller.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/hr_app_text.dart';
import 'package:orbit/widgets/hr_text.dart';

class ApplyLeaveContainerTwo extends GetView<ApplyLeaveController> {
  TimeOfDay startTime;
  TimeOfDay? endTime;

  ApplyLeaveContainerTwo(
      {Key? key, required this.startTime, required this.endTime})
      : super(key: key);

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
              text: "Select Time Frame",
              style: HeadingTextStyles.heading6.copyWith(
                  color: AppColors.payment1,
                  fontFamily: TrueBookFontFamily.gUbuntuBold),
            ),
            const HrText()
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.02, vertical: height * 0.01),
          height: height * 0.15,
          width: width * 0.9,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.walletColor2)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  HrAppText(
                    text: "Start Time",
                    style: HeadingTextStyles.heading2.copyWith(
                      color: AppColors.payment1,
                    ),
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  Container(
                    height: height * 0.04,
                    width: width * 0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                        border: Border.all(color: Colors.black12)),
                    child: Center(
                      child: GestureDetector(
                        onTap: () async {
                          final result = await showSpinnerTimePicker(
                            context,
                            initTime: startTime,
                          );
                          if (result != null) {
                            controller.startTime.value = result;
                          }
                        },
                        child: Obx(() => HrAppText(
                              text:
                                  controller.startTime.value == TimeOfDay.now()
                                      ? "HH:MM"
                                      : controller.startTime.value
                                              ?.format(context) ??
                                          'HH:MM',
                              style: HeadingTextStyles.heading2.copyWith(
                                color: AppColors.payment1,
                              ),
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  HrAppText(
                    text: "End Time",
                    style: HeadingTextStyles.heading2.copyWith(
                      color: AppColors.payment1,
                    ),
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  Container(
                    height: height * 0.04,
                    width: width * 0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                        border: Border.all(color: Colors.black12)),
                    child: Center(
                      child: GestureDetector(
                        onTap: () async {
                          final result = await showSpinnerTimePicker(
                            context,
                            initTime: endTime ?? TimeOfDay.now(),
                          );
                          if (result != null) {
                            controller.endTime.value = result;
                          }
                        },
                        child: Obx(() => HrAppText(
                              text: controller.endTime.value == TimeOfDay.now()
                                  ? "HH:MM"
                                  : controller.endTime.value?.format(context) ??
                                      'HH:MM',
                              style: HeadingTextStyles.heading2.copyWith(
                                color: AppColors.payment1,
                              ),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
