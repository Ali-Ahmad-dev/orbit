import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/network/network_endpoints.dart';
import 'package:orbit/models/loan_model.dart';
import 'package:orbit/models/loan_response.dart';
import 'package:orbit/models/login_model.dart';
import 'package:orbit/repositories/apply_loan_repository.dart';
import 'package:orbit/utils/hr_app_snack_bar.dart';

class ApplyLoanController extends GetxController {
  final loginController = Get.find<LoginModel>();
  final ApplyLoanRepository _repository;
  ApplyLoanController(this._repository);

  final TextEditingController amountController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();
  final TextEditingController installmentController = TextEditingController();
  final selectedTypeData = '* Selected Type '.obs;
  int selectedTypeId = 0;
  final RxString errorMessage = ''.obs;
  final RxBool apiCalling = false.obs;
  RxList<DeductionTypes> deductionList = RxList<DeductionTypes>([]);
  bool snackbar = false;
  @override
  void onInit() {
    getDeductionTypes();
    super.onInit();
  }

  @override
  void dispose() {
    amountController.dispose();
    reasonController.dispose();
    installmentController.dispose();

    super.dispose();
  }

  Future<void> getDeductionTypes() async {
    try {
      errorMessage.value = '';
      apiCalling.value = true;

      final result = await _repository
          .getDeductionTypes(NetworkEndpoints.getDeductionType);

      final status = result['statusCode'];
      print(result);

      if (status == 200) {
        List<DeductionTypes>? deductionTypes = [];
        (result['data'] as List).forEach((element) {
          if (element != null) {
            deductionTypes.add(DeductionTypes.fromJson(element));
          }
        });
        deductionList.value = deductionTypes;
        selectedTypeData.value = deductionTypes.first.name!;
        selectedTypeId = deductionTypes.first.id!;
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

  Future<void> applyLoan() async {
    try {
      errorMessage.value = '';
      apiCalling.value = true;
      var id = loginController.employeeDetails!.employeeId;
      var data = {
        "EmployeeId": id,
        "Amount": amountController.text,
        "DeductionTypeId": selectedTypeId,
        "Reason": reasonController.text,
        "NumberOfInstallments": installmentController.text.trim()
      };
      print(data);
      var result =
          await _repository.applyLoan(NetworkEndpoints.applyLoan, data);
      final status = result['statusCode'];

      print(result);

      if (status == 200) {
        LoanResponse loanResponse = LoanResponse.fromJson(result);
        if (loanResponse.isError == false) {
          Get.back();
          HrAppSnackBar.showSnackBar(
              title: "Applied Successfully",
              duration: 2,
              message: loanResponse.message);
        }
      } else {
        HrAppSnackBar.showSnackBar(
            title: "Failed",
            duration: 3,
            backgroundColor: Colors.red,
            message: result['message']);
      }
    } catch (e) {
      print(e);
      errorMessage.value = e.toString();
    } finally {
      apiCalling.value = false;
    }
  }
}
