import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/widgets/hr_app_text.dart';

class HrVoiceRecord extends StatelessWidget {
  final RecorderController recorderController;
  final int currentDuration;
  final Function()? onTapDone;
  final Function()? onTapCancel;
  const HrVoiceRecord({
    super.key,
    required this.recorderController,
    required this.currentDuration,
    required this.onTapDone,
    required this.onTapCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      margin: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HrAppText(
            text: '00:$currentDuration',
            style: const TextStyle(color: Colors.white),
          ),
          AudioWaveforms(
            size: Size(Get.width * 0.6, Get.height * 0.12),
            recorderController: recorderController,
            enableGesture: false,
            waveStyle: const WaveStyle(
                showDurationLabel: false,
                showHourInDuration: false,
                showBottom: false,
                durationLinesColor: Colors.transparent,
                extendWaveform: true,
                showMiddleLine: false,
                showTop: true,
                labelSpacing: 0,
                waveCap: StrokeCap.round,
                waveColor: Colors.blue),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: onTapCancel,
                child: Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.red),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.02),
              GestureDetector(
                onTap: onTapDone,
                child: Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.green),
                  child: const Icon(
                    Icons.done,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
