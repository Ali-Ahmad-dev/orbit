import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:orbit/constants/network/network_endpoints.dart';
import 'package:orbit/models/loan_response.dart';
import 'package:orbit/models/login_model.dart';
import 'package:orbit/models/team_member_model.dart';
import 'package:orbit/models/evaluation_param_model.dart';
import 'package:orbit/utils/hr_app_snack_bar.dart';
import '../repositories/evaluation_repository.dart';

class EvaluationController extends GetxController {
  final preferencesController = Get.find<LoginModel>();
  final EvaluationRepository _repository;
  EvaluationController(this._repository);
  var paramList = <Parameter>[].obs;
  EvaluationParameters evaluationParameters = EvaluationParameters();
  TextEditingController commentController = TextEditingController();

  List<TextEditingController> listTextEditingController = [];
  List<Function(double)> onTapList = [];
  RxList<double> listRatings = <double>[].obs;
  final RxString errorMessage = ''.obs;
  final RxBool apiCalling = false.obs;
  final RxBool postApiCalled = true.obs;

  TeamMemberList? member;

  RxDouble totalRating = 0.0.obs;

  @override
  void onInit() {
    member = Get.arguments;
    super.onInit();
    getEvaluationParameters();
  }

  @override
  void dispose() {
    commentController.dispose();
    for (int i = 0; i < listTextEditingController.length; i++) {
      listTextEditingController[i].dispose();
    }
    super.dispose();
  }

  Future<void> createEvaluationReport() async {
    List<Map<String, dynamic>> reportList = [];
    for (int i = 0; i < paramList.length; i++) {
      int evaluationScore = listRatings[i].toInt();
      Map<String, dynamic> report = {
        "EmployeeId": member!.employeeId,
        "EvaluationParameterId": paramList[i].id,
        "Comments": listTextEditingController[i].text,
        "EvaluationScore": evaluationScore,
      };
      reportList.add(report);
    }
    try {
      errorMessage.value = '';
      apiCalling.value = true;

      var data = {
        "AdditionalComments": commentController.text.trim(),
        "EvaluationReport": reportList
      };

      var result = await _repository.addEvaluationReport(
          NetworkEndpoints.createReportEvaluation, data);

      if (result['statusCode'] == 200) {
        LoanResponse loanResponse = LoanResponse.fromJson(result);
        if (!loanResponse.isError) {
          commentController.clear();
          evaluationParameters.parameters?.clear();
          Get.back();
          HrAppSnackBar.showSnackBar(
              title: "Added Successfully",
              duration: 2,
              message: result['message']);
        }
      } else {
        errorMessage.value = result['message'] ?? 'Invalid Input';
      }
    } catch (e) {
      errorMessage.value = 'Failed to apply leave: $e';
    } finally {
      apiCalling.value = false;
    }
  }

  Future<void> getEvaluationParameters() async {
    try {
      errorMessage.value = '';
      final result = await _repository
          .getEvaluationReport(NetworkEndpoints.getEvaluationParameters);

      final status = result['statusCode'];
      print(result);
      evaluationParameters = EvaluationParameters.fromJson(result);
      if (status == 200) {
        paramList.value = evaluationParameters.parameters!;
        initializeEvaluationData();
      } else {
        errorMessage.value = result['message'] ?? 'Unknown error occurred';
      }
    } catch (e) {
      errorMessage.value = 'Failed to fetch leave history: $e';
      print(e);
    } finally {
      postApiCalled.value = false;
    }
  }

  void initializeEvaluationData() {
    for (int i = 0; i < paramList.length; i++) {
      listTextEditingController.add(TextEditingController());
      listRatings.add(0.0);
      onTapList.add((value) {
        listRatings[i] = value;
        totalRating.value = 0.0;
        for (var item in listRatings) {
          totalRating.value = totalRating.value + item;
        }
      });
    }
  }
}
