import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/config/config_keys_body.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/controllers/evaluation_history_controller.dart';
import 'package:orbit/models/evaluation_history_model.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/header_container_design.dart';
import 'package:orbit/widgets/hr_app_circularprogressindicator.dart';
import 'package:orbit/widgets/hr_app_evaluation_history_container.dart';
import 'package:orbit/widgets/hr_app_text.dart';
import '../widgets/reusable_profile_widget.dart';

class EvaluationHistory extends GetView<EvaluationHistoryController> {
  const EvaluationHistory({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    final mLocaleData =
        OrbitClientApp.mLocale[ConfigKeysTitle.evaluationHistoryScreen];
    return Scaffold(
      body: SafeArea(
        child: HeaderContainerDesign(
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.all(width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableProfileWidget(
                      icon: Icon(
                        Icons.arrow_back,
                        color: AppColors.walletColor2,
                      ),
                      title: mLocaleData![
                          ConfigKeysBody.evaluationHistoryScreenTitle]!,
                      post: '',
                    ),
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
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: height * 0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              HrAppText(
                                text: mLocaleData[ConfigKeysBody
                                    .evaluationHistoryScreenTitle]!,
                                style: HeadingTextStyles.heading4.copyWith(
                                    color: AppColors.primaryColor.value,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    fontFamily: TrueBookFontFamily.gUbuntuBold),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.goToEvaluationScreen();
                                },
                                child: Container(
                                  height: height * 0.035,
                                  width: width * 0.25,
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor.value,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                    child: HrAppText(
                                      text: mLocaleData[
                                          ConfigKeysBody.addEvaluation]!,
                                      style: HeadingTextStyles.heading3
                                          .copyWith(
                                              color: AppColors.walletColor2,
                                              fontFamily: TrueBookFontFamily
                                                  .gUbuntuBold),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Obx(() => ListView.builder(
                                itemCount: controller.apiCalling.value
                                    ? 1
                                    : controller.historyModelList.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  if (controller.apiCalling.value) {
                                    return const Center(
                                        child:
                                            HrAppCircularprogressindicator());
                                  }
                                  final EvaluationReportDtos
                                      evaluationHistoryModel =
                                      controller.historyModelList[index];
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: height * 0.009),
                                    child: HrAppEvaluationHistoryContainer(
                                      evaluationHistoryModel:
                                          evaluationHistoryModel,
                                    ),
                                  );
                                },
                              )),
                        ]),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
