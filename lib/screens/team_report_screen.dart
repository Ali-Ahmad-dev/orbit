import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/config/config_keys_body.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/controllers/login_controller.dart';
import 'package:orbit/controllers/team_report_controller.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/header_container_design.dart';
import 'package:orbit/widgets/hr_app_circularprogressindicator.dart';
import 'package:orbit/widgets/hr_app_team_report_container.dart';
import 'package:orbit/widgets/hr_app_text.dart';
import '../widgets/reusable_profile_widget.dart';

class TeamReportScreen extends GetView<TeamReportController> {
  final int? id;
  const TeamReportScreen({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    final mLocaleData =
        OrbitClientApp.mLocale[ConfigKeysTitle.teamReportScreen];

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
                        title:
                            mLocaleData![ConfigKeysBody.teamReportScreenTitle]!,
                        name: controller.preferencesController.employeeDetails!
                            .employeeName,
                        post: controller
                            .preferencesController.employeeDetails!.designation,
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
                        vertical: height * 0.03, horizontal: width * 0.06),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HrAppText(
                          text: mLocaleData[
                              ConfigKeysBody.teamReportScreenDescription]!,
                          style: HeadingTextStyles.heading4.copyWith(
                            color:
                                Get.find<LoginController>().designation.value ==
                                        'Team Lead'
                                    ? AppColors.primaryGreenColor
                                    : Get.find<LoginController>()
                                                    .designation
                                                    .value ==
                                                'HR' ||
                                            Get.find<LoginController>()
                                                    .designation
                                                    .value ==
                                                'HR Lead'
                                        ? AppColors.primaryBlue
                                        : AppColors.primaryColor.value,
                            fontFamily: TrueBookFontFamily.gUbuntuMedium,
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        TextFormField(
                          onChanged: (value) {
                            controller.filterTeamMembers(value);
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            hintText: 'Search Team Members',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        Obx(
                          () => controller.apiCalling.value
                              ? const Center(
                                  child: HrAppCircularprogressindicator())
                              : GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 15,
                                    childAspectRatio: 0.75,
                                  ),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      controller.filteredTeamMemberList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final teamMember = controller
                                        .filteredTeamMemberList[index];
                                    return GestureDetector(
                                      onTap: () {
                                        controller
                                            .goToMemberAttendanceReportScreen(
                                                teamMember);
                                      },
                                      child: HrAppTeamReportContainer(
                                        name: teamMember.teamMemberName ??
                                            mLocaleData[ConfigKeysBody
                                                .teamReportScreenName]!,
                                        totalLeaves:
                                            '${teamMember.leaveCount ?? mLocaleData[ConfigKeysBody.teamReportScreenLeave]!}',
                                        onTap: () {
                                          controller
                                              .goToEvaluationHistoryScreen(
                                                  teamMember);
                                        },
                                        onClick: () {
                                          controller
                                              .goToPerformanceTeamReportScreen(
                                                  teamMember);
                                        },
                                      ),
                                    );
                                  },
                                ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
