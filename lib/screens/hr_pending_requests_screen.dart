import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/config/config_keys_body.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/controllers/hr_pending_requests_controller.dart';
import 'package:orbit/models/pending_request_model.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/header_container_design.dart';
import 'package:orbit/widgets/hr_app_circularprogressindicator.dart';
import 'package:orbit/widgets/reusable_profile_widget.dart';
import 'package:orbit/widgets/hr_app_text.dart';
import 'package:orbit/widgets/hr_pending_requests_container.dart';
import 'package:orbit/widgets/special_container.dart';

class HRPendingRequestScreen extends GetView<HRPendingRequestsController> {
  const HRPendingRequestScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mLocaleData =
        OrbitClientApp.mLocale[ConfigKeysTitle.hrPendingRequest];
    double width = Get.width;
    double height = Get.height;
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
                        title: mLocaleData![ConfigKeysBody.title]!,
                        name: controller.preferencesController.employeeDetails!
                            .employeeName,
                        post: controller
                            .preferencesController.employeeDetails!.designation,
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
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(width * 0.05),
                    child: Obx(
                      () => controller.apiCalling.value
                          ? const Center(
                              child: HrAppCircularprogressindicator())
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                  SizedBox(height: height * 0.01),
                                  HrAppText(
                                    text:
                                        mLocaleData[ConfigKeysBody.bodyTitle]!,
                                    style: HeadingTextStyles.heading4.copyWith(
                                        color: AppColors.primaryColor.value,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        fontFamily:
                                            TrueBookFontFamily.gUbuntuBold),
                                  ),
                                  SizedBox(height: height * 0.01),
                                  Column(
                                    children: [
                                      controller.reqList.isEmpty
                                          ? const SpecialContainer()
                                          : GridView.builder(
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                              ),
                                              itemCount:
                                                  controller.reqList.length,
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                final PendingRequestModel
                                                    pendingRequest =
                                                    controller.reqList[index];
                                                print(pendingRequest);
                                                return HrPendingRequestsContainer(
                                                  pendingRequestModel:
                                                      pendingRequest,
                                                  onTap: () {
                                                    controller
                                                        .goToLeaveRequestScreen(
                                                            pendingRequest);
                                                  },
                                                  onClick: () {
                                                    controller
                                                        .goToEmployeeLeaveHistoryScreen(
                                                            pendingRequest);
                                                  },
                                                );
                                              }),
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
    );
  }
}
