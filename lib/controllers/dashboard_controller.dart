import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/models/login_model.dart';
import 'package:orbit/services/websocket_services.dart';
import 'package:orbit/utils/hr_app_snack_bar.dart';
import 'package:orbit/utils/shared_prefrences.dart';
import '../constants/routes/routes_endpoints.dart';

class DashboardController extends GetxController {
  final loginController = Get.find<LoginModel>();
  goToNotificationScreen() {
    Get.toNamed(RouteEndpoints.notificationScreen);
  }

  goToSalarySlipScreen() {
    Get.toNamed(RouteEndpoints.salarySlipScreen);
  }

  goToAllLoanScreen() {
    Get.toNamed(RouteEndpoints.allLoanScreen);
  }

  goToLoanScreen() {
    Get.toNamed(RouteEndpoints.loanScreen);
  }

  goToMessageScreen() {
    final user = loginController.employeeDetails!.aspNetUserId;
    final hr = loginController.hrLeadDetails!.aspNetUserId;
    if (user == hr) return;
    Get.toNamed(RouteEndpoints.messageScreen);
  }

  goToSettingScreen() {
    Get.toNamed(RouteEndpoints.settingScreen);
  }

  goToTeamReportScreen() {
    final userId = loginController.employeeDetails!.aspNetUserId;
    print(userId);
    final teamLeadId = loginController.teamLeadDetails!.aspNetUserId;
    if (userId == 2326 || userId == 2325 || userId == 2314) {
      Get.toNamed(RouteEndpoints.teamReportScreen);
      return;
    }
    HrAppSnackBar.showSnackBar(
        title: "Failed",
        message: "Only Team lead can see Team Reports",
        backgroundColor: Colors.red);
  }

  void goToHRMessageScreen() {
    Get.toNamed(RouteEndpoints.hrMessagesScreen);
  }

  void goToPendingRequest() {
    Get.toNamed(RouteEndpoints.hrPendingRequestsScreen);
  }

  goToAnnouncementScreen() {
    Get.toNamed(RouteEndpoints.announcementScreen);
  }
}
