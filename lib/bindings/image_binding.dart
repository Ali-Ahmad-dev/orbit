import 'package:get/get.dart';
import 'package:orbit/controllers/image_controller.dart';
import 'package:orbit/helper/main_helper.dart';
import 'package:orbit/repositories/image_repository.dart';

class ImageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImageController>(
      () =>
          ImageController(ImageRepository(Get.find<MainHelper>().apiServices)),
    );
  }
}
