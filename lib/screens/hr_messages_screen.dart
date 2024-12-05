import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/config/config_keys_body.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/controllers/hr_messages_controller.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/header_container_design.dart';
import 'package:orbit/widgets/hr_app_circularprogressindicator.dart';
import 'package:orbit/widgets/reusable_profile_widget.dart';
import 'package:orbit/widgets/hr_app_text.dart';
import '../widgets/hr_app_chat_container.dart';

class HRMessagesScreen extends GetView<HRMessagesController> {
  const HRMessagesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mLocaleData = OrbitClientApp.mLocale[ConfigKeysTitle.hrChats];
    double width = Get.width;
    double height = Get.height;
    return Scaffold(
      body: SafeArea(
        child: HeaderContainerDesign(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildProfileWidget(mLocaleData, width, height),
                      SizedBox(height: height * 0.01),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: height * 0.03, horizontal: width * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeaderText(mLocaleData),
                        SizedBox(height: height * 0.03),
                        _buildChatList(),
                      ],
                    ),
                  ),
                ),
                // const SpecialContainer(),
                // SizedBox(height: height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileWidget(
      Map<String, dynamic>? mLocaleData, double width, double height) {
    return ReusableProfileWidget(
      icon: Icon(
        Icons.arrow_back,
        color: AppColors.walletColor2,
      ),
      title: mLocaleData?[ConfigKeysBody.title] ?? '',
      name:
          controller.preferencesController.employeeDetails?.employeeName ?? '',
      post: controller.preferencesController.employeeDetails?.designation ?? '',
    );
  }

  Widget _buildHeaderText(Map<String, dynamic>? mLocaleData) {
    return HrAppText(
      text: mLocaleData?[ConfigKeysBody.bodyTitle] ?? '',
      style: HeadingTextStyles.heading4.copyWith(
        color: AppColors.primaryColor.value,
        fontWeight: FontWeight.bold,
        fontSize: 20,
        fontFamily: TrueBookFontFamily.gUbuntuBold,
      ),
    );
  }

  Widget _buildChatList() {
    return Obx(() => ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.apiCalling.value
              ? controller.hrChatList.length + 1
              : controller.hrChatList.length,
          itemBuilder: (context, index) {
            if (index == 0 &&
                controller.apiCalling.value &&
                controller.hrChatList.isEmpty) {
              return const Center(child: HrAppCircularprogressindicator());
            }
            final chat = controller.hrChatList[index];
            return GestureDetector(
              onTap: () {
                controller.goToMessageScreen(chat);
              },
              child: HrAppChatContainer(
                chatListModel: chat,
              ),
            );
          },
        ));
  }
}
