import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class VoiceMessageModel {
  FlutterSoundRecorder? _recorder;
  final FlutterSoundPlayer _player = FlutterSoundPlayer();

  Future<void> init() async {
    _recorder = FlutterSoundRecorder();
    var status = await Permission.camera.request();
    print(status);
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException("Microphone permission not granted");
    }
    await _recorder!.openRecorder();
    await _player.openPlayer();
  }

  Future<void> startRecording(String path) async {
    await _recorder!.startRecorder(toFile: path);
  }

  Future<void> stopRecording() async {
    await _recorder!.stopRecorder();
  }

  Future<void> playRecording(String path) async {
    await _player.startPlayer(fromURI: path);
  }

  Future<void> stopPlayback() async {
    await _player.stopPlayer();
  }

  void dispose() {
    _recorder!.closeRecorder();
    _player.closePlayer();
  }
}
