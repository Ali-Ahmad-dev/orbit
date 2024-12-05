import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/config/config_keys_body.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/header_container_design.dart';
import 'package:orbit/widgets/reusable_profile_widget.dart';
import 'package:orbit/widgets/hr_app_text.dart';
import 'package:orbit/widgets/time_sheet.dart';
import '../controllers/member_attendance_report_controller.dart';
import '../widgets/leaves_calculation_container.dart';

class MemberAttendanceReport extends GetView<MemberAttendanceReportController> {
  const MemberAttendanceReport({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mLocaleData =
        OrbitClientApp.mLocale[ConfigKeysTitle.memberAttendanceReportScreen];
    double width = Get.width;
    double height = Get.height;
    return Scaffold(
      body: SafeArea(
        child: HeaderContainerDesign(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // SizedBox(height: height * 0.05),
                Padding(
                  padding: EdgeInsets.all(width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ReusableProfileWidget(
                        icon: Icon(
                          Icons.arrow_back,
                          color: AppColors.walletColor2,
                        ),
                        title: mLocaleData![
                            ConfigKeysBody.memberAttendanceReportScreenTitle]!,
                        name: controller.member!.teamMemberName,
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
                        HrAppText(
                          text: mLocaleData[ConfigKeysBody
                              .memberAttendanceReportScreenDescription]!,
                          style: HeadingTextStyles.heading4.copyWith(
                              color: AppColors.descriptionColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: TrueBookFontFamily.gUbuntuBold),
                        ),
                        SizedBox(height: height * 0.01),
                        LeavesCalculationContainer(
                          text2: '0',
                          text3: controller.member!.leaveCount,
                        ),
                        SizedBox(height: height * 0.03),
                        HrAppText(
                          text: mLocaleData[ConfigKeysBody
                              .memberAttendanceReportScreenContainer]!,
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
                                if (!controller.isDialogShowing.value) {
                                  controller.isDialogShowing.value = true;
                                  Get.dialog(
                                    Center(
                                      child: Container(
                                        padding: const EdgeInsets.all(20.0),
                                        decoration: BoxDecoration(
                                          color: AppColors.backgroundColor,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.15),
                                              blurStyle: BlurStyle.outer,
                                              spreadRadius: 2.0,
                                              blurRadius: 15,
                                              offset: const Offset(2, 6),
                                            )
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const CircularProgressIndicator(),
                                            const SizedBox(width: 20),
                                            HrAppText(
                                              text: "Please wait",
                                              style: HeadingTextStyles.heading4
                                                  .copyWith(
                                                color: AppColors
                                                    .primaryColor.value,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                fontFamily: TrueBookFontFamily
                                                    .gUbuntuBold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    barrierDismissible: false,
                                  ).then((_) {
                                    controller.isDialogShowing.value = false;
                                  });
                                }
                              });
                              return const SizedBox.shrink();
                            }
                          },
                        ),
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
