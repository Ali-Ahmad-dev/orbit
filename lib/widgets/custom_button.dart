import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/controllers/login_controller.dart';
import 'package:orbit/widgets/hr_app_text.dart';
import 'package:orbit/widgets/hr_circularprogressindicator.dart';
import '../utils/text_styles/button_text_styles.dart';

class OrbitClientButton extends StatelessWidget {
  final String title;
  final Color? color;
  final TextStyle? style;
  final bool apiCalled;
  final double widthBtn;
  final double? heightBtn;
  final double? radius;

  OrbitClientButton({
    Key? key,
    required this.title,
    this.color,
    required this.widthBtn,
    this.radius = 25,
    this.heightBtn = 0.065,
    this.style,
    this.apiCalled = false,
  }) : super(key: key);

  Color _determineColor() {
    if (!Get.isRegistered<LoginController>()) {
      return AppColors.primaryColor.value;
    }

    var designation = Get.find<LoginController>().designation.value;
    if (designation == 'Team Lead') {
      return AppColors.primaryGreenColor;
    } else if (designation == 'HR') {
      return AppColors.primaryBlue;
    } else {
      return AppColors.primaryColor.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Container(
      height: height * heightBtn!,
      width: width * widthBtn,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius!),
        color: color ??
            _determineColor(), // Use the color from the constructor or determine it
      ),
      child: Center(
        child: !apiCalled
            ? HrAppText(
                text: title,
                style: style ?? ButtonTextStyles.heading1,
              )
            : const HrCircularprogressindicator(),
      ),
    );
  }
}
