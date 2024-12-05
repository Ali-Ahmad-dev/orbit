import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/config/config_keys_body.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/controllers/apply_leave_controller.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/apply_leave_container_one.dart';
import 'package:orbit/widgets/apply_leave_container_two.dart';
import 'package:orbit/widgets/custom_button.dart';
import 'package:orbit/widgets/dynamic_dropdown.dart';
import 'package:orbit/widgets/header_container_design.dart';
import 'package:orbit/widgets/hr_app_text.dart';
import 'package:orbit/widgets/hr_text.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../widgets/reusable_profile_widget.dart';
import '../widgets/orbit_client_apply_leave_container.dart';

class ApplyLeaveScreen extends GetView<ApplyLeaveController> {
  const ApplyLeaveScreen({Key? key})
      : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    final mLocaleData =
        OrbitClientApp.mLocale[ConfigKeysTitle.applyLeaveScreen];
    return Scaffold(
      body: SafeArea(
        child: HeaderContainerDesign(
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.all(width * 0.05),
                child: Column(
                  children: <Widget>[
                    ReusableProfileWidget(
                      title: mLocaleData![ConfigKeysBody.applyLeaveContainer]!,
                      name: controller
                          .preferencesController.employeeDetails!.employeeName,
                      post: controller
                          .preferencesController.employeeDetails!.designation,
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
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: height * 0.03, horizontal: width * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HrAppText(
                        text: mLocaleData[ConfigKeysBody.applyLeaveContainer]!,
                        style: HeadingTextStyles.heading4.copyWith(
                            color: AppColors.primaryColor.value,
                            fontFamily: TrueBookFontFamily.gUbuntuMedium),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        children: [
                          HrAppText(
                            text: mLocaleData[
                                ConfigKeysBody.applyLeaveContainer1]!,
                            style: HeadingTextStyles.heading6.copyWith(
                                color: AppColors.payment1,
                                fontFamily: TrueBookFontFamily.gUbuntuMedium),
                          ),
                          const HrText()
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      SizedBox(
                        width: width,
                        child: SfDateRangePicker(
                          view: DateRangePickerView.month,
                          navigationMode: DateRangePickerNavigationMode.scroll,
                          enablePastDates: false,
                          allowViewNavigation: false,
                          showNavigationArrow: false,
                          endRangeSelectionColor: AppColors.primaryColor.value,
                          startRangeSelectionColor:
                              AppColors.primaryColor.value,
                          selectionMode: DateRangePickerSelectionMode.range,
                          minDate: DateTime.now(),
                          initialSelectedDate: DateTime.now(),
                          onSelectionChanged:
                              (DateRangePickerSelectionChangedArgs arg) {
                            PickerDateRange? range;
                            if (arg.value is PickerDateRange) {
                              range = arg.value;
                              if (range!.startDate != null) {
                                controller.startDate = range.startDate;
                                controller.endDate =
                                    range.endDate ?? range.startDate!;
                              }
                            }
                          },
                          backgroundColor: Colors.white,
                          headerStyle: const DateRangePickerHeaderStyle(
                              backgroundColor: Colors.white),
                          selectionColor: AppColors.primaryColor.value,
                          todayHighlightColor: AppColors.primaryColor.value,
                          initialDisplayDate: DateTime.now(),
                          rangeTextStyle: const TextStyle(color: Colors.blue),
                          monthViewSettings:
                              const DateRangePickerMonthViewSettings(
                            dayFormat: 'EEE',
                            viewHeaderStyle: DateRangePickerViewHeaderStyle(
                              textStyle: TextStyle(
                                  color: Colors.black45, fontSize: 10),
                            ),
                          ),
                          selectionTextStyle:
                              const TextStyle(color: Colors.white),
                          rangeSelectionColor: const Color(0xFFD9EDFA),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.01),
                          width: width * 0.9,
                          decoration: BoxDecoration(
                              color: AppColors.walletColor2,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: AppColors.primaryColor.value)),
                          child: Row(
                            children: [
                              Obx(
                                () => Expanded(
                                  flex: 1,
                                  child: OrbitClientApplyLeaveContainer(
                                    text: mLocaleData[
                                        ConfigKeysBody.applyLeaveContainer6]!,
                                    style: HeadingTextStyles.heading3.copyWith(
                                      color: AppColors.primaryColor.value,
                                    ),
                                    radioValue: 1,
                                    selectedValue:
                                        controller.selectedValue.value,
                                    onChanged: (value) {
                                      print(value);
                                      controller.selectedValue.value = value!;
                                    },
                                  ),
                                ),
                              ),
                              Obx(
                                () => Expanded(
                                  flex: 1,
                                  child: OrbitClientApplyLeaveContainer(
                                    text: mLocaleData[
                                        ConfigKeysBody.applyLeaveContainer7]!,
                                    style: HeadingTextStyles.heading3.copyWith(
                                      color: AppColors.primaryColor.value,
                                    ),
                                    radioValue: 2,
                                    selectedValue:
                                        controller.selectedValue.value,
                                    onChanged: (value) {
                                      controller.selectedValue.value = value!;
                                    },
                                  ),
                                ),
                              ),
                              Obx(
                                () => Expanded(
                                  flex: 1,
                                  child: OrbitClientApplyLeaveContainer(
                                    text: mLocaleData[
                                        ConfigKeysBody.applyLeaveContainer8]!,
                                    style: HeadingTextStyles.heading3.copyWith(
                                      color: AppColors.primaryColor.value,
                                    ),
                                    radioValue: 3,
                                    selectedValue:
                                        controller.selectedValue.value,
                                    onChanged: (value) {
                                      controller.selectedValue.value = value!;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Obx(
                        () => controller.selectedValue.value == 2
                            ? ApplyLeaveContainerOne(controller: controller)
                            : controller.selectedValue.value == 3
                                ? ApplyLeaveContainerTwo(
                                    startTime: controller.startTime.value ??
                                        TimeOfDay.now(),
                                    endTime: controller.endTime.value ??
                                        TimeOfDay.now(),
                                  )
                                : Container(),
                      ),

                      HrAppText(
                        text: mLocaleData[ConfigKeysBody.applyLeaveContainer2]!,
                        style: HeadingTextStyles.heading6.copyWith(
                            color: AppColors.payment1,
                            fontFamily: TrueBookFontFamily.gUbuntuBold),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Obx(() => DynamicDropdownBottomSheet(
                          items: controller.selectedValue.value == 1
                              ? controller.leaveTypeList1
                                  .map((e) => e.leaveTypeName.toString())
                                  .toList()
                              : controller.leaveTypeList2
                                  .map((e) => e.leaveTypeName.toString())
                                  .toList(),
                          selectedValue: controller.selectedValue.value == 1
                              ? controller.selectedLeaveData.value
                              : controller.selectedLeaveData1.value,
                          title: 'Select Type',
                          heading: 'Leave Type',
                          onChanged: (e) async {
                            if (controller.selectedValue.value == 1) {
                              controller.selectedLeaveData.value = e!;
                              controller.selectedLeaveId = controller
                                  .leaveTypeList1
                                  .firstWhere((data) => data.leaveTypeName == e)
                                  .leaveTypeId!;
                            } else {
                              controller.selectedLeaveData1.value = e!;
                              controller.selectedLeaveId1 = controller
                                  .leaveTypeList2
                                  .firstWhere((data) => data.leaveTypeName == e)
                                  .leaveTypeId!;
                            }
                          })), // HrAppTextFormField(
                      SizedBox(
                        height: height * 0.02,
                      ),
                      HrAppText(
                        text: mLocaleData[ConfigKeysBody.applyLeaveContainer3]!,
                        style: HeadingTextStyles.heading6.copyWith(
                            color: AppColors.payment1,
                            fontFamily: TrueBookFontFamily.gUbuntuBold),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      TextFormField(
                        controller: controller.descriptionController,
                        minLines: 6,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          alignLabelWithHint: false,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColors.payment1,
                            ),
                          ),
                          hintText: 'Description',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {}
                          return null;
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      HrAppText(
                        text: mLocaleData[ConfigKeysBody.applyLeaveContainer4]!,
                        style: HeadingTextStyles.heading6.copyWith(
                            color: AppColors.payment1,
                            fontFamily: TrueBookFontFamily.gUbuntuBold),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Obx(() => GestureDetector(
                            onTap: () async {
                              await controller.pickImage();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.03),
                              height: height * 0.05,
                              width: width * 0.9,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 0,
                                    blurRadius: 1,
                                    offset: const Offset(0.5, 1),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.file_copy_outlined),
                                      HrAppText(
                                        text: controller.uploadImage.value ==
                                                false
                                            ? mLocaleData[ConfigKeysBody
                                                .applyLeaveContainer5]!
                                            : controller.selectedImages!.path
                                                .split('/')
                                                .last,
                                        style: HeadingTextStyles.heading2
                                            .copyWith(
                                                color: AppColors.payment1,
                                                fontFamily: TrueBookFontFamily
                                                    .gUbuntuBold),
                                      ),
                                    ],
                                  ),
                                  controller.uploadImage.value
                                      ? Container(
                                          height: height * 0.025,
                                          width: height * 0.025,
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryColor.value,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              constraints:
                                                  const BoxConstraints(),
                                              iconSize: height * 0.02,
                                              icon: const Icon(
                                                Icons.clear,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {
                                                controller.selectedImages =
                                                    null;
                                                controller.uploadImage.value =
                                                    false;
                                                print(
                                                    controller.selectedImages);
                                              },
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          )),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Obx(() => GestureDetector(
                            onTap: controller.apiCalling.value == true
                                ? null
                                : () async {
                                    if (controller.selectedValue.value == 1) {
                                      controller.startTime.value =
                                          const TimeOfDay(hour: 00, minute: 00);
                                      controller.endTime.value =
                                          const TimeOfDay(hour: 00, minute: 00);
                                    } else if (controller.selectedValue.value ==
                                        2) {
                                      if (controller.selectedValueContainerOne
                                                  .value ==
                                              1 &&
                                          controller.selectedValue.value == 2) {
                                        controller.startTime.value =
                                            const TimeOfDay(
                                                hour: 09, minute: 00);
                                        controller.endTime.value =
                                            const TimeOfDay(
                                                hour: 13, minute: 00);
                                      }
                                      if (controller.selectedValueContainerOne
                                                  .value ==
                                              2 &&
                                          controller.selectedValue.value == 2) {
                                        controller.startTime.value =
                                            const TimeOfDay(
                                                hour: 13, minute: 00);
                                        controller.endTime.value =
                                            const TimeOfDay(
                                                hour: 18, minute: 00);
                                      }
                                    } else {}
                                    await controller.applyLeave();
                                  },
                            child: OrbitClientButton(
                              title: 'Submit',
                              widthBtn: 0.9,
                              apiCalled: controller.apiCalling.value,
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
