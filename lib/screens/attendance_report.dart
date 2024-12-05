import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/config/config_keys_body.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/controllers/attendance_report_controller.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/header_container_design.dart';
import 'package:orbit/widgets/reusable_profile_widget.dart';
import 'package:orbit/widgets/hr_app_text.dart';
import 'package:orbit/widgets/slider_button.dart';
import 'package:orbit/widgets/time_sheet.dart';

class AttendanceReportScreen extends GetView<AttendanceReportController> {
  const AttendanceReportScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mLocaleData1 =
        OrbitClientApp.mLocale[ConfigKeysTitle.dashboardMenuScreen];
    final mLocaleData = OrbitClientApp.mLocale[ConfigKeysTitle.dashboardScreen];
    double width = Get.width;
    double height = Get.height;
    return Scaffold(
      body: SafeArea(
        child: HeaderContainerDesign(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ReusableProfileWidget(
                        title: mLocaleData1![ConfigKeysBody.dashboardMenu]!,
                        name: controller
                            .loginController.employeeDetails!.employeeName,
                        post: controller
                            .loginController.employeeDetails!.designation,
                      ),
                      SizedBox(height: height * 0.01),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(width * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: height * 0.015),
                        Center(
                            child: Obx(() => MonthYearSelector(
                                  displayedDateMonth:
                                      controller.displayedDate.month,
                                  displayedDate: controller.displayedDate,
                                  onPressedPrevious: () {
                                    controller.previousMonth();
                                  },
                                  onPressedNext: () {
                                    controller.nextMonth();
                                  },
                                ))),
                        SizedBox(height: height * 0.03),
                        HrAppText(
                          text: mLocaleData![ConfigKeysBody.dashboardBody8]!,
                          style: HeadingTextStyles.heading4.copyWith(
                              color: AppColors.descriptionColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              fontFamily: TrueBookFontFamily.gUbuntuBold),
                        ),
                        SizedBox(height: height * 0.01),
                        Obx(
                          () {
                            if (controller.apiCalling.value == false ||
                                controller.attendanceList.isNotEmpty) {
                              if (controller.isDialogShowing.value) {
                                Get.back();
                                controller.isDialogShowing.value = false;
                              }
                              return TimeSheetWidget(
                                employees: controller.attendanceList,
                              );
                            } else {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                return;
                              });
                              return const SizedBox.shrink();
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
