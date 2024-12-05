import 'package:get/get.dart';
import 'package:orbit/controllers/message_controller.dart';
import 'package:orbit/helper/main_helper.dart';
import 'package:orbit/repositories/message_repository.dart';

class MessageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MessageController>(
      () => MessageController(
          MessageRepository(Get.find<MainHelper>().apiServices)),
    );
  }
}
