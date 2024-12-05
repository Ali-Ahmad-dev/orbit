import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:orbit/constants/jsons/evaluation_history_data.dart';
import 'package:orbit/constants/models/evaluation_history_model.dart';
import 'package:orbit/constants/network/network_endpoints.dart';
import 'package:orbit/constants/routes/routes_endpoints.dart';
import 'package:orbit/models/evaluation_history_model.dart';
import 'package:orbit/models/login_model.dart';
import 'package:orbit/repositories/evaluation_history_repository.dart';
import 'package:orbit/utils/hr_app_snack_bar.dart';
import '../models/team_member_model.dart';

class EvaluationHistoryController extends GetxController {
  final EvaluationHistoryRepository _repository;
  EvaluationHistoryController(this._repository);

  TeamMemberList? teamMember;

  RxBool apiCalling = true.obs;

  RxList<EvaluationReportDtos> historyModelList = <EvaluationReportDtos>[].obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      teamMember = Get.arguments;
    }
    getEvaluationHistory();
    // historyModelList.value = evaluation_history_data.map((item) => EvaluationHistoryModel.fromJson(item)).toList();
    super.onInit();
  }

  Future<void> getEvaluationHistory() async {
    final loginModel = Get.find<LoginModel>();
    try {
      var result = await _repository.getEvaluationHistory(
          '${NetworkEndpoints.getEvaluationHistory}?employeeId=${teamMember != null ? teamMember!.employeeId : loginModel.employeeDetails!.employeeId}');
      final status = result['statusCode'];
      print(status);

      if (status == 200) {
        EvaluationHistoryModel evaluationHistoryModel =
            EvaluationHistoryModel.fromJson(result);
        historyModelList.value = evaluationHistoryModel.evaluationReportDtos!;
      } else {
        HrAppSnackBar.showSnackBar(
            title: "Failed",
            duration: 3,
            backgroundColor: Colors.red,
            message: result['message']);
      }
    } catch (e) {
      print(e);
    } finally {
      apiCalling.value = false;
    }
  }

  goToEvaluationScreen() {
    Get.toNamed(RouteEndpoints.evaluationScreen, arguments: teamMember);
  }
}
