import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/controllers/evaluation_controller.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/hr_app_text.dart';
import 'package:orbit/widgets/textformfield.dart';

class HrAppEvaluationContainerOne extends StatelessWidget {
  final List<TextEditingController> listTextEditingController;
  final EvaluationController controller;
  final List<double> listRatings;

  final List<Function(double)?> onTap;
  const HrAppEvaluationContainerOne({
    Key? key,
    required this.listTextEditingController,
    required this.listRatings,
    required this.controller,
    required this.onTap,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    final mLocaleData =
        OrbitClientApp.mLocale[ConfigKeysTitle.evaluationScreen];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
            itemCount: controller.paramList.length,
            // itemCount: evaluation_data.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HrAppText(
                    text: controller.paramList[index].parameter ?? 'bluh',
                    style: HeadingTextStyles.heading2.copyWith(
                        color: AppColors.payment1,
                        fontFamily: TrueBookFontFamily.gUbuntuMedium),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  HrAppTextFormField(
                    controller: listTextEditingController[index],
                    hintText: controller.paramList[index].parameter!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {}
                      return null;
                    },
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  RatingBar.builder(
                    initialRating: controller.listRatings[index],
                    minRating: 0,
                    unratedColor: Colors.grey,
                    maxRating: 5,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: controller.onTapList[index],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                ],
              );
            }),
      ],
    );
  }
}
