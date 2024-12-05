import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/config/config_keys_body.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/controllers/leave_history_controller_test.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/dynamic_height_container.dart';
import 'package:orbit/widgets/header_container_design.dart';
import 'package:orbit/widgets/hr_app_text.dart';
import 'package:orbit/widgets/special_container.dart';
import 'package:intl/intl.dart';
import '../widgets/reusable_profile_widget.dart';

class LeaveHistoryScreen extends GetView<LeaveHistoryControllerTest> {
  const LeaveHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    final mLocaleData =
        OrbitClientApp.mLocale[ConfigKeysTitle.leaveHistoryScreen];

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: controller.refreshPage,
        child: SingleChildScrollView(
          child: Column(
            children: [
              HeaderContainerDesign(
                child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(width * 0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ReusableProfileWidget(
                              title: mLocaleData![
                                  ConfigKeysBody.leaveHistoryContainerr]!,
                              name: controller.preferencesController
                                  .employeeDetails!.employeeName,
                              post: controller.preferencesController
                                  .employeeDetails!.designation,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                              topRight: Radius.circular(60),
                            ),
                          ),
                          child: Obx(() {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: height * 0.03,
                                  horizontal: width * 0.05),
                              child: controller.apiCalling.value
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        HrAppText(
                                          text: mLocaleData[ConfigKeysBody
                                              .leaveHistoryContainer]!,
                                          style: HeadingTextStyles.heading4
                                              .copyWith(
                                                  color: AppColors.payment1,
                                                  fontFamily: TrueBookFontFamily
                                                      .gUbuntuMedium),
                                        ),
                                        SizedBox(
                                          height: height * 0.02,
                                        ),
                                        Container(
                                          height: height * 0.1,
                                          width: width * 0.9,
                                          decoration: BoxDecoration(
                                              color:
                                                  AppColors.primaryColor.value,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  HrAppText(
                                                    text: mLocaleData[ConfigKeysBody
                                                        .leaveHistoryContainer1]!,
                                                    style: HeadingTextStyles
                                                        .heading2
                                                        .copyWith(
                                                            color: AppColors
                                                                .walletColor2,
                                                            fontFamily:
                                                                TrueBookFontFamily
                                                                    .gUbuntuMedium),
                                                  ),
                                                  HrAppText(
                                                    text: controller.leaveHistory !=
                                                                null &&
                                                            controller
                                                                .leaveHistory!
                                                                .previousLeaveHistory!
                                                                .isNotEmpty
                                                        ? '${controller.leaveHistory!.previousLeaveHistory!.map((leave) => leave.totalLeaves ?? 0).reduce((sum, current) => sum + current)}'
                                                        : '0',
                                                    style: HeadingTextStyles
                                                        .heading2
                                                        .copyWith(
                                                      color: AppColors
                                                          .walletColor2,
                                                      fontFamily:
                                                          TrueBookFontFamily
                                                              .gUbuntuMedium,
                                                    ),
                                                  )
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  HrAppText(
                                                    text: mLocaleData[ConfigKeysBody
                                                        .leaveHistoryContainer3]!,
                                                    style: HeadingTextStyles
                                                        .heading2
                                                        .copyWith(
                                                            color: AppColors
                                                                .walletColor2,
                                                            fontFamily:
                                                                TrueBookFontFamily
                                                                    .gUbuntuMedium),
                                                  ),
                                                  HrAppText(
                                                    text: controller.leaveHistory !=
                                                                null &&
                                                            controller
                                                                .leaveHistory!
                                                                .previousLeaveHistory!
                                                                .isNotEmpty
                                                        ? '${controller.leaveHistory!.previousLeaveHistory!.map((leave) => leave.remainingLeaves ?? 0).reduce((sum, current) => sum + current)}'
                                                        : '0',
                                                    style: HeadingTextStyles
                                                        .heading2
                                                        .copyWith(
                                                      color: AppColors
                                                          .walletColor2,
                                                      fontFamily:
                                                          TrueBookFontFamily
                                                              .gUbuntuMedium,
                                                    ),
                                                  )
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  HrAppText(
                                                    text:
                                                        '${DateFormat('MMMM').format(DateTime.now())} Month',
                                                    // text: mLocaleData[ConfigKeysBody
                                                    //     .leaveHistoryContainer5]!,
                                                    style: HeadingTextStyles
                                                        .heading2
                                                        .copyWith(
                                                            color: AppColors
                                                                .walletColor2,
                                                            fontFamily:
                                                                TrueBookFontFamily
                                                                    .gUbuntuMedium),
                                                  ),
                                                  HrAppText(
                                                    text:
                                                        '${controller.leaveHistory != null ? controller.leaveHistory!.thisMonthLeaveCount : '0 '} Leaves',
                                                    style: HeadingTextStyles
                                                        .heading2
                                                        .copyWith(
                                                            color: AppColors
                                                                .walletColor2,
                                                            fontFamily:
                                                                TrueBookFontFamily
                                                                    .gUbuntuMedium),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.02,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            HrAppText(
                                              text: mLocaleData[ConfigKeysBody
                                                  .leaveHistoryContainer7]!,
                                              style: HeadingTextStyles.heading6
                                                  .copyWith(
                                                      color: AppColors.payment1,
                                                      fontFamily:
                                                          TrueBookFontFamily
                                                              .gUbuntuMedium),
                                            ),
                                            SizedBox(
                                              height: height * 0.02,
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: width * 0.03),
                                              height: height * 0.05,
                                              width: width * 0.9,
                                              decoration: BoxDecoration(
                                                  color: AppColors
                                                      .primaryColor.value,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  HrAppText(
                                                    text:
                                                        '${controller.leaveHistory != null ? controller.leaveHistory!.previousLeaveHistory![0].leaveTypeName : 'Casual Leave'}',
                                                    style: HeadingTextStyles
                                                        .heading6
                                                        .copyWith(
                                                            color: AppColors
                                                                .walletColor2,
                                                            fontFamily:
                                                                TrueBookFontFamily
                                                                    .gUbuntuBold),
                                                  ),
                                                  Row(
                                                    children: [
                                                      HrAppText(
                                                        text: mLocaleData[
                                                            ConfigKeysBody
                                                                .leaveHistoryContainer9]!,
                                                        style: HeadingTextStyles
                                                            .heading2
                                                            .copyWith(
                                                          color: AppColors
                                                              .walletColor2,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: width * 0.02,
                                                      ),
                                                      Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: height * 0.025,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    width *
                                                                        0.015),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: HrAppText(
                                                          text:
                                                              '${controller.leaveHistory != null ? controller.leaveHistory!.previousLeaveHistory![0].availed : '0'} out of ${controller.leaveHistory != null ? controller.leaveHistory!.previousLeaveHistory![0].totalLeaves : '0'}',
                                                          style: HeadingTextStyles
                                                              .heading3
                                                              .copyWith(
                                                                  color: AppColors
                                                                      .payment1,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.01,
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: width * 0.03),
                                              height: height * 0.05,
                                              width: width * 0.9,
                                              decoration: BoxDecoration(
                                                  color: AppColors
                                                      .primaryColor.value,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  HrAppText(
                                                    text:
                                                        '${controller.leaveHistory != null ? controller.leaveHistory!.previousLeaveHistory![1].leaveTypeName : ''}',
                                                    style: HeadingTextStyles
                                                        .heading6
                                                        .copyWith(
                                                            color: AppColors
                                                                .walletColor2,
                                                            fontFamily:
                                                                TrueBookFontFamily
                                                                    .gUbuntuBold),
                                                  ),
                                                  Row(
                                                    children: [
                                                      HrAppText(
                                                        text: mLocaleData[
                                                            ConfigKeysBody
                                                                .leaveHistoryContainer9]!,
                                                        style: HeadingTextStyles
                                                            .heading2
                                                            .copyWith(
                                                          color: AppColors
                                                              .walletColor2,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: width * 0.02,
                                                      ),
                                                      Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: height * 0.025,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    width *
                                                                        0.015),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: HrAppText(
                                                          text: controller
                                                                      .leaveHistory !=
                                                                  null
                                                              ? controller
                                                                          .leaveHistory!
                                                                          .previousLeaveHistory![
                                                                              1]
                                                                          .availed ==
                                                                      0
                                                                  ? '${controller.leaveHistory!.previousLeaveHistory![1].availed}'
                                                                  : '${controller.leaveHistory!.previousLeaveHistory![1].availed} out of ${controller.leaveHistory!.previousLeaveHistory![1].totalLeaves}'
                                                              : '',
                                                          style: HeadingTextStyles
                                                              .heading3
                                                              .copyWith(
                                                                  color: AppColors
                                                                      .payment1,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.01,
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: width * 0.03),
                                              height: height * 0.05,
                                              width: width * 0.9,
                                              decoration: BoxDecoration(
                                                  color: AppColors
                                                      .primaryColor.value,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  HrAppText(
                                                    text:
                                                        '${controller.leaveHistory?.previousLeaveHistory != null && controller.leaveHistory?.previousLeaveHistory != [] ? controller.leaveHistory!.previousLeaveHistory![1].leaveTypeName : ''}',
                                                    style: HeadingTextStyles
                                                        .heading6
                                                        .copyWith(
                                                            color: AppColors
                                                                .walletColor2,
                                                            fontFamily:
                                                                TrueBookFontFamily
                                                                    .gUbuntuBold),
                                                  ),
                                                  Row(
                                                    children: [
                                                      HrAppText(
                                                        text: mLocaleData[
                                                            ConfigKeysBody
                                                                .leaveHistoryContainer9]!,
                                                        style: HeadingTextStyles
                                                            .heading2
                                                            .copyWith(
                                                          color: AppColors
                                                              .walletColor2,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: width * 0.02,
                                                      ),
                                                      Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: height * 0.025,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    width *
                                                                        0.015),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: HrAppText(
                                                          text:
                                                              '${(controller.leaveHistory?.previousLeaveHistory != null && controller.leaveHistory!.previousLeaveHistory!.length > 2 && controller.leaveHistory!.previousLeaveHistory?[2] != null) ? controller.leaveHistory!.previousLeaveHistory![2].availed : '0'} out of ${(controller.leaveHistory?.previousLeaveHistory != null && controller.leaveHistory!.previousLeaveHistory!.length > 2) ? controller.leaveHistory!.previousLeaveHistory![2].totalLeaves : '0'}',
                                                          style: HeadingTextStyles
                                                              .heading3
                                                              .copyWith(
                                                                  color: AppColors
                                                                      .payment1,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.01,
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: width * 0.03),
                                              height: height * 0.05,
                                              width: width * 0.9,
                                              decoration: BoxDecoration(
                                                  color: AppColors
                                                      .primaryColor.value,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  HrAppText(
                                                    text:
                                                        '${(controller.leaveHistory?.previousLeaveHistory != null && controller.leaveHistory!.previousLeaveHistory!.length > 3 && controller.leaveHistory!.previousLeaveHistory?[3] != null) ? controller.leaveHistory!.previousLeaveHistory![3].leaveTypeName : ''}',
                                                    style: HeadingTextStyles
                                                        .heading6
                                                        .copyWith(
                                                            color: AppColors
                                                                .walletColor2,
                                                            fontFamily:
                                                                TrueBookFontFamily
                                                                    .gUbuntuBold),
                                                  ),
                                                  Row(
                                                    children: [
                                                      HrAppText(
                                                        text: mLocaleData[
                                                            ConfigKeysBody
                                                                .leaveHistoryContainer9]!,
                                                        style: HeadingTextStyles
                                                            .heading2
                                                            .copyWith(
                                                          color: AppColors
                                                              .walletColor2,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: width * 0.02,
                                                      ),
                                                      Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: height * 0.025,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    width *
                                                                        0.015),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: HrAppText(
                                                          text: (controller
                                                                          .leaveHistory
                                                                          ?.previousLeaveHistory !=
                                                                      null &&
                                                                  controller
                                                                          .leaveHistory!
                                                                          .previousLeaveHistory!
                                                                          .length >
                                                                      3 &&
                                                                  controller.leaveHistory!
                                                                              .previousLeaveHistory?[
                                                                          3] !=
                                                                      null)
                                                              ? (controller
                                                                          .leaveHistory!
                                                                          .previousLeaveHistory![
                                                                              3]
                                                                          .availed ==
                                                                      0
                                                                  ? '${controller.leaveHistory!.previousLeaveHistory![3].availed}'
                                                                  : '${controller.leaveHistory!.previousLeaveHistory![3].availed} out of ${controller.leaveHistory!.previousLeaveHistory![3].totalLeaves}')
                                                              : '',
                                                          style: HeadingTextStyles
                                                              .heading3
                                                              .copyWith(
                                                                  color: AppColors
                                                                      .payment1,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.01,
                                            ),
                                            // if (controller
                                            //         .leaveHistory!
                                            //         .previousLeaveHistory!
                                            //         .length >
                                            //     4)
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: width * 0.03),
                                              height: height * 0.05,
                                              width: width * 0.9,
                                              decoration: BoxDecoration(
                                                  color: AppColors
                                                      .primaryColor.value,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  HrAppText(
                                                    text:
                                                        '${(controller.leaveHistory?.previousLeaveHistory != null && controller.leaveHistory!.previousLeaveHistory!.length > 4 && controller.leaveHistory!.previousLeaveHistory?[4] != null) ? controller.leaveHistory!.previousLeaveHistory![4].leaveTypeName : ''}',
                                                    style: HeadingTextStyles
                                                        .heading6
                                                        .copyWith(
                                                            color: AppColors
                                                                .walletColor2,
                                                            fontFamily:
                                                                TrueBookFontFamily
                                                                    .gUbuntuBold),
                                                  ),
                                                  Row(
                                                    children: [
                                                      HrAppText(
                                                        text: mLocaleData[
                                                            ConfigKeysBody
                                                                .leaveHistoryContainer9]!,
                                                        style: HeadingTextStyles
                                                            .heading2
                                                            .copyWith(
                                                          color: AppColors
                                                              .walletColor2,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: width * 0.02,
                                                      ),
                                                      Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: height * 0.025,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    width *
                                                                        0.015),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: HrAppText(
                                                          text: (controller
                                                                          .leaveHistory
                                                                          ?.previousLeaveHistory !=
                                                                      null &&
                                                                  controller
                                                                          .leaveHistory!
                                                                          .previousLeaveHistory!
                                                                          .length >
                                                                      4 &&
                                                                  controller
                                                                          .leaveHistory!
                                                                          .previousLeaveHistory?[4] !=
                                                                      null)
                                                              ? '${controller.leaveHistory!.previousLeaveHistory![4].availed} out of ${controller.leaveHistory!.previousLeaveHistory![4].totalLeaves}'
                                                              : '0 out of 0',
                                                          style: HeadingTextStyles
                                                              .heading3
                                                              .copyWith(
                                                                  color: AppColors
                                                                      .payment1,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height * 0.02,
                                        ),
                                        HrAppText(
                                          text: mLocaleData[ConfigKeysBody
                                              .leaveHistoryContainer18]!,
                                          style: HeadingTextStyles.heading4
                                              .copyWith(
                                                  color: AppColors.payment1,
                                                  fontFamily: TrueBookFontFamily
                                                      .gUbuntuMedium),
                                        ),
                                        SizedBox(
                                          height: height * 0.03,
                                        ),
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
                                                  style: HeadingTextStyles
                                                      .heading2
                                                      .copyWith(
                                                    color: Colors.white,
                                                    fontFamily:
                                                        TrueBookFontFamily
                                                            .gUbuntuBold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: height * 0.007),
                                            Column(
                                              children: [
                                                controller.leaveHistory !=
                                                            null &&
                                                        controller.approvedByTL
                                                            .isEmpty
                                                    ? const SpecialContainer(
                                                        height: 0.08)
                                                    : ListView.builder(
                                                        shrinkWrap: true,
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        itemCount: controller
                                                            .approvedByTL
                                                            .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          var leaveHistory =
                                                              controller
                                                                      .approvedByTL[
                                                                  index];
                                                          var leaveType =
                                                              leaveHistory
                                                                  .leaveCatName;
                                                          var startTime =
                                                              leaveHistory
                                                                  .startTime;
                                                          var endTime =
                                                              leaveHistory
                                                                  .endTime;
                                                          var date = leaveHistory
                                                              .leaveRequestCreatedDateTime!;
                                                          print(leaveHistory
                                                              .teamLeadComments);
                                                          return Obx(
                                                              () => Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            height *
                                                                                0.009),
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap: () => controller.toggleExpanded(
                                                                          index,
                                                                          listType:
                                                                              'approvedByTL'),
                                                                      child:
                                                                          DynamicHeightContainer(
                                                                        comments:
                                                                            leaveHistory.employeeComments,
                                                                        teamLeadComment:
                                                                            leaveHistory.teamLeadComments,
                                                                        hrComments:
                                                                            leaveHistory.hrComments,
                                                                        attachment: leaveHistory.attachment != null &&
                                                                                leaveHistory.attachment!.isNotEmpty
                                                                            ? true
                                                                            : false,
                                                                        progress: controller
                                                                            .progress
                                                                            .value,
                                                                        onTapDownload:
                                                                            () async {
                                                                          await controller
                                                                              .downloadImage(leaveHistory);
                                                                        },
                                                                        days: date.substring(
                                                                            0,
                                                                            min(date.length,
                                                                                10)),
                                                                        dates: controller
                                                                            .approvedByTL[index]
                                                                            .isApprovedByTl,
                                                                        index:
                                                                            index,
                                                                        expandedIndex: controller.expandedIndexForApprovedByTL.value ==
                                                                                index
                                                                            ? index
                                                                            : -1,
                                                                        leaveReason:
                                                                            '${leaveHistory.leaveTypeName}',
                                                                        leaveType: startTime != null &&
                                                                                startTime != '' &&
                                                                                endTime != null &&
                                                                                endTime != ''
                                                                            ? '$leaveType From $startTime $endTime'
                                                                            : '$leaveType',
                                                                        date:
                                                                            '${mLocaleData[ConfigKeysBody.leaveHistoryContainer19]!} ${(date.substring(0, min(date.length, 10)))}',
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
                                                  style: HeadingTextStyles
                                                      .heading2
                                                      .copyWith(
                                                    color: Colors.white,
                                                    fontFamily:
                                                        TrueBookFontFamily
                                                            .gUbuntuBold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: height * 0.007),
                                            Column(
                                              children: [
                                                controller.leaveHistory !=
                                                            null &&
                                                        controller.rejectedByTL
                                                            .isEmpty
                                                    ? const SpecialContainer(
                                                        height: 0.08)
                                                    : ListView.builder(
                                                        shrinkWrap: true,
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        itemCount: controller
                                                            .rejectedByTL
                                                            .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          var leaveHistory =
                                                              controller
                                                                      .rejectedByTL[
                                                                  index];
                                                          var leaveType =
                                                              leaveHistory
                                                                  .leaveCatName;
                                                          var startTime =
                                                              leaveHistory
                                                                  .startTime;
                                                          var endTime =
                                                              leaveHistory
                                                                  .endTime;
                                                          var date = leaveHistory
                                                              .leaveRequestCreatedDateTime!;

                                                          return Obx(
                                                              () => Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            height *
                                                                                0.009),
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap: () => controller.toggleExpanded(
                                                                          index,
                                                                          listType:
                                                                              'rejectedByTL'),
                                                                      child:
                                                                          DynamicHeightContainer(
                                                                        progress: controller
                                                                            .progress
                                                                            .value,
                                                                        comments:
                                                                            leaveHistory.employeeComments,
                                                                        teamLeadComment:
                                                                            leaveHistory.teamLeadComments,
                                                                        hrComments:
                                                                            leaveHistory.hrComments,
                                                                        attachment: leaveHistory.attachment != null &&
                                                                                leaveHistory.attachment!.isNotEmpty
                                                                            ? true
                                                                            : false,
                                                                        onTapDownload:
                                                                            () async {
                                                                          await controller
                                                                              .downloadImage(leaveHistory);
                                                                        },
                                                                        days: date.substring(
                                                                            0,
                                                                            min(date.length,
                                                                                10)),
                                                                        index:
                                                                            index,
                                                                        expandedIndex: controller.expandedIndexForRejectedByTL.value ==
                                                                                index
                                                                            ? index
                                                                            : -1,
                                                                        dates: controller
                                                                            .rejectedByTL[index]
                                                                            .isRejectedByTl,
                                                                        leaveReason:
                                                                            '${leaveHistory.leaveTypeName}',
                                                                        leaveType: startTime != null &&
                                                                                startTime != '' &&
                                                                                endTime != null &&
                                                                                endTime != ''
                                                                            ? '$leaveType From $startTime $endTime'
                                                                            : '$leaveType',
                                                                        date:
                                                                            '${mLocaleData[ConfigKeysBody.leaveHistoryContainer19]!} ${(date.substring(0, min(date.length, 10)))}',
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
                                                  style: HeadingTextStyles
                                                      .heading2
                                                      .copyWith(
                                                    color: Colors.white,
                                                    fontFamily:
                                                        TrueBookFontFamily
                                                            .gUbuntuBold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: height * 0.007),
                                            Column(
                                              children: [
                                                controller.leaveHistory !=
                                                            null &&
                                                        controller.approvedByHR
                                                            .isEmpty
                                                    ? const SpecialContainer(
                                                        height: 0.08)
                                                    : ListView.builder(
                                                        shrinkWrap: true,
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        itemCount: controller
                                                            .approvedByHR
                                                            .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          var leaveHistory =
                                                              controller
                                                                      .approvedByHR[
                                                                  index];
                                                          print(
                                                              'approvedByHr => ${leaveHistory}');
                                                          var leaveType =
                                                              leaveHistory
                                                                  .leaveCatName;
                                                          var startTime =
                                                              leaveHistory
                                                                  .startTime;
                                                          var endTime =
                                                              leaveHistory
                                                                  .endTime;
                                                          var date = leaveHistory
                                                              .leaveRequestCreatedDateTime!;
                                                          // var approvedLeaves =
                                                          //     controller
                                                          //             .leaveHistory!
                                                          //             .leaveHistoryDetails![
                                                          //         index];
                                                          return Obx(
                                                              () => Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            height *
                                                                                0.009),
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap: () => controller.toggleExpanded(
                                                                          index,
                                                                          listType:
                                                                              'approvedByHR'),
                                                                      child:
                                                                          DynamicHeightContainer(
                                                                        progress: controller
                                                                            .progress
                                                                            .value,
                                                                        comments:
                                                                            leaveHistory.employeeComments,
                                                                        teamLeadComment:
                                                                            leaveHistory.teamLeadComments,
                                                                        hrComments:
                                                                            leaveHistory.hrComments,
                                                                        attachment: leaveHistory.attachment != null &&
                                                                                leaveHistory.attachment!.isNotEmpty
                                                                            ? true
                                                                            : false,
                                                                        onTapDownload:
                                                                            () async {
                                                                          await controller
                                                                              .downloadImage(leaveHistory);
                                                                        },
                                                                        days: date.substring(
                                                                            0,
                                                                            min(date.length,
                                                                                10)),
                                                                        index:
                                                                            index,
                                                                        dates: controller
                                                                            .approvedByHR[index]
                                                                            .isApprovedByHr,
                                                                        expandedIndex: controller.expandedIndexForApprovedByHR.value ==
                                                                                index
                                                                            ? index
                                                                            : -1,
                                                                        leaveReason:
                                                                            '${leaveHistory.leaveTypeName}',
                                                                        leaveType: startTime != null &&
                                                                                startTime != '' &&
                                                                                endTime != null &&
                                                                                endTime != ''
                                                                            ? '$leaveType From $startTime $endTime'
                                                                            : '$leaveType',
                                                                        date:
                                                                            '${mLocaleData[ConfigKeysBody.leaveHistoryContainer19]!} ${(date.substring(0, min(date.length, 10)))}',
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
                                                  style: HeadingTextStyles
                                                      .heading2
                                                      .copyWith(
                                                    color: Colors.white,
                                                    fontFamily:
                                                        TrueBookFontFamily
                                                            .gUbuntuBold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: height * 0.007),
                                            Column(
                                              children: [
                                                controller.leaveHistory !=
                                                            null &&
                                                        controller.rejectedByHR
                                                            .isEmpty
                                                    ? const SpecialContainer(
                                                        height: 0.08)
                                                    : ListView.builder(
                                                        shrinkWrap: true,
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        itemCount: controller
                                                            .rejectedByHR
                                                            .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          var leaveHistory =
                                                              controller
                                                                      .rejectedByHR[
                                                                  index];
                                                          var leaveType =
                                                              leaveHistory
                                                                  .leaveCatName;
                                                          var startTime =
                                                              leaveHistory
                                                                  .startTime;
                                                          var endTime =
                                                              leaveHistory
                                                                  .endTime;
                                                          var date = leaveHistory
                                                              .leaveRequestCreatedDateTime!;

                                                          return Obx(
                                                              () => Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            height *
                                                                                0.009),
                                                                    child:
                                                                        GestureDetector(
                                                                      onTap: () => controller.toggleExpanded(
                                                                          index,
                                                                          listType:
                                                                              'rejectedByHR'),
                                                                      child:
                                                                          DynamicHeightContainer(
                                                                        progress: controller
                                                                            .progress
                                                                            .value,
                                                                        comments:
                                                                            leaveHistory.employeeComments,
                                                                        teamLeadComment:
                                                                            leaveHistory.teamLeadComments,
                                                                        hrComments:
                                                                            leaveHistory.hrComments,
                                                                        attachment: leaveHistory.attachment != null &&
                                                                                leaveHistory.attachment!.isNotEmpty
                                                                            ? true
                                                                            : false,
                                                                        onTapDownload:
                                                                            () async {
                                                                          await controller
                                                                              .downloadImage(leaveHistory);
                                                                        },
                                                                        days: date.substring(
                                                                            0,
                                                                            min(date.length,
                                                                                10)),
                                                                        index:
                                                                            index,
                                                                        expandedIndex: controller.expandedIndexForRejectedByHR.value ==
                                                                                index
                                                                            ? index
                                                                            : -1,
                                                                        dates: controller
                                                                            .rejectedByHR[index]
                                                                            .isRejectedByHr,
                                                                        leaveReason:
                                                                            '${leaveHistory.leaveTypeName}',
                                                                        leaveType: startTime != null &&
                                                                                startTime != '' &&
                                                                                endTime != null &&
                                                                                endTime != ''
                                                                            ? '$leaveType From $startTime $endTime'
                                                                            : '$leaveType',
                                                                        date:
                                                                            '${mLocaleData[ConfigKeysBody.leaveHistoryContainer19]!} ${(date.substring(0, min(date.length, 10)))}',
                                                                      ),
                                                                    ),
                                                                  ));
                                                        }),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                            );
                          }))
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
