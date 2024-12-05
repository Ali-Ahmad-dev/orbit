import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/network/network_endpoints.dart';
import 'package:orbit/models/leave_history_model.dart';
import 'package:orbit/models/login_model.dart';
import 'package:orbit/repositories/leave_history_repository.dart';
import 'package:orbit/utils/hr_path_provider.dart';
import 'package:orbit/utils/hr_toast.dart';
import '../helper/main_helper.dart';

class LeaveHistoryController extends GetxController {
  final LeaveHistoryRepository _repository;
  LeaveHistoryController(this._repository);

  final preferencesController = Get.find<LoginModel>();
  final mainHelper = Get.find<MainHelper>();

  LeaveHistory? leaveHistory;
  final RxString errorMessage = ''.obs;
  final RxBool apiCalling = false.obs;

  var progress = <RxDouble>[].obs;
  RxBool isPasswordObsecure = true.obs;
  var isExpanded = false.obs;
  var expandedIndex = (-1).obs;
  final String imageUrl = 'https://images4.alphacoders.com/122/1228259.png';

  void toggleExpanded(int index) {
    if (expandedIndex.value == index) {
      expandedIndex.value = -1;
    } else {
      expandedIndex.value = index;
    }
  }

  @override
  void onInit() {
    getLeaveHistory();
    super.onInit();
  }

  Future<void> getLeaveHistory() async {
    final loginController = Get.find<LoginModel>();
    var id = loginController.employeeDetails!.employeeId;
    try {
      errorMessage.value = '';
      apiCalling.value = true;

      final result = await _repository.getLeaveHistory(
          '${NetworkEndpoints.getLeaveHistory}?EmployeeId=$id');

      final status = result['statusCode'];
      print(result);

      if (status == 200) {
        leaveHistory = LeaveHistory.fromJson(result);
      } else {
        errorMessage.value = result['message'] ?? 'Unknown error occurred';
      }
    } catch (e) {
      errorMessage.value = 'Failed to fetch leave history: $e';
      print(e);
    } finally {
      apiCalling.value = false;
    }
  }
}

  // goToApplyLeaveScreen() {
  //   Get.toNamed(RouteEndpoints.applyLeaveScreen);
  // }
  

