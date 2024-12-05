import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/config/config_keys_body.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/models/performance_model.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/header_container_design.dart';
import 'package:orbit/widgets/hr_app_circularprogressindicator.dart';
import 'package:orbit/widgets/hr_app_text.dart';
import 'package:orbit/widgets/performance_container.dart';
import 'package:orbit/widgets/special_container.dart';
import '../controllers/performance_team_report_controller.dart';
import '../widgets/reusable_profile_widget.dart';

class PerformanceTeamReportScreen
    extends GetView<PerformanceTeamReportController> {
  const PerformanceTeamReportScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    final mLocaleData =
        OrbitClientApp.mLocale[ConfigKeysTitle.performanceTeamReportScreen];
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
                              ConfigKeysBody.performanceTeamReportScreenTitle]!,
                          name: controller.member!.teamMemberName,
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
                      child: Obx(
                        () => controller.apiCalling.value
                            ? const Center(
                                child: HrAppCircularprogressindicator())
                            : Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.04),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(height: height * 0.01),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          HrAppText(
                                            text: mLocaleData[ConfigKeysBody
                                                .performanceTeamReportScreenDescription]!,
                                            style: HeadingTextStyles.heading4
                                                .copyWith(
                                                    color: AppColors
                                                        .primaryColor.value,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                    fontFamily:
                                                        TrueBookFontFamily
                                                            .gUbuntuBold),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              controller.goToAddRecordScreen();
                                            },
                                            child: Container(
                                              height: height * 0.035,
                                              width: width * 0.2,
                                              decoration: BoxDecoration(
                                                  color: AppColors
                                                      .primaryColor.value,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Center(
                                                child: HrAppText(
                                                  text: mLocaleData[ConfigKeysBody
                                                      .performanceTeamReportScreenAddRecord]!,
                                                  style: HeadingTextStyles
                                                      .heading3
                                                      .copyWith(
                                                          color: AppColors
                                                              .walletColor2,
                                                          fontFamily:
                                                              TrueBookFontFamily
                                                                  .gUbuntuBold),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: height * 0.01),
                                      Column(
                                        children: [
                                          controller.performanceModel.message!
                                                  .isEmpty
                                              ? const SpecialContainer()
                                              : ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  reverse: true,
                                                  itemCount: controller
                                                      .performanceModel
                                                      .message!
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final Message message =
                                                        controller
                                                            .performanceModel
                                                            .message![index];
                                                    var date = controller
                                                            .performanceModel
                                                            .message![index]
                                                            .createdDateTime ??
                                                        '';
                                                    return Obx(() => Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical:
                                                                    height *
                                                                        0.009),
                                                        child:
                                                            PerformanceContainer(
                                                          onTap: () => controller
                                                              .toggleExpanded(
                                                                  index),
                                                          index: index,
                                                          expandedIndex:
                                                              controller
                                                                  .expandedIndex
                                                                  .value,
                                                          problem:
                                                              message.problem,
                                                          severity: controller
                                                                  .performanceModel
                                                                  .message![
                                                                      index]
                                                                  .severity ??
                                                              '',
                                                          suggestion: controller
                                                                  .performanceModel
                                                                  .message![
                                                                      index]
                                                                  .suggestion ??
                                                              '',
                                                          date:
                                                              '${'Listed On'} ${(date.substring(0, min(date.length, 10)))}',
                                                        )));
                                                  })
                                        ],
                                      ),
                                    ]),
                              ),
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
