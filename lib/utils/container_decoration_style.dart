import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/orbit_client_constants.dart';

class ContainerDecorationStyle {
  static final primary = BoxDecoration(
      color: AppColors.containerPrimaryColor,
      borderRadius: BorderRadius.circular(
          OrbitClientConstants.specialContainerRadiusPrimary));
  static final secondary = BoxDecoration(
      color: AppColors.containerSecondaryColor,
      borderRadius: BorderRadius.circular(
          OrbitClientConstants.specialContainerRadiusSecondary));
  static final listContainerDecorationStyle = BoxDecoration(
    color: AppColors.backgroundColor,
    borderRadius: BorderRadius.circular(OrbitClientConstants.containerRadius),
    boxShadow: [
      BoxShadow(
        color: Colors.black
            .withOpacity(0.05),
        blurStyle: BlurStyle.outer,
        spreadRadius: 0.1,
        blurRadius: 8,
        offset: const Offset(1, 5),
      )
    ],
  );
  static final statusContainerDecoration = BoxDecoration(
      color: AppColors.borderColorOtpContainer,
      borderRadius:
          BorderRadius.circular(OrbitClientConstants.statusContainerRadius));
}
