import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/images/asset_images_path.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/constants/models/hr_chat_list_model.dart';
import 'package:orbit/utils/hr_datetime_util.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/hr_app_text.dart';

import 'hr_asset_images.dart';

class HrAppChatContainer extends StatelessWidget {
  final HrChatListModel chatListModel;
  const HrAppChatContainer({Key? key, required this.chatListModel})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;

    OrbitClientApp.mLocale[ConfigKeysTitle.hrChats];
    return ListTile(
      leading: const CircleAvatar(
        radius: 25,
        child: HrAssetImage(path: AssetImagesPath.avatarSample),
      ),
      title: HrAppText(
        text: chatListModel.employeeName ?? "",
        style: HeadingTextStyles.heading2.copyWith(color: Colors.black),
      ),
      subtitle: HrAppText(
        text: chatListModel.message ?? "",
        style: HeadingTextStyles.heading3,
      ),
      trailing: HrAppText(
        text: HrDatetimeUtil.toHourAndMin(chatListModel.timeStamp!),
        style: HeadingTextStyles.heading2.copyWith(color: Colors.black),
      ),
    );
  }
}
