import 'package:get/get.dart';
import 'package:orbit/controllers/attendance_report_controller.dart';
import 'package:orbit/helper/main_helper.dart';
import 'package:orbit/repositories/attendance_report_repo.dart';

class AttendanceReportBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AttendanceReportController>(
      () => AttendanceReportController(
          AttendanceReportRepository(Get.find<MainHelper>().apiServices)),
    );
  }
}
