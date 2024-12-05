import 'package:flutter/material.dart';

class HrAssetImage extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final BoxFit boxFit;
  const HrAssetImage({
    super.key,
    required this.path,
    this.width,
    this.boxFit = BoxFit.fill,
    this.height,
  });
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      fit: boxFit,
      path,
      width: width,
      height: height,
    );
  }
}