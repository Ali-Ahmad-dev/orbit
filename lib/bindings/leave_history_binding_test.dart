import 'package:get/get.dart';

import 'package:orbit/controllers/leave_history_controller_test.dart';
import 'package:orbit/repositories/leave_history_repository.dart';

import '../helper/main_helper.dart';

class LeaveHistoryBindingTest implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaveHistoryControllerTest>(
      () => LeaveHistoryControllerTest(
          LeaveHistoryRepository(Get.find<MainHelper>().apiServices)),
    );
  }
}
