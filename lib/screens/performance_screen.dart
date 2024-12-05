import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/config/config_keys_body.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/controllers/performace_controller.dart';
import 'package:orbit/models/performance_model.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/header_container_design.dart';
import 'package:orbit/widgets/reusable_profile_widget.dart';
import 'package:orbit/widgets/hr_app_text.dart';
import 'package:orbit/widgets/performance_container.dart';
import 'package:orbit/widgets/special_container.dart';

class PerformanceScreen extends GetView<PerformaceController> {
  const PerformanceScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mLocaleData =
        OrbitClientApp.mLocale[ConfigKeysTitle.performanceScreen];
    double width = Get.width;
    double height = Get.height;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: controller.refreshPage,
        child: SafeArea(
          child: HeaderContainerDesign(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(width * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ReusableProfileWidget(
                          title: mLocaleData![
                              ConfigKeysBody.performanceContainer]!,
                          name: controller.preferencesController
                              .employeeDetails!.employeeName,
                          post: controller.preferencesController
                              .employeeDetails!.designation,
                        ),
                        SizedBox(height: height * 0.01),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
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
                      child: Obx(
                        () => controller.apiCalling.value
                            ? const Center(child: CircularProgressIndicator())
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                    SizedBox(height: height * 0.01),
                                    HrAppText(
                                      text: mLocaleData[
                                          ConfigKeysBody.performanceContainer]!,
                                      style: HeadingTextStyles.heading4
                                          .copyWith(
                                              color:
                                                  AppColors.primaryColor.value,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              fontFamily: TrueBookFontFamily
                                                  .gUbuntuBold),
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
                                                itemBuilder: (context, index) {
                                                  final Message message =
                                                      controller
                                                          .performanceModel
                                                          .message![index];
                                                  var date = controller
                                                          .performanceModel
                                                          .message![index]
                                                          .createdDateTime ??
                                                      '';
                                                  return Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: height *
                                                                  0.009),
                                                      child: Obx(() =>
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
