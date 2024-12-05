import 'package:get/get.dart';
import 'package:orbit/controllers/leave_history_controller.dart';
import 'package:orbit/helper/main_helper.dart';
import 'package:orbit/repositories/leave_history_repository.dart';

class LeaveHistoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaveHistoryController>(
      () => LeaveHistoryController(
          LeaveHistoryRepository(Get.find<MainHelper>().apiServices)),
    );
  }
}
