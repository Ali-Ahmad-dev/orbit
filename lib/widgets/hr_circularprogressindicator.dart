import 'package:flutter/material.dart';
import 'package:orbit/constants/app_colors.dart';

class HrCircularprogressindicator extends StatelessWidget {
  const HrCircularprogressindicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.width * 0.05,
        width: MediaQuery.of(context).size.width * 0.05,
        child: const CircularProgressIndicator(
          strokeWidth: 4.0,
          color: Colors.blue,
        ));
  }
}
