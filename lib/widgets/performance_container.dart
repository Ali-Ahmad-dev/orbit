import 'package:flutter/material.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/hr_app_text.dart';

class PerformanceContainer extends StatelessWidget {
  final String? problem;
  final String? severity;
  final String? date;
  final int? expandedIndex;
  final String? suggestion;

  final int index;
  final VoidCallback? onTap;

  const PerformanceContainer({
    Key? key,
    this.date,
    this.expandedIndex,
    this.problem,
    this.severity,
    this.suggestion,
    this.onTap,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final mLocaleData =
        OrbitClientApp.mLocale[ConfigKeysTitle.leaveHistoryScreen];

    print(severity);
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
              offset: const Offset(0.5, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HrAppText(
                  text: problem ?? 'test',
                  style: HeadingTextStyles.heading2.copyWith(
                      color: AppColors.primaryColor.value,
                      fontWeight: FontWeight.bold,
                      fontFamily: TrueBookFontFamily.gUbuntuBold),
                ),
                Row(
                  children: [
                    HrAppText(
                      text: 'Severity:$severity',
                      style: HeadingTextStyles.heading2.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontFamily: TrueBookFontFamily.gUbuntuBold),
                    ),
                    Container(
                        width: width * 0.1,
                        height: height * 0.025,
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 2.0),
                        ),
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: severity == 'High' || severity == 'Severe'
                                  ? Colors.red
                                  : Colors.black,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ))
                  ],
                )
              ],
            ),
            if (expandedIndex == index) ...[
              SizedBox(height: height * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.015),
                child: HrAppText(
                  text: suggestion ?? 'No Comments',
                  style: HeadingTextStyles.heading2.copyWith(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontFamily: TrueBookFontFamily.gUbuntuBold),
                ),
              ),
              SizedBox(height: height * 0.015),
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
              SizedBox(height: height * 0.015),
            ],
          ],
        ),
      ),
    );
  }
}
