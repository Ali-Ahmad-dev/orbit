import 'package:get/get.dart';
import 'package:orbit/controllers/notification_controller.dart';
import 'package:orbit/helper/main_helper.dart';
import 'package:orbit/repositories/notification_repository.dart';

class NotificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(
      () => NotificationController(
          NotificationRepository(Get.find<MainHelper>().apiServices)),
    );
  }
}
