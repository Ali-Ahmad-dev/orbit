import 'package:get/get.dart';
import 'package:orbit/controllers/salary_slip_controller.dart';
import 'package:orbit/helper/main_helper.dart';
import 'package:orbit/repositories/salary_slip_repository.dart';

class SalarySlipBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalarySlipController>(
      () => SalarySlipController(
          SalarySlipRepository(Get.find<MainHelper>().apiServices)),
    );
  }
}
