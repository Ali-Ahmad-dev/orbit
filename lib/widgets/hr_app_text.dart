import 'package:flutter/material.dart';
import '../utils/text_styles/HeadingTextStyles.dart';

class HrAppText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int? maxLines;
  final TextAlign? textAlign;
  const HrAppText(
      {super.key,
      required this.text,
      this.maxLines = 1,
      this.textAlign,
      this.style});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      style: style ?? HeadingTextStyles.heading1,
    );
  }
}
