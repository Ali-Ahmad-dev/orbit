import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/config/config_keys_body.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/controllers/evaluation_controller.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/custom_button.dart';
import 'package:orbit/widgets/header_container_design.dart';
import 'package:orbit/widgets/hr_app_evaluation_container_one.dart';
import 'package:orbit/widgets/hr_app_evaluation_container_two.dart';
import 'package:orbit/widgets/hr_app_text.dart';
import '../widgets/reusable_profile_widget.dart';

class EvaluationScreen extends GetView<EvaluationController> {
  const EvaluationScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    final mLocaleData =
        OrbitClientApp.mLocale[ConfigKeysTitle.evaluationScreen];
    return Scaffold(
      body: SafeArea(
        child: HeaderContainerDesign(
          child: SingleChildScrollView(
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
                          title: mLocaleData![
                              ConfigKeysBody.evaluationScreenTitle]!,
                          name: controller.member!.teamMemberName,
                          post: '',
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
                          vertical: height * 0.03, horizontal: width * 0.05),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HrAppText(
                              text: mLocaleData[
                                  ConfigKeysBody.evaluationScreenDescription]!,
                              style: HeadingTextStyles.heading4.copyWith(
                                  color: AppColors.primaryColor.value,
                                  fontFamily: TrueBookFontFamily.gUbuntuMedium),
                            ),
                            Obx(() => controller.apiCalling.value
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : HrAppEvaluationContainerOne(
                                    listRatings: controller.listRatings.value,
                                    listTextEditingController:
                                        controller.listTextEditingController!,
                                    onTap: controller.onTapList,
                                    controller: controller,
                                  )),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Obx(() => HrAppEvaluationContainerTwo(
                                  commentController:
                                      controller.commentController,
                                  totalRating:
                                      controller.totalRating.value.toInt(),
                                )),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Obx(() => GestureDetector(
                                  onTap: controller.postApiCalled.value
                                      ? () {}
                                      : () async {
                                          await controller
                                              .createEvaluationReport();
                                        },
                                  child: OrbitClientButton(
                                    title: 'Submit',
                                    widthBtn: 0.9,
                                    apiCalled: controller.postApiCalled.value,
                                  ),
                                ))
                          ]),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
