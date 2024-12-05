import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/orbit_client_constants.dart';
import '../text_styles/HeadingTextStyles.dart';

class InputDecorationsTextFormField {
  static final primary = InputDecoration(
    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    filled: true,
    fillColor: AppColors.secondaryColor,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: OrbitClientConstants.widthBorderSideTextFormField,
        color: AppColors.secondaryColor,
      ),
      borderRadius:
          BorderRadius.circular(OrbitClientConstants.borderRadiusTextFormField),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: OrbitClientConstants.widthBorderSideTextFormField,
        color: AppColors.secondaryColor,
      ),
      borderRadius:
          BorderRadius.circular(OrbitClientConstants.borderRadiusTextFormField),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 1, color: Colors.red),
      borderRadius:
          BorderRadius.circular(OrbitClientConstants.borderRadiusTextFormField),
    ),
    hoverColor: Colors.black,
    hintStyle: HeadingTextStyles.heading2
        .copyWith(color: AppColors.textColorTextFormField),
  );

  static final secondary = InputDecoration(
    fillColor: AppColors.secondaryColor,
    filled: true,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius:
          BorderRadius.circular(OrbitClientConstants.borderRadiusTextFormField),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 1, color: Colors.red),
      borderRadius:
          BorderRadius.circular(OrbitClientConstants.borderRadiusTextFormField),
    ),
  );
}
