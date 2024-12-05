import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/config/config_keys_body.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/controllers/dashboard_controller.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/header_container_design.dart';
import 'package:orbit/widgets/reusable_profile_widget.dart';
import 'package:orbit/widgets/hr_app_text.dart';
import 'package:orbit/widgets/leaves_calculation_container.dart';
import 'package:orbit/widgets/reports_container.dart';
import 'package:orbit/widgets/time_sheet.dart';
import '../constants/images/asset_images_path.dart';
import '../widgets/hr_asset_images.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mLocaleData = OrbitClientApp.mLocale[ConfigKeysTitle.dashboardScreen];
    double width = Get.width;
    double height = Get.height;
    final user = controller.loginController.employeeDetails!.aspNetUserId;
    final hr = controller.loginController.hrLeadDetails!.aspNetUserId;
    return Scaffold(
      body: HeaderContainerDesign(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: height * 0.05),
              Padding(
                padding: EdgeInsets.all(width * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ReusableProfileWidget(
                      title: mLocaleData![ConfigKeysBody.dashboardBody13]!,
                      name: controller
                          .loginController.employeeDetails!.employeeName,
                      post: controller
                          .loginController.employeeDetails!.designation,
                      showIcon: true,
                      isTeamLead: user == 2326,
                      isHR: user == hr ||
                          controller.loginController.employeeDetails!
                                  .designation ==
                              "HR",
                      // isHead: controller
                      //         .loginController.employeeDetails!.designation ==
                      //     "Solution Architect",
                      //  isHead: user == isHead ||
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
                  padding: EdgeInsets.all(width * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: height * 0.01),
                      HrAppText(
                        text: mLocaleData[ConfigKeysBody.dashboardBody1]!,
                        style: HeadingTextStyles.heading4.copyWith(
                            color: AppColors.descriptionColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: TrueBookFontFamily.gUbuntuBold),
                      ),
                      SizedBox(height: height * 0.01),
                      LeavesCalculationContainer(
                        text2: controller
                            .loginController.currentMonthHours!.totalHours!
                            .toStringAsFixed(2),
                        text3: controller.loginController.currentMonthLeaves,
                      ),
                      SizedBox(height: height * 0.01),
                      HrAppText(
                        text: mLocaleData[ConfigKeysBody.dashboardBody2]!,
                        style: HeadingTextStyles.heading4.copyWith(
                            color: AppColors.descriptionColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: TrueBookFontFamily.gUbuntuBold),
                      ),
                      SizedBox(height: height * 0.02),
                      Center(
                        child: HrAppText(
                          text: 'No Records Found',
                          style: HeadingTextStyles.heading4.copyWith(
                              color: AppColors.primaryColor.value,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              fontFamily: TrueBookFontFamily.gUbuntuBold),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      HrAppText(
                        text: mLocaleData[ConfigKeysBody.dashboardBody3]!,
                        style: HeadingTextStyles.heading4.copyWith(
                            color: AppColors.descriptionColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: TrueBookFontFamily.gUbuntuBold),
                      ),
                      SizedBox(height: height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.goToSalarySlipScreen();
                            },
                            child: ReportsContainer(
                              centerText:
                                  mLocaleData[ConfigKeysBody.dashboardBody4]!,
                              color: AppColors.dashboardColor1,
                              image: const HrAssetImage(
                                path: AssetImagesPath.dashboardSalary,
                                width: 20,
                                height: 20,
                              ),
                              onTap: () {},
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.goToTeamReportScreen();
                            },
                            child: ReportsContainer(
                              centerText:
                                  mLocaleData[ConfigKeysBody.dashboardBody5]!,
                              color: Colors.deepOrange,
                              image: const HrAssetImage(
                                path: AssetImagesPath.dashboardTeam,
                                width: 20,
                                height: 20,
                              ),
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.015),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.goToLoanScreen();
                            },
                            child: ReportsContainer(
                              centerText:
                                  mLocaleData[ConfigKeysBody.dashboardBody6]!,
                              color: AppColors.dashboardColor2,
                              image: const HrAssetImage(
                                path: AssetImagesPath.dashboardLoan,
                                width: 20,
                                height: 20,
                              ),
                              onTap: () {},
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.goToMessageScreen();
                            },
                            child: Opacity(
                              opacity: user == hr ? 0.5 : 1.0,
                              child: ReportsContainer(
                                centerText:
                                    mLocaleData[ConfigKeysBody.dashboardBody7]!,
                                color: AppColors.dashboardColor4,
                                image: const HrAssetImage(
                                  path: AssetImagesPath.dashboardMessage,
                                  width: 20,
                                  height: 20,
                                ),
                                onTap: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.03),
                      HrAppText(
                        text: mLocaleData[ConfigKeysBody.dashboardBody8]!,
                        style: HeadingTextStyles.heading4.copyWith(
                            color: AppColors.descriptionColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: TrueBookFontFamily.gUbuntuBold),
                      ),
                      SizedBox(height: height * 0.015),
                      TimeSheetWidget(
                        employees: controller.loginController.timeSheet!,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
