import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/config/config_keys_body.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/custom_button.dart';
import 'package:orbit/widgets/header_container_design.dart';
import 'package:orbit/widgets/hr_app_text.dart';
import 'package:orbit/widgets/textformfield.dart';
import '../controllers/add_record_controller.dart';
import '../widgets/reusable_profile_widget.dart';
import '../widgets/orbit_client_apply_leave_container.dart';

class AddRecordScreen extends GetView<AddRecordController> {
  const AddRecordScreen({Key? key})
      : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    final mLocaleData = OrbitClientApp.mLocale[ConfigKeysTitle.addRecordScreen];
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
                          title: mLocaleData![
                              ConfigKeysBody.addRecordScreenTitle]!,
                          name: controller.member!.teamMemberName,
                          post: '',
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(width * 0.05),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: height * 0.03,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HrAppText(
                            text: mLocaleData[
                                ConfigKeysBody.addRecordScreenDescription]!,
                            style: HeadingTextStyles.heading4.copyWith(
                                color: AppColors.primaryColor.value,
                                fontFamily: TrueBookFontFamily.gUbuntuMedium),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          HrAppTextFormField(
                            controller: controller.problemController,
                            hintText: "Problem Statement*",
                            validator: (value) {
                              if (value == null || value.isEmpty) {}
                              return null;
                            },
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          TextFormField(
                            controller: controller.suggestionController,
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
                              hintText: 'Suggestion For Improvement',
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
                            text: mLocaleData[
                                ConfigKeysBody.addRecordScreenProblem]!,
                            style: HeadingTextStyles.heading6.copyWith(
                                color: AppColors.primaryColor.value,
                                fontFamily: TrueBookFontFamily.gUbuntuMedium),
                          ),
                          Row(
                            children: [
                              Obx(
                                () => Expanded(
                                  flex: 1,
                                  child: OrbitClientApplyLeaveContainer(
                                    text: mLocaleData[
                                        ConfigKeysBody.addRecordScreenLow]!,
                                    style: HeadingTextStyles.heading3.copyWith(
                                        color: AppColors.payment1,
                                        fontFamily:
                                            TrueBookFontFamily.gUbuntuMedium),
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
                                        ConfigKeysBody.addRecordScreenMedium]!,
                                    style: HeadingTextStyles.heading3.copyWith(
                                        color: AppColors.payment1,
                                        fontFamily:
                                            TrueBookFontFamily.gUbuntuMedium),
                                    radioValue: 2,
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
                                        ConfigKeysBody.addRecordScreenHigh]!,
                                    style: HeadingTextStyles.heading3.copyWith(
                                        color: AppColors.payment1,
                                        fontFamily:
                                            TrueBookFontFamily.gUbuntuMedium),
                                    radioValue: 3,
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
                                        ConfigKeysBody.addRecordScreenSevere]!,
                                    style: HeadingTextStyles.heading3.copyWith(
                                        color: AppColors.payment1,
                                        fontFamily:
                                            TrueBookFontFamily.gUbuntuMedium),
                                    radioValue: 4,
                                    selectedValue:
                                        controller.selectedValue.value,
                                    onChanged: (value) {
                                      print(value);
                                      controller.selectedValue.value = value!;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Obx(() => GestureDetector(
                                onTap: controller.apiCalling.value
                                    ? () {}
                                    : () {
                                        if (controller.selectedValue.value ==
                                            1) {
                                          controller.severity.value = 'Low';
                                        } else if (controller
                                                .selectedValue.value ==
                                            2) {
                                          controller.severity.value = 'Medium';
                                        } else if (controller
                                                .selectedValue.value ==
                                            3) {
                                          controller.severity.value = 'High';
                                        } else {
                                          controller.severity.value = 'Severe';
                                        }
                                        controller.addMemberPerformance();
                                      },
                                child: OrbitClientButton(
                                  title: 'Add',
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
