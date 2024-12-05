import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/config/config_keys_body.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/controllers/loan_controller.dart';
import 'package:orbit/models/loan_history_model.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/header_container_design.dart';
import 'package:orbit/widgets/hr_app_circularprogressindicator.dart';
import 'package:orbit/widgets/hr_app_loan_history_container.dart';
import 'package:orbit/widgets/hr_app_text.dart';
import 'package:orbit/widgets/loans_container.dart';
import 'package:orbit/widgets/special_container.dart';
import '../widgets/reusable_profile_widget.dart';

class LoanScreen extends GetView<LoanController> {
  const LoanScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    final mLocaleData = OrbitClientApp.mLocale[ConfigKeysTitle.loanScreen];
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              HeaderContainerDesign(
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
                            title:
                                mLocaleData![ConfigKeysBody.loanScreenTitle]!,
                            name: controller.allLoansModel == null
                                ? controller.preferencesController
                                    .employeeDetails!.employeeName
                                : controller.allLoansModel!.employeeName!,
                            post: controller.allLoansModel == null
                                ? controller.preferencesController
                                    .employeeDetails!.designation
                                : controller.allLoansModel!.designation,
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
                          vertical: height * 0.03,
                          horizontal: width * 0.05,
                        ),
                        child: Obx(
                          () => controller.apiCalling.value
                              ? const Center(
                                  child: HrAppCircularprogressindicator())
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          HrAppText(
                                            text: mLocaleData[ConfigKeysBody
                                                .loanScreenDescription]!,
                                            style: HeadingTextStyles.heading4
                                                .copyWith(
                                                    color: AppColors.payment1,
                                                    fontFamily:
                                                        TrueBookFontFamily
                                                            .gUbuntuMedium),
                                          ),
                                          if (controller.allLoansModel == null)
                                            GestureDetector(
                                              onTap: () {
                                                controller
                                                    .goToApplyLoanScreen();
                                              },
                                              child: Container(
                                                height: height * 0.04,
                                                width: width * 0.25,
                                                decoration: BoxDecoration(
                                                  color: AppColors
                                                      .primaryColor.value,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Center(
                                                  child: HrAppText(
                                                    text: mLocaleData[
                                                        ConfigKeysBody
                                                            .loanScreenApplyLoan]!,
                                                    style: HeadingTextStyles
                                                        .heading2
                                                        .copyWith(
                                                      color: AppColors
                                                          .walletColor2,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                        ]),
                                    SizedBox(
                                      height: height * 0.02,
                                    ),
                                    HrAppText(
                                      text: mLocaleData[ConfigKeysBody
                                          .loanScreenContainerStats]!,
                                      style: HeadingTextStyles.heading6
                                          .copyWith(
                                              color: AppColors.payment1,
                                              fontFamily: TrueBookFontFamily
                                                  .gUbuntuBold),
                                    ),
                                    SizedBox(
                                      height: height * 0.02,
                                    ),
                                    Container(
                                      height: height * 0.1,
                                      width: width * 0.9,
                                      decoration: BoxDecoration(
                                          color: AppColors.primaryColor.value,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          HrAppLoanHistoryContainer(
                                            text: mLocaleData[ConfigKeysBody
                                                .loanScreenContainer]!,
                                            text1: mLocaleData[ConfigKeysBody
                                                .loanScreenContainer1]!,
                                            text2:
                                                '${controller.loanHistory.currentLoanStats?.totalLoanAmount == 0.0 ? 0 : controller.loanHistory.currentLoanStats?.totalLoanAmount ?? 1}',
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
                                          HrAppLoanHistoryContainer(
                                            text: mLocaleData[ConfigKeysBody
                                                .loanScreenContainer3]!,
                                            text1: mLocaleData[ConfigKeysBody
                                                .loanScreenContainer4]!,
                                            text2:
                                                '${controller.loanHistory.currentLoanStats?.totalInstallments == 0.0 ? 0 : controller.loanHistory.currentLoanStats?.totalInstallments ?? 1}',
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
                                          HrAppLoanHistoryContainer(
                                            text: mLocaleData[ConfigKeysBody
                                                .loanScreenContainer1]!,
                                            text1: mLocaleData[ConfigKeysBody
                                                .loanScreenContainer5]!,
                                            text2:
                                                '${controller.loanHistory.currentLoanStats?.amountPayedBack == 0.0 ? 0 : controller.loanHistory.currentLoanStats?.totalInstallments ?? 1}',
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
                                          HrAppLoanHistoryContainer(
                                            text: mLocaleData[ConfigKeysBody
                                                .loanScreenContainer6]!,
                                            text1: mLocaleData[ConfigKeysBody
                                                .loanScreenContainer7]!,
                                            text2: controller
                                                    .loanHistory
                                                    .currentLoanStats
                                                    ?.thisMonthInstallment ??
                                                'loan',
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.02,
                                    ),
                                    SizedBox(
                                      height: height * 0.04,
                                    ),
                                    HrAppText(
                                      text: mLocaleData[ConfigKeysBody
                                          .loanScreenPreviousLoan]!,
                                      style: HeadingTextStyles.heading6
                                          .copyWith(
                                              color: AppColors.payment1,
                                              fontFamily: TrueBookFontFamily
                                                  .gUbuntuBold),
                                    ),
                                    SizedBox(
                                      height: height * 0.04,
                                    ),
                                    Column(
                                      children: [
                                        controller.loanHistory.message!
                                                .loanHistoryDtos!.isEmpty
                                            ? const SpecialContainer()
                                            : ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: controller
                                                    .loanHistory
                                                    .message!
                                                    .loanHistoryDtos!
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  final LoanHistoryDtos
                                                      loanHistory = controller
                                                              .loanHistory
                                                              .message!
                                                              .loanHistoryDtos![
                                                          index];

                                                  var date = controller
                                                          .loanHistory
                                                          .message!
                                                          .loanHistoryDtos![
                                                              index]
                                                          .appliedOn ??
                                                      '';
                                                  var amount = controller
                                                          .loanHistory
                                                          .message!
                                                          .loanHistoryDtos![
                                                              index]
                                                          .totalLoanAmount ??
                                                      123;

                                                  return Obx(() => Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: height *
                                                                  0.009),
                                                      child: LoansContainer(
                                                        onTap: () => controller
                                                            .toggleExpanded(
                                                                index),
                                                        index: index,
                                                        loanAmount:
                                                            amount.toDouble(),
                                                        expandedIndex:
                                                            controller
                                                                .expandedIndex
                                                                .value,
                                                        loanHistoryDto:
                                                            loanHistory,
                                                        date:
                                                            '${'Applied On'} ${(date.substring(0, min(date.length, 10)))}',
                                                      )));
                                                }),
                                      ],
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
