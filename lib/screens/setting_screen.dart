import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import '../constants/app_colors.dart';
import '../constants/config/config_keys_body.dart';
import '../constants/fonts/true_book_font_family.dart';
import '../controllers/setting_controller.dart';
import '../utils/text_styles/HeadingTextStyles.dart';
import '../widgets/hr_app_text.dart';

class SettingScreen extends GetView<SettingController> {
  const SettingScreen({Key? key})
      : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;
    final mLocaleData = OrbitClientApp.mLocale[ConfigKeysTitle.settingScreen];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor.value,
        centerTitle: true,
        title: HrAppText(
          text: mLocaleData![ConfigKeysBody.settingScreenTitle]!,
          style: HeadingTextStyles.heading2.copyWith(
              color: AppColors.walletColor2,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: TrueBookFontFamily.gUbuntuBold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.03, vertical: height * 0.03),
          child: Column(
            children: [
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: width * 0.02),
              //   height: height * 0.06,
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(10),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.grey.withOpacity(0.5),
              //         spreadRadius: 1,
              //         blurRadius: 1,
              //       ),
              //     ],
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Row(
              //         children: [
              //           HrAppText(
              //             text: mLocaleData[ConfigKeysBody.settingScreenLogin]!,
              //             style: HeadingTextStyles.heading2.copyWith(
              //                 color: AppColors.payment1,
              //                 fontFamily: TrueBookFontFamily.gUbuntuBold),
              //           ),
              //         ],
              //       ),
              //       Obx(() => Switch(
              //           value: controller.fingerPrintAble.value,
              //           activeColor: Colors.purple,
              //           onChanged: (bool value) {
              //             controller.fingerPrintAble.value = value;
              //             controller.fingerPrintFunction();
              //           })),
              //     ],
              //   ),
              // ),

              //   height: height * 0.03,
              // ),
              GestureDetector(
                onTap: () async {
                  await controller.clearStorage();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                  height: height * 0.06,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      HrAppText(
                        text: mLocaleData[ConfigKeysBody.settingScreenLogout]!,
                        style: HeadingTextStyles.heading2.copyWith(
                            color: AppColors.payment1,
                            fontFamily: TrueBookFontFamily.gUbuntuBold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
