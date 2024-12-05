import 'package:get/get.dart';
import 'package:orbit/controllers/hr_messages_controller.dart';
import 'package:orbit/helper/main_helper.dart';
import 'package:orbit/repositories/hr_messages_repository.dart';

class HrMessagesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HRMessagesController>(
      () => HRMessagesController(
          HRMessagesRepository(Get.find<MainHelper>().apiServices)),
    );
  }
}
