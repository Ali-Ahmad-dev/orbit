import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/config/config_keys_body.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/models/loan_history_model.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/hr_app_text.dart';

class LoansContainer extends StatelessWidget {
  final double? loanAmount;
  final String? desc;
  final String? date;

  final String? comments;
  final int? expandedIndex;
  final int index;
  final VoidCallback? onTap;
  final LoanHistoryDtos loanHistoryDto;

  const LoansContainer({
    Key? key,
    this.date,
    this.expandedIndex,
    this.loanAmount,
    this.desc,
    this.comments,
    required this.loanHistoryDto,
    this.onTap, // Initialize onTap
    required this.index, // Initialize index
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final mLocaleData =
        OrbitClientApp.mLocale[ConfigKeysTitle.leaveHistoryScreen];
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.03, vertical: height * 0.013),
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
                    text: date ?? '23-04-2024',
                    style: HeadingTextStyles.heading2.copyWith(
                        color: AppColors.payment1,
                        fontWeight: FontWeight.bold,
                        fontFamily: TrueBookFontFamily.gUbuntuBold),
                  ),
                ),
                Row(
                  children: [
                    HrAppText(
                      text: loanHistoryDto.isApproved == false &&
                              loanHistoryDto.isRejected == true
                          ? 'Rejected'
                          : loanHistoryDto.isApproved!
                              ? 'Approved'
                              : 'Pending',
                      style: HeadingTextStyles.heading2.copyWith(
                          color: AppColors.payment1,
                          fontFamily: TrueBookFontFamily.gUbuntuBold),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Container(
                      width: width * 0.05,
                      height: width * 0.05,
                      decoration: BoxDecoration(
                        color: loanHistoryDto.isApproved == false &&
                                loanHistoryDto.isRejected == true
                            ? Colors.red
                            : !loanHistoryDto.isApproved!
                                ? Colors.blue
                                : Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                )
              ],
            ),
            if (expandedIndex == index) ...[
              SizedBox(height: height * 0.02),
              Row(
                children: [
                  HrAppText(
                    text: 'Total Loan Amount ',
                    style: HeadingTextStyles.heading2.copyWith(
                        color: AppColors.payment1,
                        fontWeight: FontWeight.bold,
                        fontFamily: TrueBookFontFamily.gUbuntuBold),
                  ),
                  Container(
                    height: height * 0.03,
                    padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5)),
                    child: HrAppText(
                      text: '${loanAmount ?? 'no loan'}',
                      style: HeadingTextStyles.heading6.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: TrueBookFontFamily.gUbuntuBold),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              HrAppText(
                text: 'Deduction Type',
                style: HeadingTextStyles.heading2.copyWith(
                    color: AppColors.payment1,
                    fontWeight: FontWeight.bold,
                    fontFamily: TrueBookFontFamily.gUbuntuBold),
              ),
              SizedBox(height: height * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.015),
                child: HrAppText(
                  text: '${loanHistoryDto.deductionType}',
                  style: HeadingTextStyles.heading2.copyWith(
                      color: AppColors.payment1,
                      fontFamily: TrueBookFontFamily.gUbuntuBold),
                ),
              ),
              SizedBox(height: height * 0.02),
              HrAppText(
                text: 'No of Installments Requested',
                style: HeadingTextStyles.heading2.copyWith(
                    color: AppColors.payment1,
                    fontWeight: FontWeight.bold,
                    fontFamily: TrueBookFontFamily.gUbuntuBold),
              ),
              SizedBox(height: height * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.015),
                child: HrAppText(
                  text: loanHistoryDto.isApproved == false &&
                          loanHistoryDto.isRejected == true
                      ? 'Not Approved'
                      : '${loanHistoryDto.noofinstallments}',
                  style: HeadingTextStyles.heading2.copyWith(
                      color: AppColors.payment1,
                      fontFamily: TrueBookFontFamily.gUbuntuBold),
                ),
              ),
              SizedBox(height: height * 0.02),
              HrAppText(
                text: 'No of Installments Approved',
                style: HeadingTextStyles.heading2.copyWith(
                    color: AppColors.payment1,
                    fontWeight: FontWeight.bold,
                    fontFamily: TrueBookFontFamily.gUbuntuBold),
              ),
              SizedBox(height: height * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.015),
                child: HrAppText(
                  text: '${loanHistoryDto.noofinstallmentsByHr}',
                  style: HeadingTextStyles.heading2.copyWith(
                      color: AppColors.payment1,
                      fontFamily: TrueBookFontFamily.gUbuntuBold),
                ),
              ),
              SizedBox(height: height * 0.02),
              HrAppText(
                text: 'Loan Description',
                style: HeadingTextStyles.heading2.copyWith(
                    color: AppColors.payment1,
                    fontWeight: FontWeight.bold,
                    fontFamily: TrueBookFontFamily.gUbuntuBold),
              ),
              SizedBox(height: height * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.015),
                child: GestureDetector(
                  onTap: () {
                    Get.defaultDialog(
                      title: 'Loan Description',
                      middleText:
                          loanHistoryDto.loanDescription ?? 'No Description',
                    );
                  },
                  child: HrAppText(
                    text: loanHistoryDto.loanDescription ?? 'No Description',
                    maxLines: 2,
                    style: HeadingTextStyles.heading2.copyWith(
                        color: AppColors.payment1,
                        fontFamily: TrueBookFontFamily.gUbuntuBold),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              if (loanHistoryDto.comments != null &&
                  loanHistoryDto.comments!.isNotEmpty)
                Column(
                  children: [
                    HrAppText(
                      text:
                          mLocaleData![ConfigKeysBody.leaveHistoryContainer15]!,
                      style: HeadingTextStyles.heading2.copyWith(
                          color: AppColors.payment1,
                          fontWeight: FontWeight.bold,
                          fontFamily: TrueBookFontFamily.gUbuntuBold),
                    ),
                    SizedBox(height: height * 0.02),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.015),
                      child: HrAppText(
                        text: loanHistoryDto.comments ?? 'No Comments',
                        style: HeadingTextStyles.heading2.copyWith(
                            color: AppColors.payment1,
                            fontFamily: TrueBookFontFamily.gUbuntuBold),
                      ),
                    ),
                    SizedBox(height: height * 0.015),
                  ],
                )
            ],
          ],
        ),
      ),
    );
  }
}
