import 'package:get/get.dart';
import 'package:orbit/controllers/performace_controller.dart';
import 'package:orbit/helper/main_helper.dart';
import 'package:orbit/repositories/performance_repository.dart';

class PerformanceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PerformaceController>(
      () => PerformaceController(
          PerformanceRepository(Get.find<MainHelper>().apiServices)),
    );
  }
}
