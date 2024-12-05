import 'package:get/get.dart';
import 'package:orbit/controllers/evaluation_controller.dart';
import 'package:orbit/helper/main_helper.dart';
import 'package:orbit/repositories/evaluation_repository.dart';

class EvaluationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EvaluationController>(
      () => EvaluationController(
          EvaluationRepository(Get.find<MainHelper>().apiServices)),
    );
  }
}
