import 'package:get/get.dart';
import 'package:orbit/constants/jsons/installment_data.dart';
import 'package:orbit/constants/models/all_loans_model.dart';
import 'package:orbit/constants/models/installment_data.dart';
import 'package:orbit/constants/network/network_endpoints.dart';
import 'package:orbit/helper/main_helper.dart';
import 'package:orbit/models/loan_history_model.dart';
import 'package:orbit/models/login_model.dart';
import 'package:orbit/repositories/loan_repository.dart';
import '../constants/routes/routes_endpoints.dart';

class LoanController extends GetxController {
  final preferencesController = Get.find<LoginModel>();
  final LoanRepository _repository;
  final loginController = Get.find<LoginModel>();
  LoanController(this._repository);

  final mainHelper = Get.find<MainHelper>();

  LoanHistoryModel loanHistory = LoanHistoryModel();
  final RxString errorMessage = ''.obs;
  final RxBool apiCalling = false.obs;
  var expandedIndex = (-1).obs;
  var expandedIndexInstallments = (-1).obs;

  AllLoansModel? allLoansModel;

  void toggleExpanded(int index) {
    if (expandedIndex.value == index) {
      expandedIndex.value = -1;
    } else {
      expandedIndex.value = index;
    }
  }

  void toggleExpandedInstallments(int index) {
    if (expandedIndexInstallments.value == index) {
      expandedIndexInstallments.value = -1;
    } else {
      expandedIndexInstallments.value = index;
    }
  }

  InstallmentData? installmentData;

  RxList<InstallmentData> installmentList = <InstallmentData>[].obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      allLoansModel = Get.arguments;
    }
    getLoanHistory();
    // installmentData = Get.arguments;
    installmentList.value =
        installment_data.map((item) => InstallmentData.fromJson(item)).toList();
    super.onInit();
  }

  Future<void> getLoanHistory() async {
    var id = allLoansModel == null
        ? loginController.employeeDetails!.employeeId
        : allLoansModel!.employeeId;
    try {
      errorMessage.value = '';
      apiCalling.value = true;

      var result = await _repository
          .getLoanHistory('${NetworkEndpoints.getLoanHistory}?EmployeeId=$id');
      final status = result['statusCode'];
      print(result);
      if (status == 200) {
        print(result);
        loanHistory = LoanHistoryModel.fromJson(result);
        if (loanHistory.isError == true) {
          errorMessage.value = 'An Error has occurred';
        }
      } else {
        errorMessage.value = result['message'];
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      apiCalling.value = false;
    }
  }

  goToApplyLoanScreen() async {
    await Get.toNamed(RouteEndpoints.applyLoanScreen);
    await getLoanHistory();
  }
}
