import 'package:get/get.dart';
import 'package:orbit/controllers/login_controller.dart';
import 'package:orbit/helper/main_helper.dart';
import 'package:orbit/repositories/login_repository.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () =>
          LoginController(LoginRepository(Get.find<MainHelper>().apiServices)),
    );
  }
}
