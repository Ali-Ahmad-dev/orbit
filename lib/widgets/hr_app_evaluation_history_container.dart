import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/constants/models/evaluation_history_model.dart';
import 'package:orbit/models/evaluation_history_model.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/hr_app_text.dart';

class HrAppEvaluationHistoryContainer extends StatelessWidget {
  final EvaluationReportDtos evaluationHistoryModel;

  const HrAppEvaluationHistoryContainer({
    Key? key,
    required this.evaluationHistoryModel,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;

    OrbitClientApp.mLocale[ConfigKeysTitle.evaluationScreen];
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.02, vertical: height * 0.04),
          width: width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(1, 2)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              HrAppText(
                text: evaluationHistoryModel.title!,
                style: HeadingTextStyles.heading2.copyWith(
                    color: AppColors.payment1,
                    fontFamily: TrueBookFontFamily.gUbuntuMedium),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              HrAppText(
                text: evaluationHistoryModel.date!,
                style: HeadingTextStyles.heading2.copyWith(
                  color: AppColors.payment1,
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              RatingBar.builder(
                initialRating: evaluationHistoryModel.rating!.toDouble(),
                minRating: evaluationHistoryModel.rating!.toDouble(),
                unratedColor: Colors.grey,
                maxRating: evaluationHistoryModel.rating!.toDouble(),
                direction: Axis.horizontal,
                allowHalfRating: false,
                tapOnlyMode: false,
                itemCount: evaluationHistoryModel.rating!.toInt(),
                itemPadding: EdgeInsets.symmetric(horizontal: width * 0.02),
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (value) {
                  return;
                },
              ),
              // const Icon(Icons.star_sharp,color: Colors.yellow,),
              SizedBox(
                height: height * 0.02,
              ),
              HrAppText(
                maxLines: 5,
                text: evaluationHistoryModel.comment!,
                style: HeadingTextStyles.heading2.copyWith(
                  color: AppColors.payment1,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
      ],
    );
  }
}
