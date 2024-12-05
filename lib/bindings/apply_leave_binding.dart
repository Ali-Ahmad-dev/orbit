import 'package:get/get.dart';
import 'package:orbit/controllers/apply_leave_controller.dart';
import 'package:orbit/helper/main_helper.dart';
import 'package:orbit/repositories/apply_leave_repository.dart';

class ApplyLeaveBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplyLeaveController>(
      () => ApplyLeaveController(
          ApplyLeaveRepository(Get.find<MainHelper>().apiServices)),
    );
  }
}
