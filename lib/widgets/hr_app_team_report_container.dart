import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/controllers/login_controller.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/hr_app_text.dart';
import '../constants/config/config_keys_body.dart';

class HrAppTeamReportContainer extends StatelessWidget {
  final String? name;
  final String? totalLeaves;
  final Function()? onClick;
  final Function()? onTap;
  const HrAppTeamReportContainer({
    Key? key,
    this.name,
    this.totalLeaves,
    required this.onClick,
    required this.onTap,
  }) : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    final mLocaleData =
        OrbitClientApp.mLocale[ConfigKeysTitle.teamReportScreen];
    return Container(
      // padding: EdgeInsets.only(bottom: height * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: height * 0.015, horizontal: width * 0.015),
            child: Container(
              height: height * 0.07,
              decoration: BoxDecoration(
                color:
                    Get.find<LoginController>().designation.value == 'Team Lead'
                        ? AppColors.primaryGreenColor
                        : Get.find<LoginController>().designation.value == 'HR'
                            ? AppColors.primaryBlue
                            : AppColors.primaryColor.value,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          HrAppText(
            text: name!,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: HeadingTextStyles.heading3.copyWith(
                color: AppColors.payment1,
                fontFamily: TrueBookFontFamily.gUbuntuBold),
          ),
          HrAppText(
            text: 'Total Leaves: $totalLeaves',
            style: HeadingTextStyles.heading3.copyWith(
                color: AppColors.payment1,
                fontFamily: TrueBookFontFamily.gUbuntuBold),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: onClick,
                  child: Container(
                    height: height * 0.035,
                    width: width * 0.2,
                    decoration: BoxDecoration(
                        color: Get.find<LoginController>().designation.value ==
                                'Team Lead'
                            ? AppColors.primaryGreenColor
                            : Get.find<LoginController>().designation.value ==
                                    'HR'
                                ? AppColors.primaryBlue
                                : AppColors.primaryColor.value,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: HrAppText(
                        text: mLocaleData![ConfigKeysBody.teamReportScreenBtn]!,
                        style: HeadingTextStyles.heading3.copyWith(
                            color: AppColors.walletColor2,
                            fontFamily: TrueBookFontFamily.gUbuntuBold),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    height: height * 0.035,
                    width: width * 0.2,
                    decoration: BoxDecoration(
                        color: Get.find<LoginController>().designation.value ==
                                'Team Lead'
                            ? AppColors.primaryGreenColor
                            : Get.find<LoginController>().designation.value ==
                                    'HR'
                                ? AppColors.primaryBlue
                                : AppColors.primaryColor.value,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: HrAppText(
                        text: mLocaleData[ConfigKeysBody.teamReportScreenBtn1]!,
                        style: HeadingTextStyles.heading3.copyWith(
                            color: AppColors.walletColor2,
                            fontFamily: TrueBookFontFamily.gUbuntuBold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
