import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../helper/main_helper.dart';

class HrAppTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool readOnly;
  final TextInputType keyboardType;
  final Function()? onTap;
  final String? Function(String?) validator;
  final double? width;
  final EdgeInsetsGeometry? contentPadding;
  final bool filled;
  final Color? fillColor;
  final Color? focusColor;
  final Color enabledColor;
  final Color? borderColor;
  final double borderRadius;
  final BorderSide borderSide;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormatter;

  const HrAppTextFormField({
    Key? key,
    this.inputFormatter,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    this.obscureText = false,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.onTap,
    required this.validator,
    this.width,
    this.contentPadding,
    this.filled = true,
    this.fillColor = Colors.white,
    this.focusColor = Colors.grey,
    this.enabledColor = Colors.black12,
    this.borderColor,
    this.borderRadius = 15.0,
    this.borderSide = const BorderSide(color: Colors.black12, width: 1.0),
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final constraints = MediaQuery.of(context).size;
    final isTablet = constraints.width > 600;
    final widthMain = Get.find<MainHelper>().mScreenWidth;
    final heightMain = Get.find<MainHelper>().mScreenHeight;

    return SizedBox(
      width: width != null ? width! * widthMain : widthMain,
      child: TextFormField(
        inputFormatters: inputFormatter,
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        readOnly: readOnly,
        onTap: onTap,
        cursorColor: AppColors.textColorTextFormField,
        style: TextStyle(color: AppColors.textColorTextFormField),
        decoration: InputDecoration(
          filled: filled,
          fillColor: fillColor,
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodySmall,
          focusColor: focusColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: borderSide,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: focusColor!, width: borderSide.width),
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding: contentPadding,
        ),
        validator: validator,
      ),
    );
  }
}
