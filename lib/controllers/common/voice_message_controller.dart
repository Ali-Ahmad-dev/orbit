import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:orbit/constants/hr_permissions_utils.dart';
import 'package:orbit/constants/models/chat_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class VoiceMessageController extends GetxController {
  final RxList<ChatModel> list;
  VoiceMessageController(this.list);
  FlutterSoundRecorder? _recorder;
  RxBool isRecording = false.obs;
  RxBool isPlaying = false.obs;
  String filePath = '';

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> initData() async {
    _recorder = FlutterSoundRecorder();
    AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
    final currentSdkVersion = androidInfo.version.sdkInt;
    if (currentSdkVersion > 32) {
      await HrPermissionsUtils.requestPermission(Permission.photos);
    } else {
      await HrPermissionsUtils.requestPermission(Permission.storage);
    }
    await HrPermissionsUtils.requestPermission(Permission.microphone);
    initRecorder();
  }

  Future<void> initRecorder() async {
    final directory = await getApplicationDocumentsDirectory();
    filePath = '${directory.path}/voice_message.aac';
    await _recorder!.openRecorder();
  }

  Future<void> startRecording() async {
    print('startRecording | $filePath');
    isRecording.value = true;
    await _recorder!.startRecorder(
      toFile: filePath,
      codec: Codec.aacADTS,
    );
  }

  Future<void> stopRecording() async {
    final result = await _recorder!.stopRecorder();
    print('stopRecording | $result');
    isRecording.value = false;
    var data = {
      "data": result,
      "timeStamp": "2023-07-08T12:35:56Z",
      "senderId": 2330,
      "receiverId": 1234,
      "contentType": "audio"
    };
    list.add(ChatModel.fromJson(data));
  }

  Future<void> sendVoiceMessage() async {
    File recordedFile = File(filePath);
  }

  @override
  void dispose() {
    _recorder!.closeRecorder();
    super.dispose();
  }
}
