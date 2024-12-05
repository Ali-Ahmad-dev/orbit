import 'package:get/get.dart';
import 'package:orbit/controllers/team_report_controller.dart';
import 'package:orbit/helper/main_helper.dart';
import 'package:orbit/repositories/team_report_repository.dart';

class TeamReportBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeamReportController>(
      () => TeamReportController(
          TeamReportRepository(Get.find<MainHelper>().apiServices)),
    );
  }
}
