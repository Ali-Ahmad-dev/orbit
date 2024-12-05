import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/config/config_keys_body.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/controllers/employee_leave_history_controller.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/dynamic_height_container.dart';
import 'package:orbit/widgets/header_container_design.dart';
import 'package:orbit/widgets/reusable_profile_widget.dart';
import 'package:orbit/widgets/hr_app_text.dart';
import 'package:orbit/widgets/hr_circularprogressindicator.dart';
import 'package:orbit/widgets/leaves_calculation_container.dart';
import 'package:orbit/widgets/special_container.dart';

class EmployeeLeaveHistoryScreen
    extends GetView<EmployeeLeaveHistoryController> {
  const EmployeeLeaveHistoryScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mLocaleData = OrbitClientApp.mLocale[ConfigKeysTitle.dashboardScreen];
    final mLocaleData2 =
        OrbitClientApp.mLocale[ConfigKeysTitle.leaveHistoryScreen];
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
                        icon: Icon(
                          Icons.arrow_back,
                          color: AppColors.walletColor2,
                        ),
                        title: 'Leave History',
                        name: controller.pendingRequestModel!.teamMemberName,
                        post: controller.pendingRequestModel!.designation,
                      ),
                      SizedBox(height: height * 0.01),
                    ],
                  ),
                ),
                Obx(() => Container(
                      width: !controller.apiCalling.value
                          ? MediaQuery.of(context).size.width
                          : null,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60),
                        ),
                      ),
                      child: Padding(
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
                                      color: AppColors.descriptionColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      fontFamily:
                                          TrueBookFontFamily.gUbuntuBold,
                                    ),
                                  ),
                                  SizedBox(height: height * 0.01),
                                  LeavesCalculationContainer(
                                    text2: controller.preferencesController
                                        .currentMonthHours!.totalHours!
                                        .toStringAsFixed(2),
                                    text3: controller.preferencesController
                                        .currentMonthLeaves,
                                  ),
                                  SizedBox(height: height * 0.03),
                                  HrAppText(
                                    text: mLocaleData2![ConfigKeysBody
                                        .leaveHistoryContainer18]!,
                                    style: HeadingTextStyles.heading4.copyWith(
                                        color: AppColors.payment1,
                                        fontFamily:
                                            TrueBookFontFamily.gUbuntuMedium),
                                  ),
                                  SizedBox(height: height * 0.03),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: width,
                                        padding: EdgeInsets.symmetric(
                                            vertical: height * 0.01),
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                          child: HrAppText(
                                            text: 'Approved By Team Lead',
                                            style: HeadingTextStyles.heading2
                                                .copyWith(
                                              color: Colors.white,
                                              fontFamily: TrueBookFontFamily
                                                  .gUbuntuBold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: height * 0.007),
                                      Column(
                                        children: [
                                          controller.leaveHistory != null &&
                                                  controller
                                                      .approvedByTL.isEmpty
                                              ? const SpecialContainer(
                                                  height: 0.08)
                                              : ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount: controller
                                                      .approvedByTL.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    var leaveHistory =
                                                        controller.approvedByTL[
                                                            index];
                                                    var leaveType = leaveHistory
                                                        .leaveCatName;
                                                    var startTime =
                                                        leaveHistory.startTime;
                                                    var endTime =
                                                        leaveHistory.endTime;
                                                    var date = leaveHistory
                                                        .leaveRequestCreatedDateTime!;
                                                    print(leaveHistory
                                                        .teamLeadComments);
                                                    return Obx(() => Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      height *
                                                                          0.009),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () => controller
                                                                .toggleExpanded(
                                                                    index,
                                                                    listType:
                                                                        'approvedByTL'),
                                                            child:
                                                                DynamicHeightContainer(
                                                              comments: leaveHistory
                                                                  .employeeComments,
                                                              teamLeadComment:
                                                                  leaveHistory
                                                                      .teamLeadComments,
                                                              hrComments:
                                                                  leaveHistory
                                                                      .hrComments,
                                                              attachment: leaveHistory
                                                                              .attachment !=
                                                                          null &&
                                                                      leaveHistory
                                                                          .attachment!
                                                                          .isNotEmpty
                                                                  ? true
                                                                  : false,
                                                              progress:
                                                                  controller
                                                                      .progress
                                                                      .value,
                                                              onTapDownload:
                                                                  () async {
                                                                await controller
                                                                    .downloadImage(
                                                                        leaveHistory);
                                                              },
                                                              days: date.substring(
                                                                  0,
                                                                  min(date.length,
                                                                      10)),
                                                              dates: controller
                                                                  .approvedByTL[
                                                                      index]
                                                                  .isApprovedByTl,
                                                              index: index,
                                                              expandedIndex:
                                                                  controller.expandedIndexForApprovedByTL
                                                                              .value ==
                                                                          index
                                                                      ? index
                                                                      : -1,
                                                              leaveReason:
                                                                  '${leaveHistory.leaveTypeName}',
                                                              leaveType: startTime != null &&
                                                                      startTime !=
                                                                          '' &&
                                                                      endTime !=
                                                                          null &&
                                                                      endTime !=
                                                                          ''
                                                                  ? '$leaveType From $startTime $endTime'
                                                                  : '$leaveType',
                                                              date:
                                                                  '${mLocaleData2[ConfigKeysBody.leaveHistoryContainer19]!} ${(date.substring(0, min(date.length, 10)))}',
                                                            ),
                                                          ),
                                                        ));
                                                  }),
                                        ],
                                      ),
                                      SizedBox(height: height * 0.02),
                                      Container(
                                        width: width,
                                        padding: EdgeInsets.symmetric(
                                            vertical: height * 0.01),
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                          child: HrAppText(
                                            text: 'Rejected By Team Lead',
                                            style: HeadingTextStyles.heading2
                                                .copyWith(
                                              color: Colors.white,
                                              fontFamily: TrueBookFontFamily
                                                  .gUbuntuBold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: height * 0.007),
                                      Column(
                                        children: [
                                          controller.leaveHistory != null &&
                                                  controller
                                                      .rejectedByTL.isEmpty
                                              ? const SpecialContainer(
                                                  height: 0.08)
                                              : ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount: controller
                                                      .rejectedByTL.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    var leaveHistory =
                                                        controller.rejectedByTL[
                                                            index];
                                                    var leaveType = leaveHistory
                                                        .leaveCatName;
                                                    var startTime =
                                                        leaveHistory.startTime;
                                                    var endTime =
                                                        leaveHistory.endTime;
                                                    var date = leaveHistory
                                                        .leaveRequestCreatedDateTime!;

                                                    // var approvedLeaves = controller
                                                    //         .leaveHistory!
                                                    //         .leaveHistoryDetails![
                                                    //     index];
                                                    return Obx(() => Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      height *
                                                                          0.009),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () => controller
                                                                .toggleExpanded(
                                                                    index,
                                                                    listType:
                                                                        'rejectedByTL'),
                                                            child:
                                                                DynamicHeightContainer(
                                                              progress:
                                                                  controller
                                                                      .progress
                                                                      .value,
                                                              comments: leaveHistory
                                                                  .employeeComments,
                                                              teamLeadComment:
                                                                  leaveHistory
                                                                      .teamLeadComments,
                                                              hrComments:
                                                                  leaveHistory
                                                                      .hrComments,
                                                              attachment: leaveHistory
                                                                              .attachment !=
                                                                          null &&
                                                                      leaveHistory
                                                                          .attachment!
                                                                          .isNotEmpty
                                                                  ? true
                                                                  : false,
                                                              onTapDownload:
                                                                  () async {
                                                                await controller
                                                                    .downloadImage(
                                                                        leaveHistory);
                                                              },
                                                              days: date.substring(
                                                                  0,
                                                                  min(date.length,
                                                                      10)),
                                                              index: index,
                                                              expandedIndex:
                                                                  controller.expandedIndexForRejectedByTL
                                                                              .value ==
                                                                          index
                                                                      ? index
                                                                      : -1,
                                                              dates: controller
                                                                  .rejectedByTL[
                                                                      index]
                                                                  .isRejectedByTl,
                                                              leaveReason:
                                                                  '${leaveHistory.leaveTypeName}',
                                                              leaveType: startTime != null &&
                                                                      startTime !=
                                                                          '' &&
                                                                      endTime !=
                                                                          null &&
                                                                      endTime !=
                                                                          ''
                                                                  ? '$leaveType From $startTime $endTime'
                                                                  : '$leaveType',
                                                              date:
                                                                  '${mLocaleData2[ConfigKeysBody.leaveHistoryContainer19]!} ${(date.substring(0, min(date.length, 10)))}',
                                                            ),
                                                          ),
                                                        ));
                                                  }),
                                        ],
                                      ),
                                      SizedBox(height: height * 0.02),
                                      Container(
                                        width: width,
                                        padding: EdgeInsets.symmetric(
                                            vertical: height * 0.01),
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                          child: HrAppText(
                                            text: 'Approved By HR',
                                            style: HeadingTextStyles.heading2
                                                .copyWith(
                                              color: Colors.white,
                                              fontFamily: TrueBookFontFamily
                                                  .gUbuntuBold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: height * 0.007),
                                      Column(
                                        children: [
                                          controller.leaveHistory != null &&
                                                  controller
                                                      .approvedByHR.isEmpty
                                              ? const SpecialContainer(
                                                  height: 0.08)
                                              : ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount: controller
                                                      .approvedByHR.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    var leaveHistory =
                                                        controller.approvedByHR[
                                                            index];
                                                    var leaveType = leaveHistory
                                                        .leaveCatName;
                                                    var startTime =
                                                        leaveHistory.startTime;
                                                    var endTime =
                                                        leaveHistory.endTime;
                                                    var date = leaveHistory
                                                        .leaveRequestCreatedDateTime!;
                                                    return Obx(() => Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      height *
                                                                          0.009),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () => controller
                                                                .toggleExpanded(
                                                                    index,
                                                                    listType:
                                                                        'approvedByHR'),
                                                            child:
                                                                DynamicHeightContainer(
                                                              progress:
                                                                  controller
                                                                      .progress
                                                                      .value,
                                                              comments: leaveHistory
                                                                  .employeeComments,
                                                              teamLeadComment:
                                                                  leaveHistory
                                                                      .teamLeadComments,
                                                              hrComments:
                                                                  leaveHistory
                                                                      .hrComments,
                                                              attachment: leaveHistory
                                                                              .attachment !=
                                                                          null &&
                                                                      leaveHistory
                                                                          .attachment!
                                                                          .isNotEmpty
                                                                  ? true
                                                                  : false,
                                                              onTapDownload:
                                                                  () async {
                                                                await controller
                                                                    .downloadImage(
                                                                        leaveHistory);
                                                              },
                                                              days: date.substring(
                                                                  0,
                                                                  min(date.length,
                                                                      10)),
                                                              index: index,
                                                              dates: controller
                                                                  .approvedByHR[
                                                                      index]
                                                                  .isApprovedByHr,
                                                              expandedIndex:
                                                                  controller.expandedIndexForApprovedByHR
                                                                              .value ==
                                                                          index
                                                                      ? index
                                                                      : -1,
                                                              leaveReason:
                                                                  '${leaveHistory.leaveTypeName}',
                                                              leaveType: startTime != null &&
                                                                      startTime !=
                                                                          '' &&
                                                                      endTime !=
                                                                          null &&
                                                                      endTime !=
                                                                          ''
                                                                  ? '$leaveType From $startTime $endTime'
                                                                  : '$leaveType',
                                                              date:
                                                                  '${mLocaleData2[ConfigKeysBody.leaveHistoryContainer19]!} ${(date.substring(0, min(date.length, 10)))}',
                                                            ),
                                                          ),
                                                        ));
                                                  }),
                                        ],
                                      ),
                                      SizedBox(height: height * 0.02),
                                      Container(
                                        width: width,
                                        padding: EdgeInsets.symmetric(
                                            vertical: height * 0.01),
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                          child: HrAppText(
                                            text: 'Rejected By HR',
                                            style: HeadingTextStyles.heading2
                                                .copyWith(
                                              color: Colors.white,
                                              fontFamily: TrueBookFontFamily
                                                  .gUbuntuBold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: height * 0.007),
                                      Column(
                                        children: [
                                          controller.leaveHistory != null &&
                                                  controller
                                                      .rejectedByHR.isEmpty
                                              ? const SpecialContainer(
                                                  height: 0.08)
                                              : ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount: controller
                                                      .rejectedByHR.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    var leaveHistory =
                                                        controller.rejectedByHR[
                                                            index];
                                                    var leaveType = leaveHistory
                                                        .leaveCatName;
                                                    var startTime =
                                                        leaveHistory.startTime;
                                                    var endTime =
                                                        leaveHistory.endTime;
                                                    var date = leaveHistory
                                                        .leaveRequestCreatedDateTime!;

                                                    return Obx(() => Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      height *
                                                                          0.009),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () => controller
                                                                .toggleExpanded(
                                                                    index,
                                                                    listType:
                                                                        'rejectedByHR'),
                                                            child:
                                                                DynamicHeightContainer(
                                                              progress:
                                                                  controller
                                                                      .progress
                                                                      .value,
                                                              comments: leaveHistory
                                                                  .employeeComments,
                                                              teamLeadComment:
                                                                  leaveHistory
                                                                      .teamLeadComments,
                                                              hrComments:
                                                                  leaveHistory
                                                                      .hrComments,
                                                              attachment: leaveHistory
                                                                              .attachment !=
                                                                          null &&
                                                                      leaveHistory
                                                                          .attachment!
                                                                          .isNotEmpty
                                                                  ? true
                                                                  : false,
                                                              onTapDownload:
                                                                  () async {
                                                                await controller
                                                                    .downloadImage(
                                                                        leaveHistory);
                                                              },
                                                              days: date.substring(
                                                                  0,
                                                                  min(date.length,
                                                                      10)),
                                                              index: index,
                                                              expandedIndex:
                                                                  controller.expandedIndexForRejectedByHR
                                                                              .value ==
                                                                          index
                                                                      ? index
                                                                      : -1,
                                                              dates: controller
                                                                  .rejectedByHR[
                                                                      index]
                                                                  .isRejectedByHr,
                                                              leaveReason:
                                                                  '${leaveHistory.leaveTypeName}',
                                                              leaveType: startTime != null &&
                                                                      startTime !=
                                                                          '' &&
                                                                      endTime !=
                                                                          null &&
                                                                      endTime !=
                                                                          ''
                                                                  ? '$leaveType From $startTime $endTime'
                                                                  : '$leaveType',
                                                              date:
                                                                  '${mLocaleData2[ConfigKeysBody.leaveHistoryContainer19]!} ${(date.substring(0, min(date.length, 10)))}',
                                                            ),
                                                          ),
                                                        ));
                                                  }),
                                        ],
                                      ),
                                      SizedBox(
                                        height: height * 0.02,
                                      )
                                    ],
                                  ),
                                ],
                              )
                            : const Center(
                                child: HrCircularprogressindicator()),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
