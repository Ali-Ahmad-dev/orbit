import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HrVoiceAudio extends StatelessWidget {
  final PlayerController playerController;
  final Function()? onTapPlay;
  final bool playing;
  const HrVoiceAudio({
    super.key,
    required this.playerController,
    required this.onTapPlay,
    required this.playing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      margin: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        GestureDetector(
        onTap: onTapPlay,
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: !playing ? Colors.green : Colors.red
          ),
          child: Icon(
            !playing ? Icons.play_arrow : Icons.pause,
            color: Colors.white,
          ),
        ),
      ),
          AudioFileWaveforms(
            size: Size(Get.width * 0.6, Get.height * 0.1),
            playerController: playerController,
            enableSeekGesture: true,
            waveformType: WaveformType.long,
            playerWaveStyle: const PlayerWaveStyle(
              fixedWaveColor: Colors.blue,
              liveWaveColor: Colors.blueAccent,
              showSeekLine: false,
              showTop: true,
              spacing: 6,
            ),
          ),
        ],
      ),
    );
  }
}
