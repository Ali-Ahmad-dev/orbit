import 'package:flutter/material.dart';
import 'package:orbit/constants/app_colors.dart';

class HrAppCircularprogressindicator extends StatelessWidget {
  const HrAppCircularprogressindicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.width * 0.05,
        width: MediaQuery.of(context).size.width * 0.05,
        child: CircularProgressIndicator(
          strokeWidth: 4.0,
          color: AppColors.primaryColor.value,
        ));
  }
}
