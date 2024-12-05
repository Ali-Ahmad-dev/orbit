import 'package:get/get.dart';
import 'package:orbit/controllers/bottom_nav_controllers.dart';

class BottomNavBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavController>(
      () => BottomNavController(),
    );
  }
}
