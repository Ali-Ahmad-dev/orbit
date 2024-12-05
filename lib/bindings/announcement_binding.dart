import 'package:get/get.dart';
import 'package:orbit/controllers/announcement_controller.dart';
import 'package:orbit/helper/main_helper.dart';
import 'package:orbit/repositories/announcement_repository.dart';

class AnnouncementBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnnouncementController>(
      () => AnnouncementController(
          AnnouncementRepository(Get.find<MainHelper>().apiServices)),
    );
  }
}
