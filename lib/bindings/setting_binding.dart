import 'package:get/get.dart';
import 'package:orbit/controllers/setting_controller.dart';
import 'package:orbit/helper/main_helper.dart';
import 'package:orbit/repositories/setting_repository.dart';

class SettingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingController>(
      () => SettingController(
          SettingRepository(Get.find<MainHelper>().apiServices)),
    );
  }
}
