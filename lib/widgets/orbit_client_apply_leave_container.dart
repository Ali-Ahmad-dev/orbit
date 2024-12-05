import 'package:flutter/material.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/widgets/hr_app_text.dart';

class OrbitClientApplyLeaveContainer extends StatelessWidget {
  int selectedValue;
  final Function(int?)? onChanged;
  final String text;
  final int radioValue;
  final TextStyle? style;
  OrbitClientApplyLeaveContainer(
      {super.key,
      required this.selectedValue,
      required this.onChanged,
      required this.text,
      required this.radioValue,
      this.style});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.only(left: 0.0, right: 0.0, top: 0, bottom: 0),
      horizontalTitleGap: 5,
      leading: Radio<int>(
        activeColor: AppColors.primaryColor.value,
        value: radioValue,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity),
        groupValue: selectedValue,
        onChanged: onChanged,
      ),
      title: HrAppText(
        text: text,
        style: style,
      ),
    );
  }
}
