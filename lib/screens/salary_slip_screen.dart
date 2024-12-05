import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/config/config_keys_body.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/controllers/login_controller.dart';
import 'package:orbit/controllers/salary_slip_controller.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/header_container_design.dart';
import 'package:orbit/widgets/reusable_profile_widget.dart';
import 'package:orbit/widgets/hr_app_text.dart';
import 'package:orbit/widgets/slider_button.dart';

class SalarySlipScreen extends GetView<SalarySlipController> {
  const SalarySlipScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mLocaleData1 =
        OrbitClientApp.mLocale[ConfigKeysTitle.salarySlipScreen];
    final mLocaleData =
        OrbitClientApp.mLocale[ConfigKeysTitle.salarySlipScreen];
    final mLocaleData2 =
        OrbitClientApp.mLocale[ConfigKeysTitle.salarySlipScreen];
    double width = Get.width;
    double height = Get.height;
    return Scaffold(
      body: HeaderContainerDesign(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: height * 0.05),
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
                      title:
                          mLocaleData1![ConfigKeysBody.salarySlipScreenTitle]!,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: height * 0.015),
                      HrAppText(
                        text: mLocaleData![
                            ConfigKeysBody.salarySlipScreenDescription]!,
                        style: HeadingTextStyles.heading4.copyWith(
                            color: AppColors.descriptionColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            fontFamily: TrueBookFontFamily.gUbuntuBold),
                      ),
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
                      ListView.builder(
                        itemCount: controller.salarySlipList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var salaryListData = controller.salarySlipList[index];
                          return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: height * 0.009),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.15),
                                      blurStyle: BlurStyle.outer,
                                      spreadRadius: 2.0,
                                      blurRadius: 15,
                                      offset: const Offset(2, 6),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: height * 0.009,
                                  horizontal: width * 0.04,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    HrAppText(
                                      text: 'Over Time:',
                                      style:
                                          HeadingTextStyles.heading2.copyWith(
                                        color: AppColors.payment1,
                                        fontFamily:
                                            TrueBookFontFamily.gUbuntuMedium,
                                      ),
                                    ),
                                    HrAppText(
                                      text: '${salaryListData.overTime} Hours',
                                      style:
                                          HeadingTextStyles.heading3.copyWith(
                                        color: AppColors.payment1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    HrAppText(
                                      text: 'Paid Days: ',
                                      style:
                                          HeadingTextStyles.heading2.copyWith(
                                        color: AppColors.payment1,
                                        fontFamily:
                                            TrueBookFontFamily.gUbuntuMedium,
                                      ),
                                    ),
                                    HrAppText(
                                      text: '${salaryListData.paidDays} Days',
                                      style:
                                          HeadingTextStyles.heading3.copyWith(
                                        color: AppColors.payment1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    HrAppText(
                                      text: 'Total Days:',
                                      style:
                                          HeadingTextStyles.heading2.copyWith(
                                        color: AppColors.payment1,
                                        fontFamily:
                                            TrueBookFontFamily.gUbuntuMedium,
                                      ),
                                    ),
                                    HrAppText(
                                      text: '${salaryListData.totaldays} Days',
                                      style:
                                          HeadingTextStyles.heading3.copyWith(
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    HrAppText(
                                      text: 'Pay Roll Salary:',
                                      style:
                                          HeadingTextStyles.heading2.copyWith(
                                        color: AppColors.payment1,
                                        fontFamily:
                                            TrueBookFontFamily.gUbuntuMedium,
                                      ),
                                    ),
                                    HrAppText(
                                      text: salaryListData.payrollSalary!
                                          .toString(),
                                      style:
                                          HeadingTextStyles.heading3.copyWith(
                                        color: AppColors.payment1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    HrAppText(
                                      text: 'Tax Deduction:',
                                      style:
                                          HeadingTextStyles.heading2.copyWith(
                                        color: AppColors.payment1,
                                        fontFamily:
                                            TrueBookFontFamily.gUbuntuMedium,
                                      ),
                                    ),
                                    HrAppText(
                                      text: salaryListData.taxDeduction!
                                          .toString(),
                                      style:
                                          HeadingTextStyles.heading3.copyWith(
                                        color: AppColors.payment1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    HrAppText(
                                      text: 'Net Payable Salary:',
                                      style:
                                          HeadingTextStyles.heading2.copyWith(
                                        color: AppColors.payment1,
                                        fontFamily:
                                            TrueBookFontFamily.gUbuntuMedium,
                                      ),
                                    ),
                                    HrAppText(
                                      text: salaryListData.netpayablesalary!
                                          .toString(),
                                      style:
                                          HeadingTextStyles.heading3.copyWith(
                                        color: AppColors.payment1,
                                      ),
                                    )
                                  ],
                                ),
                              ));
                        },
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: height * 0.03,
                              width: width * 0.2,
                              color: Get.find<LoginController>()
                                          .designation
                                          .value ==
                                      'Team Lead'
                                  ? AppColors.primaryGreenColor
                                  : Get.find<LoginController>()
                                              .designation
                                              .value ==
                                          'HR'
                                      ? AppColors.primaryBlue
                                      : AppColors.primaryColor.value,
                              child: Center(
                                child: HrAppText(
                                  text: mLocaleData2![ConfigKeysBody
                                      .salarySlipScreenContainer1]!,
                                  style: HeadingTextStyles.heading2.copyWith(
                                      color: AppColors.walletColor2,
                                      fontFamily:
                                          TrueBookFontFamily.gUbuntuBold),
                                ),
                              ),
                            ),
                            Container(
                              height: height * 0.03,
                              width: width * 0.2,
                              color: AppColors.payment1,
                              child: Center(
                                child: HrAppText(
                                  text: mLocaleData2[ConfigKeysBody
                                      .salarySlipScreenContainer2]!,
                                  style: HeadingTextStyles.heading2.copyWith(
                                      color: AppColors.walletColor2,
                                      fontFamily:
                                          TrueBookFontFamily.gUbuntuBold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
