import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/config/config_keys_body.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/custom_button.dart';
import 'package:orbit/widgets/dynamic_dropdown.dart';
import 'package:orbit/widgets/header_container_design.dart';
import 'package:orbit/widgets/hr_app_text.dart';
import 'package:orbit/widgets/hr_text.dart';
import 'package:orbit/widgets/textformfield.dart';
import '../controllers/apply_loan_controller.dart';
import '../widgets/reusable_profile_widget.dart';

class ApplyLoanScreen extends GetView<ApplyLoanController> {
  const ApplyLoanScreen({Key? key})
      : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    final mLocaleData = OrbitClientApp.mLocale[ConfigKeysTitle.applyLoanScreen];
    return Scaffold(
      body: SafeArea(
        child: HeaderContainerDesign(
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.all(width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableProfileWidget(
                      icon: Icon(
                        Icons.arrow_back,
                        color: AppColors.walletColor2,
                      ),
                      title: mLocaleData![ConfigKeysBody.applyLoanScreenTitle]!,
                      name: controller
                          .loginController.employeeDetails!.employeeName,
                      post: controller
                          .loginController.employeeDetails!.designation,
                    )
                  ],
                ),
              ),
              SizedBox(height: height * 0.01),
              Container(
                padding: EdgeInsets.all(width * 0.05),
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
                    vertical: height * 0.03,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HrAppText(
                        text: mLocaleData[
                            ConfigKeysBody.applyLoanScreenContainerTitle]!,
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
                            text: mLocaleData[ConfigKeysBody
                                .applyLoanScreenContainerDeduction]!,
                            style: HeadingTextStyles.heading6.copyWith(
                                color: AppColors.payment1,
                                fontFamily: TrueBookFontFamily.gUbuntuMedium),
                          ),
                          const HrText()
                        ],
                      ),
                      Obx(
                        () => DynamicDropdownBottomSheet(
                            items: controller.deductionList
                                .map((e) => e.name.toString())
                                .toList(),
                            selectedValue: controller.selectedTypeData.value,
                            title: 'Select Type',
                            heading: 'Deduction Type*',
                            onChanged: (e) async {
                              controller.selectedTypeData.value = e!;
                              controller.selectedTypeId = controller
                                  .deductionList
                                  .firstWhere((data) => data.name == e)
                                  .id!;
                            }),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        children: [
                          HrAppText(
                            text: mLocaleData[
                                ConfigKeysBody.applyLoanScreenContainerAmount]!,
                            style: HeadingTextStyles.heading6.copyWith(
                                color: AppColors.payment1,
                                fontFamily: TrueBookFontFamily.gUbuntuBold),
                          ),
                          const HrText()
                        ],
                      ),
                      HrAppTextFormField(
                        keyboardType: TextInputType.number,
                        controller: controller.amountController,
                        hintText: "Total Amount",
                        inputFormatter: [
                          LengthLimitingTextInputFormatter(6),
                        ],
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
                            ConfigKeysBody.applyLoanScreenContainerReason]!,
                        style: HeadingTextStyles.heading6.copyWith(
                            color: AppColors.payment1,
                            fontFamily: TrueBookFontFamily.gUbuntuBold),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      TextFormField(
                        controller: controller.reasonController,
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
                          hintText: 'Reason',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {}
                          return null;
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        children: [
                          HrAppText(
                            text: mLocaleData[
                                ConfigKeysBody.applyLoanScreenContainerNumber]!,
                            style: HeadingTextStyles.heading6.copyWith(
                                color: AppColors.payment1,
                                fontFamily: TrueBookFontFamily.gUbuntuBold),
                          ),
                          const HrText()
                        ],
                      ),
                      HrAppTextFormField(
                        controller: controller.installmentController,
                        hintText: "Installments",
                        keyboardType: TextInputType.number,
                        inputFormatter: [
                          LengthLimitingTextInputFormatter(1),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select an option';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      GestureDetector(
                        onTap: () {
                          String message =
                              "Please enter the following required data:\n";
                          bool hasError = false;

                          if (controller.selectedTypeId == 0) {
                            message += "* Deduction Type\n";
                            hasError = true;
                          }

                          if (controller.amountController.text.isEmpty) {
                            message += "* Total Amount\n";
                            hasError = true;
                          }

                          if (controller.installmentController.text.isEmpty) {
                            message += "* Installments\n";
                            hasError = true;
                          }

                          if (hasError) {
                            Fluttertoast.showToast(
                              msg: message.trim(),
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red.withOpacity(0.8),
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          } else {
                            controller.applyLoan();
                          }
                        },
                        child: Obx(
                          () => OrbitClientButton(
                            title: 'Apply',
                            apiCalled: controller.apiCalling.value,
                            widthBtn: 0.9,
                          ),
                        ),
                      ),
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
