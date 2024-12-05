import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/hr_app_text.dart';
import 'package:orbit/widgets/textformfield.dart';
import '../constants/config/config_keys_body.dart';

class HrAppEvaluationContainerTwo extends StatelessWidget {
  final TextEditingController commentController;
  final int totalRating;
  const HrAppEvaluationContainerTwo(
      {Key? key, required this.commentController, required this.totalRating})
      : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    final mLocaleData =
        OrbitClientApp.mLocale[ConfigKeysTitle.evaluationScreen];
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.03),
          width: double.infinity,
          height: height * 0.06,
          color: AppColors.primaryColor.value,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HrAppText(
                text: mLocaleData![ConfigKeysBody.evaluationScreenContainer1]!,
                style: HeadingTextStyles.heading6.copyWith(
                    color: AppColors.walletColor2,
                    fontFamily: TrueBookFontFamily.gUbuntuMedium),
              ),
              HrAppText(
                text: '$totalRating',
                style: HeadingTextStyles.heading6.copyWith(
                    color: AppColors.walletColor2,
                    fontFamily: TrueBookFontFamily.gUbuntuMedium),
              ),
            ],
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        HrAppTextFormField(
          controller: commentController,
          hintText: "Additional Comments",
          validator: (value) {
            if (value == null || value.isEmpty) {}
            return null;
          },
        ),
        SizedBox(
          height: height * 0.02,
        ),
      ],
    );
  }
}
