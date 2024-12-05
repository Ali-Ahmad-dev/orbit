import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/constants/models/evaluation_history_model.dart';
import 'package:orbit/models/notifications_model.dart';
import 'package:orbit/utils/hr_datetime_util.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/hr_app_text.dart';

class HrAppNotificationContainer extends StatelessWidget {
  final Notifications notificationModel;

  const HrAppNotificationContainer({
    Key? key,
    required this.notificationModel,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;

    OrbitClientApp.mLocale[ConfigKeysTitle.evaluationScreen];
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.02, vertical: height * 0.01),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(1, 2)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width * 0.5,
                    child: HrAppText(
                      text: notificationModel.title!,
                      style: HeadingTextStyles.heading2.copyWith(
                          color: AppColors.payment1,
                          fontFamily: TrueBookFontFamily.gUbuntuMedium),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: width * 0.35,
                      child: HrAppText(
                        text: notificationModel.type!,
                        style: HeadingTextStyles.heading2.copyWith(
                            color: AppColors.payment1,
                            fontFamily: TrueBookFontFamily.gUbuntuBold),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),
              HrAppText(
                maxLines: 3,
                text: notificationModel.message!,
                style: HeadingTextStyles.heading2.copyWith(
                  color: AppColors.payment1,
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              HrAppText(
                  text: HrDatetimeUtil.toYearMonthDayTime(
                      notificationModel.createdDateTime!),
                  style: HeadingTextStyles.heading2.copyWith(
                    color: AppColors.payment1,
                  )),
              // HrAppText(
              //   text:notificationModel.createdDateTime!,
              //   style: HeadingTextStyles.heading2.copyWith(
              //     color: AppColors.payment1,
              //   ),
              // ),
            ],
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
      ],
    );
  }
}
