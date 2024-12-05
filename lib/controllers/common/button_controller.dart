import 'package:get/get.dart';
import 'package:flutter/material.dart';

class FabController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxBool isExpanded = false.obs;
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 1).animate(animationController);
  }

  void toggleFab() {
    if (isExpanded.value) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
    isExpanded.toggle();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
