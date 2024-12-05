import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/controllers/common/button_controller.dart';

class CustomAnimatedButton extends StatelessWidget {
  const CustomAnimatedButton({super.key});
  @override
  Widget build(BuildContext context) {
    final FabController controller = Get.put(FabController());
    return Scaffold(
      body: Stack(
        children: [
          Obx(() => AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                right: controller.isExpanded.value ? 80 : 0,
                bottom: 0,
                child: ScaleTransition(
                  scale: controller.animation,
                  child: FloatingActionButton(
                    heroTag: null,
                    onPressed: () {},
                    child: const Icon(Icons.star),
                  ),
                ),
              )),
          FloatingActionButton(
            onPressed: () {
              controller.toggleFab;
            },
            child: Obx(() => AnimatedBuilder(
                  animation: controller.animation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: controller.animation.value * 0.5 * 3.14,
                      child: Icon(controller.isExpanded.value
                          ? Icons.close
                          : Icons.add),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}
