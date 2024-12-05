import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/controllers/image_controller.dart';
import '../constants/app_colors.dart';

class ImageScreen extends GetView<ImageController> {
  const ImageScreen({Key? key})
      : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: height * 0.05, horizontal: width * 0.03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() {
                  return controller.selectedImagePath.value == ''
                      ? const Text('No image selected')
                      : Expanded(
                          child: SizedBox(
                            height: height * 0.3,
                            width: width * 0.95,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Image.file(
                                    File(controller.selectedImagePath.value),
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: FloatingActionButton(
                                      backgroundColor: Colors.blue,
                                      child: Icon(
                                        Icons.done,
                                        color: AppColors.walletColor2,
                                      ),
                                      onPressed: () {
                                        controller.goToMessageScreen();
                                      }),
                                ),
                              ],
                            ),
                          ),
                        );
                }),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    controller.pickImage();
                  },
                  child: const Text('Pick Image from Gallery'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
