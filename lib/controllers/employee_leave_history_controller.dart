import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/jsons/leave_history_data.dart';
import 'package:orbit/constants/jsons/leave_request_data.dart';
import 'package:orbit/constants/network/network_endpoints.dart';
import 'package:orbit/models/leave_history_model.dart';
import 'package:orbit/models/login_model.dart';
import 'package:orbit/models/pending_request_model.dart';
import 'package:orbit/repositories/employee_leave_history_repo.dart';
import 'package:orbit/repositories/leave_history_repository.dart';
import 'package:orbit/utils/hr_path_provider.dart';
import 'package:orbit/utils/hr_toast.dart';
import '../helper/main_helper.dart';

class EmployeeLeaveHistoryController extends GetxController {
  final EmployeeLeaveHistoryRepo _repository;
  EmployeeLeaveHistoryController(this._repository);

  final preferencesController = Get.find<LoginModel>();
  final mainHelper = Get.find<MainHelper>();
  PendingRequestModel? pendingRequestModel;
  LeaveHistory? leaveHistory;
  final RxString errorMessage = ''.obs;
  final RxBool apiCalling = false.obs;
  var progress = 0.0.obs;
  RxBool isPasswordObsecure = true.obs;
  var isExpanded = false.obs;
  String imageUrl = 'https://images4.alphacoders.com/122/1228259.png';
  var approvedByTL = <LeaveHistoryDetail>[].obs;
  var rejectedByTL = <LeaveHistoryDetail>[].obs;
  var approvedByHR = <LeaveHistoryDetail>[].obs;
  var rejectedByHR = <LeaveHistoryDetail>[].obs;
  final RxInt expandedIndexForApprovedByTL = (-1).obs;
  final RxInt expandedIndexForRejectedByTL = (-1).obs;
  final RxInt expandedIndexForApprovedByHR = (-1).obs;
  final RxInt expandedIndexForRejectedByHR = (-1).obs;

  void toggleExpanded(int index, {required String listType}) {
    switch (listType) {
      case 'approvedByTL':
        if (expandedIndexForApprovedByTL.value == index) {
          expandedIndexForApprovedByTL.value = -1;
        } else {
          expandedIndexForApprovedByTL.value = index;
        }
        break;
      case 'rejectedByTL':
        if (expandedIndexForRejectedByTL.value == index) {
          expandedIndexForRejectedByTL.value = -1;
        } else {
          expandedIndexForRejectedByTL.value = index;
        }
        break;
      case 'approvedByHR':
        if (expandedIndexForApprovedByHR.value == index) {
          expandedIndexForApprovedByHR.value = -1;
        } else {
          expandedIndexForApprovedByHR.value = index;
        }
        break;
      case 'rejectedByHR':
        if (expandedIndexForRejectedByHR.value == index) {
          expandedIndexForRejectedByHR.value = -1;
        } else {
          expandedIndexForRejectedByHR.value = index;
        }
        break;
    }
  }

  @override
  void onInit() {
    pendingRequestModel = Get.arguments;
    getLeaveHistory();
    // leaveHistory = LeaveHistory.fromJson(leaveHistoryData);

    // processLeaveHistoryData();
    super.onInit();
  }

  Future<void> downloadImage(LeaveHistoryDetail approvedLeaves) async {
    final url = approvedLeaves.attachment;
    final name = url!.split("/").last;

    progress.value = 0.0001;
    print('====1');
    final result = await HrPathProvider.downloadFile(
      url: url,
      fileName: name,
      progressCallback: (current, total) {
        progress.value = (current / total);
        print('Downloading: ${progress.value}');
      },
      onDone: () async {
        progress.value = 0.0;
        print('onDone');
        HrToast.showToast(
            msg: 'File Downloaded successfully.', backgroundColor: Colors.red);
      },
    );
    if (result == 200) {
      progress.value = 0.0;
    }
  }

  // Future<void> downloadImage(String url, String fileName) async {
  //   progress.value = 0.0001;
  //   print('====1');
  //   await HrPathProvider.downloadFile(
  //     url: url,
  //     fileName: fileName,
  //     progressCallback: (current, total) {
  //       progress.value = (current / total);
  //       print('Downloading: ${progress.value}');
  //     },
  //     onDone: () async {
  //       progress.value = 0.0;
  //       print('onDone');
  //       HrToast.showToast(
  //           msg: 'File Downloaded successfully.', backgroundColor: Colors.red);
  //     },
  //   );
  // }

  void processLeaveHistoryData() {
    if (leaveHistory != null && leaveHistory!.leaveHistoryDetails != null) {
      for (var detail in leaveHistory!.leaveHistoryDetails!) {
        for (var i = 0; i < (detail.isApprovedByTl?.length ?? 0); i++) {
          approvedByTL.add(detail);
        }
        for (var i = 0; i < (detail.isRejectedByTl?.length ?? 0); i++) {
          rejectedByTL.add(detail);
        }
        for (var i = 0; i < (detail.isApprovedByHr?.length ?? 0); i++) {
          approvedByHR.add(detail);
        }
        for (var i = 0; i < (detail.isRejectedByHr?.length ?? 0); i++) {
          rejectedByHR.add(detail);
        }
      }
    }
  }

  void processLeaveHistoryDataUpdated() {
    if (leaveHistory != null && leaveHistory!.leaveHistoryDetails != null) {
      approvedByTL.value = leaveHistory!.leaveHistoryDetails!
          .where((item) => item.isApprovedByTl!.length > 0)
          .toList();
      rejectedByTL.value = leaveHistory!.leaveHistoryDetails!
          .where((item) => item.isRejectedByTl!.length > 0)
          .toList();
      approvedByHR.value = leaveHistory!.leaveHistoryDetails!
          .where((item) => item.isApprovedByHr!.length > 0)
          .toList();
      rejectedByHR.value = leaveHistory!.leaveHistoryDetails!
          .where((item) => item.isRejectedByHr!.length > 0)
          .toList();
      // for (var detail in leaveHistory!.leaveHistoryDetails!) {
      //   print('processLeaveHistory => ${detail.isApprovedByHr}');
      //   for (var i = 0; i < (detail.isApprovedByTl?.length ?? 0); i++) {
      //     approvedByTL.add(detail);
      //   }
      //   for (var i = 0; i < (detail.isRejectedByTl?.length ?? 0); i++) {
      //     rejectedByTL.add(detail);
      //   }
      //   for (var i = 0; i < (detail.isApprovedByHr?.length ?? 0); i++) {
      //     approvedByHR.add(detail);
      //   }
      //   for (var i = 0; i < (detail.isRejectedByHr?.length ?? 0); i++) {
      //     rejectedByHR.add(detail);
      //   }
      // }
    }
  }

  List<DateTime> getDateRange(DateTime start, DateTime end) {
    List<DateTime> dateList = [];
    for (int i = 0; i <= end.difference(start).inDays; i++) {
      dateList.add(start.add(Duration(days: i)));
    }
    return dateList;
  }

  Future<void> getLeaveHistory() async {
    var id = pendingRequestModel!.employeeId;
    try {
      errorMessage.value = '';
      apiCalling.value = true;

      final result = await _repository.getEmployeeLeaveHistory(
          '${NetworkEndpoints.getLeaveHistory}?EmployeeId=$id');

      final status = result['statusCode'];
      print(result);

      if (status == 200) {
        leaveHistory = LeaveHistory.fromJson(result);
        // processLeaveHistoryData();
        processLeaveHistoryDataUpdated();
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
