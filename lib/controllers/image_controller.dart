import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/models/login_model.dart';
import 'package:orbit/repositories/image_repository.dart';
import 'package:orbit/utils/hr_toast.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {
  final preferencesController = Get.find<LoginModel>();
  final ImageRepository _repository;
  ImageController(this._repository);

  var selectedImagePath = ''.obs;
  var messages = <ChatMessage>[].obs;
  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      print(pickedFile);
    } else {
      HrToast.showToast(msg: 'No image selected', backgroundColor: Colors.red);
    }
  }

  goToMessageScreen() {
    Get.back(result: selectedImagePath.value);
  }
}

class ChatMessage {
  final String? text;
  final String? imagePath;
  final bool isImage;

  ChatMessage({this.text, this.imagePath, this.isImage = false});
}
