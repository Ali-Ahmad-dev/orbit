import 'package:permission_handler/permission_handler.dart';

class HrPermissionsUtils{

  static Future<bool> requestPermission(Permission permission) async {
    switch(permission){
      case Permission.storage:
        return await _storagePermission();
      case Permission.photos:
        return await _photoPermission();
      case Permission.microphone:
        return await _microphonePermission();
      default:
        return false;
    }
  }

  static Future<bool> _storagePermission() async {
    var status = await Permission.storage.request();

    if(status.isGranted){
      return true;
    }
    return false;
  }

  static Future<bool> _photoPermission() async {
    var status = await Permission.photos.request();
    if(status.isGranted){
      return true;
    }
    return false;
  }

  static Future<bool> _microphonePermission() async {
    var status = await Permission.microphone.request();
    if(status.isGranted){
      return true;
    }
    return false;
  }
}