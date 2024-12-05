import 'package:get/get.dart';
import 'package:orbit/controllers/employee_leave_history_controller.dart';
import 'package:orbit/helper/main_helper.dart';
import 'package:orbit/repositories/employee_leave_history_repo.dart';

class EmployeeLeaveHistoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmployeeLeaveHistoryController>(
      () => EmployeeLeaveHistoryController(
          EmployeeLeaveHistoryRepo(Get.find<MainHelper>().apiServices)),
    );
  }
}
