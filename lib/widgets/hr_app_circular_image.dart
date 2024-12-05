import 'package:flutter/material.dart';
import 'package:orbit/constants/images/asset_images_path.dart';

class HrAppCircularImage extends StatelessWidget {
  const HrAppCircularImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 190.0,
        height: 190.0,
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(AssetImagesPath.avatarSample))));
  }
}
