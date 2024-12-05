import 'package:get/get.dart';
import 'package:orbit/controllers/loan_controller.dart';
import 'package:orbit/helper/main_helper.dart';
import 'package:orbit/repositories/loan_repository.dart';

class LoanBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoanController>(
      () => LoanController(LoanRepository(Get.find<MainHelper>().apiServices)),
    );
  }
}
