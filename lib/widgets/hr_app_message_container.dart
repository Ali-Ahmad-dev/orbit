import 'dart:io';
import 'package:chat_message_timestamp/extensions/dateformat_on_datetime.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/constants/models/chat_model.dart';
import 'package:orbit/models/login_model.dart';
import 'package:orbit/utils/hr_datetime_util.dart';

class HrAppMessageContainer extends StatelessWidget {
  final ChatModel chatModel;
  final bool isFile;
  const HrAppMessageContainer(
      {Key? key, required this.chatModel, this.isFile = false})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    final mLocaleData = OrbitClientApp.mLocale[ConfigKeysTitle.messageScreen];
    final userId = Get.find<LoginModel>().employeeDetails!.employeeId;
    final isSender = userId.toString() == chatModel.senderId.toString();
    return Container(
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: ClipPath(
          clipper: isSender
              ? LowerNipMessageClipper(MessageType.send)
              : UpperNipMessageClipper(MessageType.receive),
          child: Container(
              padding: const EdgeInsets.only(
                  left: 20, top: 10, bottom: 25, right: 20),
              decoration: const BoxDecoration(
                color: Color(0xff7165d6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isFile)
                    SizedBox(
                      width: width * 0.3,
                      height: width * 0.3,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Image.file(File(chatModel.data!)),
                      ),
                    ),
                  if (!isFile)
                    Text(
                      chatModel.data!,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  Text(
                    HrDatetimeUtil.toHourAndMin(chatModel.timeStamp!),
                    // DateTime.parse(chatModel.timeStamp!).formattedTimeHm,
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ],
              )),
        ));
  }
}
