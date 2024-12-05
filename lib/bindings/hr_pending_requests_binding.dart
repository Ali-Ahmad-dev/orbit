import 'package:get/get.dart';
import 'package:orbit/controllers/hr_pending_requests_controller.dart';
import 'package:orbit/helper/main_helper.dart';
import 'package:orbit/repositories/hr_messages_repository.dart';

class HrPendingRequestsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HRPendingRequestsController>(
      () => HRPendingRequestsController(
          HRMessagesRepository(Get.find<MainHelper>().apiServices)),
    );
  }
}
