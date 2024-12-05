import 'package:get/get.dart';
import 'package:orbit/controllers/add_record_controller.dart';
import 'package:orbit/helper/main_helper.dart';
import 'package:orbit/repositories/add_record_repository.dart';

class AddRecordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddRecordController>(
      () => AddRecordController(
          AddRecordRepository(Get.find<MainHelper>().apiServices)),
    );
  }
}
