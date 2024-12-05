import 'package:get/get.dart';
import 'package:orbit/controllers/add_record_controller.dart';
import 'package:orbit/controllers/apply_leave_controller.dart';
import 'package:orbit/controllers/leave_requests_controller.dart';
import 'package:orbit/controllers/leave_requests_controller_test.dart';
import 'package:orbit/controllers/member_attendance_report_controller.dart';
import 'package:orbit/helper/main_helper.dart';
import 'package:orbit/repositories/add_record_repository.dart';
import 'package:orbit/repositories/apply_leave_repository.dart';
import 'package:orbit/repositories/leave_requests_repo.dart';
import 'package:orbit/repositories/member_attendance_report_repository.dart';

class LeaveRequestsTestBinding implements Bindings {
  @override
  void dependencies() {
    // final id = Get.parameters['id'] != null
    //     ? int.tryParse(Get.parameters['id']!)
    //     : null;
    // final String name = Get.parameters['name'] ?? 'unknown';
    Get.lazyPut<LeaveRequestsTestController>(
      () => LeaveRequestsTestController(
        LeaveRequestsRepository(Get.find<MainHelper>().apiServices),
      ),
    );
  }
}
