import 'package:get/get.dart';
import 'package:orbit/controllers/evaluation_history_controller.dart';
import 'package:orbit/repositories/evaluation_history_repository.dart';

import '../helper/main_helper.dart';

class EvaluationHistoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EvaluationHistoryController>(() => EvaluationHistoryController(
        EvaluationHistoryRepository(Get.find<MainHelper>().apiServices)));
  }
}
