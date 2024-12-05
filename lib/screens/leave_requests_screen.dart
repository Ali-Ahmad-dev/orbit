import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/config/config_keys_body.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/constants/models/current_month_attendance_model.dart';
import 'package:orbit/controllers/leave_requests_controller_test.dart';
import 'package:orbit/models/login_model.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/header_container_design.dart';
import 'package:orbit/widgets/reusable_profile_widget.dart';
import 'package:orbit/widgets/hr_app_text.dart';
import 'package:orbit/widgets/hr_circularprogressindicator.dart';
import 'package:orbit/widgets/leave_type_container.dart';
import 'package:orbit/widgets/leaves_calculation_container.dart';
import 'package:orbit/widgets/special_container.dart';
import 'package:orbit/widgets/time_sheet.dart';

class LeaveRequestScreen extends GetView<LeaveRequestsTestController> {
  const LeaveRequestScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mLocaleData1 =
        OrbitClientApp.mLocale[ConfigKeysTitle.dashboardMenuScreen];
    final mLocaleData = OrbitClientApp.mLocale[ConfigKeysTitle.dashboardScreen];
    double width = Get.width;
    double height = Get.height;
    final employeeIsHR = Get.find<LoginModel>().employeeDetails!.aspNetUserId ==
        Get.find<LoginModel>().hrLeadDetails!.aspNetUserId;
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
                        icon: Icon(
                          Icons.arrow_back,
                          color: AppColors.walletColor2,
                        ),
                        title: mLocaleData1![ConfigKeysBody.dashboardMenuOne]!,
                        name: controller.pendingRequestModel!.teamMemberName,
                        post: controller.pendingRequestModel!.designation,
                      ),
                      SizedBox(height: height * 0.01),
                    ],
                  ),
                ),
                Obx(() => Padding(
                      padding: EdgeInsets.all(width * 0.04),
                      child: !controller.apiCalling.value
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: height * 0.015),
                                HrAppText(
                                  text: mLocaleData![
                                      ConfigKeysBody.dashboardBody1]!,
                                  style: HeadingTextStyles.heading4.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    fontFamily: TrueBookFontFamily.gUbuntuBold,
                                  ),
                                ),
                                SizedBox(height: height * 0.01),
                                Obx(() => LeavesCalculationContainer(
                                      text2: controller
                                                  .currentMonthAttendanceModel
                                                  .value
                                                  .previousMonthHours !=
                                              null
                                          ? controller
                                              .currentMonthAttendanceModel
                                              .value
                                              .previousMonthHours!
                                              .totalHours!
                                              .toString()
                                          : '',
                                      text3: controller
                                                  .currentMonthAttendanceModel
                                                  .value
                                                  .perviousMonthLeaves !=
                                              null
                                          ? controller
                                              .currentMonthAttendanceModel
                                              .value
                                              .perviousMonthLeaves!
                                              .length
                                          : 0,
                                    )),
                                SizedBox(height: height * 0.03),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller
                                      .currentMonthAttendanceModel
                                      .value
                                      .leavesData!
                                      .length,
                                  itemBuilder: (context, index) {
                                    print('asdasda => $index');
                                    final LeavesData unApprovedLeaves =
                                        controller.currentMonthAttendanceModel
                                            .value.leavesData![index];
                                    final showItemToTL = !employeeIsHR &&
                                        (unApprovedLeaves
                                                .isApprovedByTL!.isNotEmpty ||
                                            unApprovedLeaves
                                                .isRejectedByTL!.isNotEmpty);
                                    final showItemToHR = employeeIsHR &&
                                        (unApprovedLeaves
                                                .isRejectedByHR!.isNotEmpty ||
                                            unApprovedLeaves
                                                .isApprovedByHR!.isNotEmpty ||
                                            (unApprovedLeaves
                                                    .isRejectedByTL!.isNotEmpty &&
                                                unApprovedLeaves
                                                    .isApprovedByTL!.isEmpty &&
                                                (unApprovedLeaves
                                                        .isRejectedByTL!
                                                        .isNotEmpty ||
                                                    unApprovedLeaves
                                                        .isApprovedByHR!
                                                        .isNotEmpty)));
                                    if (showItemToTL || showItemToHR) {
                                      return SizedBox();
                                    }
                                    return Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: height * 0.009),
                                        child: Obx(
                                          () => LeaveTypeContainer(
                                            progress: controller.progress.value,
                                            onTap: () async {
                                              await controller.downloadImage(
                                                  unApprovedLeaves);
                                            },
                                            controller: controller,
                                            unApprovedLEavesDtos:
                                                unApprovedLeaves,
                                            index: index,
                                          ),
                                        ));
                                  },
                                ),
                                SizedBox(height: height * 0.01),
                                HrAppText(
                                  text: mLocaleData[
                                      ConfigKeysBody.dashboardBody8]!,
                                  style: HeadingTextStyles.heading4.copyWith(
                                    color: AppColors.descriptionColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    fontFamily: TrueBookFontFamily.gUbuntuBold,
                                  ),
                                ),
                                SizedBox(height: height * 0.01),
                                Obx(
                                  () => controller.apiCalling.value
                                      ? const SpecialContainer()
                                      : TimeSheetWidget(
                                          employees: controller.attendanceList,
                                        ),
                                ),
                              ],
                            )
                          : const Center(child: HrCircularprogressindicator()),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
