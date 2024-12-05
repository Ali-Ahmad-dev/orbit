import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/controllers/login_controller.dart';

class HeaderContainerDesign extends StatelessWidget {
  final Widget child;

  const HeaderContainerDesign({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Color.alphaBlend(Colors.black.withOpacity(0.1),
                    AppColors.primaryColor.value),
                Color.alphaBlend(Colors.white.withOpacity(0.1),
                    AppColors.primaryColor.value),
                Color.alphaBlend(Colors.white.withOpacity(0.2),
                    AppColors.primaryColor.value),
              ],
            ),
          ),
          child: child,
        ));
  }
}
