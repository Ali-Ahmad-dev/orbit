import 'package:get/get.dart';
import 'package:orbit/controllers/performance_team_report_controller.dart';
import 'package:orbit/helper/main_helper.dart';
import 'package:orbit/repositories/performance_team_report_repository.dart';

class PerformanceTeamReportBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PerformanceTeamReportController>(
      () => PerformanceTeamReportController(
        PerformanceTeamReportRepository(Get.find<MainHelper>().apiServices),
      ),
    );
  }
}
