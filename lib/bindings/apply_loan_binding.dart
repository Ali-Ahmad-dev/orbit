import 'package:get/get.dart';
import 'package:orbit/controllers/apply_loan_controller.dart';
import 'package:orbit/helper/main_helper.dart';
import 'package:orbit/repositories/apply_loan_repository.dart';

class ApplyLoanBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplyLoanController>(
      () => ApplyLoanController(
          ApplyLoanRepository(Get.find<MainHelper>().apiServices)),
    );
  }
}
