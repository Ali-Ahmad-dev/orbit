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
import 'package:orbit/widgets/custom_button.dart';
import 'package:orbit/widgets/hr_app_text.dart';
import 'dynamic_dropdown.dart';

class LeaveTypeContainer extends StatelessWidget {
  // final LeaveTypeController controller = Get.put(LeaveTypeController());
  final LeavesData unApprovedLEavesDtos;
  final LeaveRequestsTestController? controller;
  final void Function()? onTap;
  final int index;
  final double? progress;
  LeaveTypeContainer({
    Key? key,
    this.onTap,
    this.progress,
    this.controller,
    required this.unApprovedLEavesDtos,
    required this.index,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final mLocaleData =
    OrbitClientApp.mLocale[ConfigKeysTitle.leaveHistoryScreen];
    final approvedByTL = controller!.approvedByTL[index];
    final approvedByHR = controller!.approvedByHR[index];
    final rejectedByTL = controller!.rejectedByTL[index];
    final rejectedByHR = controller!.rejectedByHR[index];
    final showDatesToTL = approvedByTL.isEmpty && rejectedByTL.isEmpty;
    final showDatesToHR =
        approvedByTL.isNotEmpty && approvedByHR.isEmpty && rejectedByHR.isEmpty;
    final employeeIsHR = Get.find<LoginModel>().employeeDetails!.aspNetUserId ==
        Get.find<LoginModel>().hrLeadDetails!.aspNetUserId;
    print('leaveTypeContainer => ${unApprovedLEavesDtos.teamLeadComments}');
    print('rendering => ${controller!.mainleaveDatesTitleList.length}');
    final listDatesContainer = controller!.mainleaveDatesTitleList[index];
    print('rendering2 => index:$index $listDatesContainer');
    final checkboxValues = controller!.mainCheckboxList[index];
    return Obx(() => GestureDetector(
      onTap: () => controller!.toggleExpanded(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.03, vertical: height * 0.002),
        width: width * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 1,
              offset: const Offset(0.5, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.015),
                  child: HrAppText(
                    text: controller!.createD_DATE_TIME[index],
                    style: HeadingTextStyles.heading2.copyWith(
                        color: AppColors.payment1,
                        fontWeight: FontWeight.bold,
                        fontFamily: TrueBookFontFamily.gUbuntuBold),
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  size: 26,
                )
              ],
            ),
            if (controller!.expandedIndex.value == index) ...[
              SizedBox(height: height * 0.02),
              HrAppText(
                text:
                mLocaleData?[ConfigKeysBody.leaveHistoryContainer10] ??
                    '',
                style: HeadingTextStyles.heading2.copyWith(
                    color: AppColors.payment1,
                    fontWeight: FontWeight.bold,
                    fontFamily: TrueBookFontFamily.gUbuntuBold),
              ),
              SizedBox(height: height * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.015),
                child: HrAppText(
                  text: unApprovedLEavesDtos.leaveCatName ?? 'Leave Reason',
                  style: HeadingTextStyles.heading2.copyWith(
                      color: AppColors.payment1,
                      fontFamily: TrueBookFontFamily.gUbuntuBold),
                ),
              ),
              SizedBox(height: height * 0.02),
              HrAppText(
                text:
                mLocaleData?[ConfigKeysBody.leaveHistoryContainer11] ??
                    '',
                style: HeadingTextStyles.heading2.copyWith(
                    color: AppColors.payment1,
                    fontWeight: FontWeight.bold,
                    fontFamily: TrueBookFontFamily.gUbuntuBold),
              ),
              SizedBox(height: height * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.015),
                child: HrAppText(
                  text: unApprovedLEavesDtos.leaveType == 'Short Leave' ||
                      unApprovedLEavesDtos.leaveType == 'Half Day'
                      ? '${unApprovedLEavesDtos.leaveType} from ${unApprovedLEavesDtos.startTime} ${unApprovedLEavesDtos.endTime}'
                      : unApprovedLEavesDtos.leaveType!,
                  style: HeadingTextStyles.heading2.copyWith(
                      color: AppColors.payment1,
                      fontFamily: TrueBookFontFamily.gUbuntuBold),
                ),
              ),
              SizedBox(height: height * 0.02),
              HrAppText(
                text: controller!.leaveTypeApplicationTitle[index]!,
                style: HeadingTextStyles.heading2.copyWith(
                    color: AppColors.payment1,
                    fontWeight: FontWeight.bold,
                    fontFamily: TrueBookFontFamily.gUbuntuBold),
              ),
              Wrap(
                children: listDatesContainer.map((value) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: Container(
                      height: height * 0.03,
                      padding:
                      EdgeInsets.symmetric(horizontal: width * 0.02),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(5)),
                      child: HrAppText(
                        text: value,
                        style: HeadingTextStyles.heading6.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: TrueBookFontFamily.gUbuntuBold),
                      ),
                    ),
                  );
                }).toList(),
              ),
              if (unApprovedLEavesDtos.employeECOMMENTS != null &&
                  unApprovedLEavesDtos.employeECOMMENTS!.isNotEmpty)
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.02),
                    HrAppText(
                      text: mLocaleData?[
                      ConfigKeysBody.leaveHistoryContainer13] ??
                          '',
                      style: HeadingTextStyles.heading2.copyWith(
                          color: AppColors.payment1,
                          fontWeight: FontWeight.bold,
                          fontFamily: TrueBookFontFamily.gUbuntuBold),
                    ),
                    SizedBox(height: height * 0.02),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: width * 0.015),
                      child: GestureDetector(
                        onTap: () {
                          Get.defaultDialog(
                            title: 'Leave Description',
                            middleText:
                            unApprovedLEavesDtos.employeECOMMENTS! ??
                                '',
                          );
                        },
                        child: HrAppText(
                          text: unApprovedLEavesDtos.employeECOMMENTS!,
                          style: HeadingTextStyles.heading2.copyWith(
                              color: AppColors.payment1,
                              fontFamily: TrueBookFontFamily.gUbuntuBold),
                        ),
                      ),
                    ),
                  ],
                ),
              if (unApprovedLEavesDtos.teamLeadComments != null &&
                  unApprovedLEavesDtos.teamLeadComments!.isNotEmpty
              )
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.02),
                    HrAppText(
                      text: 'Team Lead Comments',
                      style: HeadingTextStyles.heading2.copyWith(
                          color: AppColors.payment1,
                          fontWeight: FontWeight.bold,
                          fontFamily: TrueBookFontFamily.gUbuntuBold),
                    ),
                    SizedBox(height: height * 0.02),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: width * 0.015),
                      child: HrAppText(
                        text: unApprovedLEavesDtos.teamLeadComments!,
                        style: HeadingTextStyles.heading2.copyWith(
                            color: AppColors.payment1,
                            fontFamily: TrueBookFontFamily.gUbuntuBold),
                      ),
                    ),

                  ],
                ) ,
              if (unApprovedLEavesDtos.hrComments != null &&
                  unApprovedLEavesDtos.hrComments!.isNotEmpty)
                Column(
                  children: [
                    SizedBox(height: height * 0.02),
                    HrAppText(
                      text: 'Hr Comments',
                      style: HeadingTextStyles.heading2.copyWith(
                          color: AppColors.payment1,
                          fontWeight: FontWeight.bold,
                          fontFamily: TrueBookFontFamily.gUbuntuBold),
                    ),
                    SizedBox(height: height * 0.02),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: width * 0.015),
                      child: HrAppText(
                        text: unApprovedLEavesDtos.hrComments!,
                        style: HeadingTextStyles.heading2.copyWith(
                            color: AppColors.payment1,
                            fontFamily: TrueBookFontFamily.gUbuntuBold),
                      ),
                    ),
                  ],
                ),
              SizedBox(height: height * 0.02),
              if (controller!.leaveTypeHalfDayApplicationBody[index] !=
                  null &&
                  controller!
                      .leaveTypeHalfDayApplicationBody[index]!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HrAppText(
                      text: controller!
                          .leaveTypeHalfDayApplicationTitle[index]!,
                      style: HeadingTextStyles.heading2.copyWith(
                          color: AppColors.payment1,
                          fontWeight: FontWeight.bold,
                          fontFamily: TrueBookFontFamily.gUbuntuBold),
                    ),
                    SizedBox(height: height * 0.02),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: width * 0.015),
                      child: HrAppText(
                        text: controller!
                            .leaveTypeHalfDayApplicationBody[index]!,
                        style: HeadingTextStyles.heading2.copyWith(
                            color: AppColors.payment1,
                            fontFamily: TrueBookFontFamily.gUbuntuBold),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                  ],
                ),
              if (unApprovedLEavesDtos.attachment != null &&
                  unApprovedLEavesDtos.attachment!.isNotEmpty)
                Column(
                  children: [
                    GestureDetector(
                      onTap: onTap,
                      child: OrbitClientButton(
                          radius: 5,
                          apiCalled: progress! > 0.0 ? true : false,
                          color: AppColors.primaryColor.value,
                          heightBtn: 0.05,
                          title: 'Download Attachment',
                          widthBtn: 1),
                    ),
                    SizedBox(height: height * 0.02),
                  ],
                ),
              if ((employeeIsHR && showDatesToHR) ||
                  (!employeeIsHR && showDatesToTL))
                Column(
                  children: [
                    HrAppText(
                      text: 'Select Approved Leave Days',
                      style: HeadingTextStyles.heading2.copyWith(
                          color: AppColors.primaryColor.value,
                          fontWeight: FontWeight.bold,
                          fontFamily: TrueBookFontFamily.gUbuntuBold),
                    ),
                  ],
                ),
              if ((employeeIsHR && showDatesToHR) ||
                  (!employeeIsHR && showDatesToTL))
                SizedBox(height: height * 0.02),
              if ((employeeIsHR && showDatesToHR) ||
                  (!employeeIsHR && showDatesToTL))
                Wrap(
                  children: listDatesContainer.asMap().entries.map((entry) {
                    int indexMap = entry.key;
                    String valueMap = entry.value;
                    return Row(
                      children: [
                        Obx(() => Checkbox(
                          value: checkboxValues[indexMap],
                          onChanged: (value) {
                            checkboxValues[indexMap] = value!;
                            if (!value) {
                              final resultDate = DateTime.parse(
                                  listDatesContainer[indexMap]);
                              controller!.dateTimeList
                                  .remove(resultDate);
                            }
                            if (value) {
                              final resultDate = DateTime.parse(
                                  listDatesContainer[indexMap]);
                              // print(resultDate);
                              controller!.dateTimeList.add(resultDate);
                            }
                          },
                        )),
                        Container(
                          height: height * 0.03,
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.02),
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor.value,
                              borderRadius: BorderRadius.circular(5)),
                          child: HrAppText(
                            text: valueMap,
                            style: HeadingTextStyles.heading6.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: TrueBookFontFamily.gUbuntuBold),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              Obx(() => DynamicDropdownBottomSheet(
                items: controller!.approvedLeaveList
                    .map((e) => e.statusName.toString())
                    .toList(),
                selectedValue: controller!.leaveStatusMap[index] ?? 'Select Type',
                title: 'Select Type',
                heading: 'Approval Status',
                onChanged: (selectedStatusName) async {
                  controller!.leaveStatusMap[index] = selectedStatusName;
                  final selectedStatus = controller!.approvedLeaveList.firstWhere(
                        (status) => status.statusName == selectedStatusName,
                  );
                  if (selectedStatus != null) {
                    controller!.selectStatusId = selectedStatus.id!;
                  } else {
                    controller!.selectStatusId = 0;
                  }

                  print('Selected Status Name: $selectedStatusName');
                  print('Selected Status ID: ${controller!.selectStatusId}');
                },
              )),

              if ((employeeIsHR && showDatesToHR) ||
                  (!employeeIsHR && showDatesToTL))
                SizedBox(height: height * 0.02),
              if ((employeeIsHR && showDatesToHR) ||
                  (!employeeIsHR && showDatesToTL))
                HrAppText(
                  text: 'Add Comment',
                  style: HeadingTextStyles.heading6.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: TrueBookFontFamily.gUbuntuBold,
                  ),
                ),
              SizedBox(height: height * 0.02),
              if ((employeeIsHR && showDatesToHR) ||
                  (!employeeIsHR && showDatesToTL))
                SizedBox(height: height * 0.02),
              if ((employeeIsHR && showDatesToHR) ||
                  (!employeeIsHR && showDatesToTL))
                TextField(
                  controller: controller!.comments,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'Comment...',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                  style: const TextStyle(
                    fontSize: 16.0, // Customize text style as needed
                  ),
                ),
              if ((employeeIsHR && showDatesToHR) ||
                  (!employeeIsHR && showDatesToTL))
                SizedBox(height: height * 0.02),
              if ((employeeIsHR && showDatesToHR) ||
                  (!employeeIsHR && showDatesToTL))
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print(controller!.dateTimeList);
                        final commentText = controller!.comments.text;
                        print('Comments: $commentText');
                        final selectStatus = controller!.selectStatusId;
                        print(selectStatus);
                        // controller?.approveLeaves(unApprovedLEavesDtos);
                        if (controller!.dateTimeList.isNotEmpty &&
                            selectStatus != 0) {
                          print('In functions');
                          controller?.approveLeaves(unApprovedLEavesDtos);
                        } else {
                          Get.snackbar("Error",
                              "Please select dates and select approval status.",
                              snackPosition: SnackPosition.BOTTOM);
                        }
                      },
                      child: OrbitClientButton(
                        radius: 10,
                        color: AppColors.primaryColor.value,
                        heightBtn: 0.05,
                        title: 'Save',
                        widthBtn: 0.3,
                      ),
                    ),
                  ],
                )
            ],
            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    ));
  }

  List<DateTime> getDateRange(DateTime start, DateTime end) {
    List<DateTime> dateList = [];
    for (int i = 0; i <= end.difference(start).inDays; i++) {
      dateList.add(start.add(Duration(days: i)));
    }
    return dateList;
  }
}