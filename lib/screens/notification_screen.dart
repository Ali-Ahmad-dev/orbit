import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/config/config_keys_body.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/controllers/notification_controller.dart';
import 'package:orbit/models/notifications_model.dart';
import 'package:orbit/widgets/header_container_design.dart';
import 'package:orbit/widgets/hr_app_circularprogressindicator.dart';
import 'package:orbit/widgets/hr_app_notification_container.dart';
import 'package:orbit/widgets/reusable_profile_widget.dart';
import 'package:orbit/widgets/special_container.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mLocaleData =
        OrbitClientApp.mLocale[ConfigKeysTitle.notificationScreen];
    double width = Get.width;
    double height = Get.height;
    return Scaffold(
      body: SafeArea(
        child: HeaderContainerDesign(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                        title: mLocaleData![ConfigKeysBody.notificationTitle]!,
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: height * 0.03, horizontal: width * 0.05),
                    child: Column(
                      children: [
                        Obx(() => ListView.builder(
                              itemCount: controller.apiCalling.value ||
                                      (controller.notificationsModel != null &&
                                          controller.notificationsModel!
                                              .notifications!.isEmpty)
                                  ? 1
                                  : controller.notificationsModel != null
                                      ? controller.notificationsModel!
                                          .notifications!.length
                                      : 1,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                if (controller.apiCalling.value) {
                                  return const Center(
                                      child: HrAppCircularprogressindicator());
                                }

                                if (controller.notificationsModel == null ||
                                    controller.notificationsModel!
                                        .notifications!.isEmpty) {
                                  return SpecialContainer(
                                    height: 0.07,
                                  );
                                }
                                final Notifications notificationData =
                                    controller.notificationsModel!
                                        .notifications![index];
                                return HrAppNotificationContainer(
                                  notificationModel: notificationData,
                                );
                              },
                            )),
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
