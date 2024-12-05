import 'package:get/get.dart';
import 'package:orbit/controllers/member_attendance_report_controller.dart';
import 'package:orbit/helper/main_helper.dart';
import 'package:orbit/repositories/member_attendance_report_repository.dart';

class MemberAttendanceReportBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MemberAttendanceReportController>(
      () => MemberAttendanceReportController(
        MemberAttendanceReportRepository(Get.find<MainHelper>().apiServices),
      ),
    );
  }
}
