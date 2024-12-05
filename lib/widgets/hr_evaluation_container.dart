import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/hr_app_text.dart';

class HrEvaluationContainer extends StatelessWidget {
  final int? text;
  const HrEvaluationContainer({
    Key? key,
    this.text,
  }) : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    final mLocaleData =
        OrbitClientApp.mLocale[ConfigKeysTitle.evaluationScreen];
    return Container(
      height: height * 0.04,
      width: width * 0.09,
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: HrAppText(
          text: '${text ?? 1}',
          style: HeadingTextStyles.heading2.copyWith(
              color: Colors.black,
              fontSize: 26,
              fontFamily: TrueBookFontFamily.gUbuntuMedium),
        ),
      ),
    );
  }
}
