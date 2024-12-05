import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/network/network_endpoints.dart';
import 'package:orbit/models/loan_response.dart';
import 'package:orbit/models/login_model.dart';
import 'package:orbit/models/team_member_model.dart';
import 'package:orbit/utils/hr_app_snack_bar.dart';
import '../repositories/add_record_repository.dart';

class AddRecordController extends GetxController {
  final preferencesController = Get.find<LoginModel>();
  final AddRecordRepository _repository;
  AddRecordController(this._repository);
  RxInt selectedValue = 1.obs;
  RxInt selectedValueContainerOne = 1.obs;
  final RxString errorMessage = ''.obs;
  var severity = ''.obs;
  final RxBool apiCalling = false.obs;
  final TextEditingController problemController = TextEditingController();
  final TextEditingController suggestionController = TextEditingController();

  TeamMemberList? member;

  @override
  void onInit() {
    member = Get.arguments;
    super.onInit();
  }

  @override
  void dispose() {
    problemController.dispose();
    suggestionController.dispose();
    super.dispose();
  }

  Future<void> addMemberPerformance() async {
    try {
      errorMessage.value = '';
      apiCalling.value = true;

      var data = {
        "EmployeeId": member!.employeeId,
        "Problem": problemController.text.trim(),
        "Suggestion": suggestionController.text.trim(),
        "Severity": severity.value
      };
      print(data);
      var result = await _repository.addMemberPerformance(
          NetworkEndpoints.addMemberPerformance, data);
      final status = result['statusCode'];
      print('ddddddddddddddddddddddddd');
      print(result);

      if (status == 200) {
        LoanResponse loanResponse = LoanResponse.fromJson(result);
        if (loanResponse.isError == false) {
          Get.back();

          HrAppSnackBar.showSnackBar(
              title: "Added Successfully",
              duration: 2,
              message: result['message']);
        }
      } else {
        print('ddddddddddddddddddddddddd');
        errorMessage.value = 'Invalid Input';
      }
    } catch (e) {
      print(e);
      errorMessage.value = e.toString();
    } finally {
      apiCalling.value = false;
    }
  }
}
