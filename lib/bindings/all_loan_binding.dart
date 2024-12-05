import 'package:get/get.dart';
import 'package:orbit/controllers/all_loan_controller.dart';
import 'package:orbit/helper/main_helper.dart';
import 'package:orbit/repositories/all_loan_repository.dart';

class AllLoanBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllLoanController>(
      () => AllLoanController(
          AllLoanRepository(Get.find<MainHelper>().apiServices)),
    );
  }
}
