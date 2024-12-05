import 'dart:io';
import 'package:chat_message_timestamp/extensions/dateformat_on_datetime.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/config/config_keys_body.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/controllers/message_controller.dart';
import 'package:orbit/widgets/header_container_design.dart';
import 'package:orbit/widgets/hr_app_circularprogressindicator.dart';
import 'package:orbit/widgets/hr_app_message_container.dart';
import 'package:orbit/widgets/hr_voice_record.dart';
import 'package:voice_message_package/voice_message_package.dart';
import '../widgets/reusable_profile_widget.dart';
import '../widgets/textformfield.dart';

class MessageScreen extends GetView<MessageController> {
  const MessageScreen({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    final mLocaleData = OrbitClientApp.mLocale[ConfigKeysTitle.messageScreen];
    return Scaffold(
      body: SafeArea(
        child: HeaderContainerDesign(
            child: Stack(
          children: [
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(width * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ReusableProfileWidget(
                          icon: Icon(
                            Icons.arrow_back,
                            color: AppColors.walletColor2,
                          ),
                          title:
                              mLocaleData![ConfigKeysBody.messageScreenTitle]!,
                          name: !controller.employeeIsHR
                              ? controller.preferencesController
                                  .employeeDetails!.employeeName
                              : controller.chatListModel!.employeeName,
                          post: !controller.employeeIsHR
                              ? controller.preferencesController
                                  .employeeDetails!.designation
                              : controller.chatListModel!.designation,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60),
                        ),
                      ),
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: height * 0.03,
                          ),
                          child: Obx(
                            () => ListView.builder(
                                controller:
                                    controller.paginationUtil.scrollController,
                                itemCount: controller.list.length + 1,
                                shrinkWrap: true,
                                reverse: true,
                                padding: const EdgeInsets.only(
                                    bottom: 50, left: 20, right: 20),
                                itemBuilder: (context, index) {
                                  if (index == controller.list.length) {
                                    return controller.apiCalling.value
                                        ? const Center(
                                            child:
                                                HrAppCircularprogressindicator())
                                        : const SizedBox();
                                  }

                                  print(controller.list.length);
                                  // print(index);
                                  final chat = controller.list[index];
                                  final isSender = controller
                                          .preferencesController
                                          .employeeDetails!
                                          .employeeId
                                          .toString() ==
                                      chat.senderId;
                                  if (chat.contentType == null) {
                                    return const SizedBox();
                                  }
                                  if (chat.contentType == 'text') {
                                    return Align(
                                      alignment: isSender
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      child: Column(
                                        crossAxisAlignment: isSender
                                            ? CrossAxisAlignment.end
                                            : CrossAxisAlignment.start,
                                        children: [
                                          HrAppMessageContainer(
                                            chatModel: chat,
                                          ),
                                          SizedBox(
                                            height: height * 0.02,
                                          ),
                                        ],
                                      ),
                                    );
                                  } else if (chat.contentType == "file") {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          width: width * 0.4,
                                          height: width * 0.4,
                                          child: ClipPath(
                                            clipper: isSender
                                                ? LowerNipMessageClipper(
                                                    MessageType.send)
                                                : UpperNipMessageClipper(
                                                    MessageType.receive),
                                            child: Obx(() => controller
                                                            .progress.value ==
                                                        0.0 ||
                                                    controller.currentIndex
                                                            .value !=
                                                        index
                                                ? GestureDetector(
                                                    onTap: () {
                                                      controller.currentIndex
                                                          .value = index;
                                                      controller.downloadImage(
                                                          chat.data!);
                                                    },
                                                    child: Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: !chat.data!
                                                              .contains('http')
                                                          ? Image.file(
                                                              File(chat.data!))
                                                          : Image.network(
                                                              chat.data!),
                                                    ),
                                                  )
                                                : const Center(
                                                    child:
                                                        CircularProgressIndicator())),
                                          ),
                                        ),
                                        Text(
                                          DateTime.parse(chat.timeStamp!)
                                              .formattedTimeHm,
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          height: height * 0.05,
                                        ),
                                      ],
                                    );
                                  } else if (chat.contentType == 'audio') {
                                    return Container(
                                      alignment: isSender
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      child: ClipPath(
                                        clipper: isSender
                                            ? LowerNipMessageClipper(
                                                MessageType.send)
                                            : UpperNipMessageClipper(
                                                MessageType.receive),
                                        child: VoiceMessageView(
                                          backgroundColor:
                                              const Color(0xff7165d6),
                                          activeSliderColor: Colors.white,
                                          counterTextStyle: const TextStyle(
                                              color: Colors.white),
                                          circlesColor: Colors.green,
                                          controller: VoiceController(
                                            audioSrc: chat.data!,
                                            maxDuration: Duration(
                                                seconds: chat.duration != null
                                                    ? chat.duration!.inSeconds
                                                    : 30),
                                            isFile: chat.data!.contains('http')
                                                ? false
                                                : true,
                                            onComplete: () {},
                                            onPause: () {},
                                            onPlaying: () {},
                                            onError: (err) {},
                                          ),
                                          innerPadding: 10,
                                          cornerRadius: 15,
                                        ),
                                      ),
                                    );
                                  }
                                  return null;
                                }),
                          )),
                    ),
                  ),
                ]),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: HrAppTextFormField(
                controller: controller.messageController,
                hintText: "Type a message..",
                prefixIcon: GestureDetector(
                    onTap: () {
                      controller.startRecording();
                    },
                    child: Icon(
                      Icons.settings_voice_outlined,
                      color: AppColors.primaryColor.value,
                    )),
                suffixIcon: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                        onTap: () {
                          controller.goToImageScreen();
                        },
                        child: const Icon(Icons.attach_file)),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    GestureDetector(
                        onTap: () {
                          controller.sendTextMessage();
                        },
                        child: const Icon(Icons.send)),
                    SizedBox(
                      width: width * 0.02,
                    )
                  ],
                ),
                validator: (value) {
                  print(value);
                  if (value == null || value.isEmpty) {}
                  return null;
                },
              ),
            ),
            Obx(() => Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: controller.recording.value
                    ? Padding(
                        padding: EdgeInsets.only(bottom: height * 0.01),
                        child: HrVoiceRecord(
                          recorderController: controller.recorderController,
                          currentDuration: controller.currentDuration.value,
                          onTapDone: () {
                            controller.stopRecording();
                          },
                          onTapCancel: () {
                            controller.cancelRecording();
                          },
                        ))
                    : const SizedBox())),
          ],
        )),
      ),
    );
  }
}
