import 'dart:math';

import 'package:flutter/material.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/config/config_keys_body.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/utils/hr_datetime_util.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/custom_button.dart';
import 'package:orbit/widgets/hr_app_text.dart';

class DynamicHeightContainer extends StatelessWidget {
  final String? leaveReason;
  final bool? attachment;
  final String? leaveType;
  final String? days;
  final String? desc;
  final String? date;
  final String? teamLeadComment;
  final String? comments;
  final double? progress;
  final List<String>? dates;
  final int index;
  final String? hrComments;
  final VoidCallback? onTap;
  final void Function()? onTapDownload;
  final int? expandedIndex; // onTap callback parameter

  const DynamicHeightContainer({
    this.attachment,
    Key? key,
    this.hrComments,
    this.dates,
    this.leaveReason,
    this.progress,
    this.leaveType,
    this.onTapDownload,
    this.date,
    this.expandedIndex,
    this.days,
    this.desc,
    this.teamLeadComment,
    this.comments,
    this.onTap, // Initialize onTap
    required this.index, // Initialize index
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final mLocaleData =
        OrbitClientApp.mLocale[ConfigKeysTitle.leaveHistoryScreen];

    print('DynamicHeightContainer => $hrComments');
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
                    text: date ?? 'Leave Reason',
                    style: HeadingTextStyles.heading2.copyWith(
                        color: AppColors.payment1,
                        fontWeight: FontWeight.bold,
                        fontFamily: TrueBookFontFamily.gUbuntuBold),
                  ),
                ),
                const Center(
                    child: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.black,
                  size: 25,
                )),
              ],
            ),
            if (expandedIndex == index) ...[
              SizedBox(height: height * 0.02),
              HrAppText(
                text: mLocaleData![ConfigKeysBody.leaveHistoryContainer10]!,
                style: HeadingTextStyles.heading2.copyWith(
                    color: AppColors.payment1,
                    fontWeight: FontWeight.bold,
                    fontFamily: TrueBookFontFamily.gUbuntuBold),
              ),
              SizedBox(height: height * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.015),
                child: HrAppText(
                  text: leaveReason ?? 'Leave Reason',
                  style: HeadingTextStyles.heading2.copyWith(
                      color: AppColors.payment1,
                      fontFamily: TrueBookFontFamily.gUbuntuBold),
                ),
              ),
              SizedBox(height: height * 0.02),
              HrAppText(
                text: mLocaleData[ConfigKeysBody.leaveHistoryContainer11]!,
                style: HeadingTextStyles.heading2.copyWith(
                    color: AppColors.payment1,
                    fontWeight: FontWeight.bold,
                    fontFamily: TrueBookFontFamily.gUbuntuBold),
              ),
              SizedBox(height: height * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.015),
                child: HrAppText(
                  text: leaveType ?? 'No Comments',
                  style: HeadingTextStyles.heading2.copyWith(
                      color: AppColors.payment1,
                      fontFamily: TrueBookFontFamily.gUbuntuBold),
                ),
              ),
              SizedBox(height: height * 0.02),
              HrAppText(
                text: mLocaleData[ConfigKeysBody.leaveHistoryContainer12]!,
                style: HeadingTextStyles.heading2.copyWith(
                    color: AppColors.payment1,
                    fontWeight: FontWeight.bold,
                    fontFamily: TrueBookFontFamily.gUbuntuBold),
              ),
              SizedBox(height: height * 0.02),
              Wrap(
                children: dates!.map((value) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: Container(
                      height: height * 0.03,
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(5)),
                      child: HrAppText(
                        text: HrDatetimeUtil.toYearMonthDay(value),
                        style: HeadingTextStyles.heading6.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: TrueBookFontFamily.gUbuntuBold),
                      ),
                    ),
                  );
                }).toList(),
              ),
              // Container(
              //   height: height * 0.03,
              //   padding: EdgeInsets.symmetric(horizontal: width * 0.02),
              //   decoration: BoxDecoration(
              //       color: Colors.black,
              //       borderRadius: BorderRadius.circular(5)),
              //   child: HrAppText(
              //     text: dates![index]
              //             .substring(0, min(dates![index].length, 10)) ??
              //         'No Comments',
              //     style: HeadingTextStyles.heading6.copyWith(
              //         color: Colors.white,
              //         fontWeight: FontWeight.bold,
              //         fontFamily: TrueBookFontFamily.gUbuntuBold),
              //   ),
              // ),
              if (comments != null && comments!.isNotEmpty)
                Column(
                  children: [
                    SizedBox(height: height * 0.02),
                    HrAppText(
                      text:
                          mLocaleData[ConfigKeysBody.leaveHistoryContainer13]!,
                      style: HeadingTextStyles.heading2.copyWith(
                          color: AppColors.payment1,
                          fontWeight: FontWeight.bold,
                          fontFamily: TrueBookFontFamily.gUbuntuBold),
                    ),
                    SizedBox(height: height * 0.02),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.015),
                      child: HrAppText(
                        text: comments ?? 'No Comments',
                        style: HeadingTextStyles.heading2.copyWith(
                            color: AppColors.payment1,
                            fontFamily: TrueBookFontFamily.gUbuntuBold),
                      ),
                    ),
                  ],
                ),
              if (teamLeadComment != null && teamLeadComment!.isNotEmpty)
                Column(
                  children: [
                    SizedBox(height: height * 0.02),
                    HrAppText(
                      text:
                          mLocaleData[ConfigKeysBody.leaveHistoryContainer14]!,
                      style: HeadingTextStyles.heading2.copyWith(
                          color: AppColors.payment1,
                          fontWeight: FontWeight.bold,
                          fontFamily: TrueBookFontFamily.gUbuntuBold),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.015),
                      child: HrAppText(
                        text: teamLeadComment ?? 'No Comments',
                        style: HeadingTextStyles.heading2.copyWith(
                            color: AppColors.payment1,
                            fontFamily: TrueBookFontFamily.gUbuntuBold),
                      ),
                    ),
                    if (hrComments != null && hrComments!.isNotEmpty)
                      Column(
                        children: [
                          SizedBox(height: height * 0.02),
                          HrAppText(
                            text: mLocaleData[
                                ConfigKeysBody.leaveHistoryContainer14]!,
                            style: HeadingTextStyles.heading2.copyWith(
                                color: AppColors.payment1,
                                fontWeight: FontWeight.bold,
                                fontFamily: TrueBookFontFamily.gUbuntuBold),
                          ),
                        ],
                      ),
                    SizedBox(height: height * 0.02),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.015),
                      child: HrAppText(
                        text: hrComments ?? 'No Comments',
                        style: HeadingTextStyles.heading2.copyWith(
                            color: AppColors.payment1,
                            fontFamily: TrueBookFontFamily.gUbuntuBold),
                      ),
                    ),
                  ],
                ),
              SizedBox(height: height * 0.02),
              if (attachment == true)
                GestureDetector(
                  onTap: onTapDownload,
                  child: OrbitClientButton(
                      radius: 10,
                      heightBtn: 0.05,
                      apiCalled: progress! > 0.0 ? true : false,
                      title:
                          mLocaleData[ConfigKeysBody.leaveHistoryContainer16]!,
                      widthBtn: 12),
                )
            ],
          ],
        ),
      ),
    );
  }
}
