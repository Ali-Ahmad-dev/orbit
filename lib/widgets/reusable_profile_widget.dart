import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/constants/images/asset_images_path.dart';
import 'package:orbit/controllers/dashboard_controller.dart';
import 'package:orbit/helper/main_helper.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/hr_app_text.dart';
import 'package:orbit/widgets/hr_asset_images.dart';

class ReusableProfileWidget extends GetView<DashboardController> {
  final String? name;
  final String? post;
  final String? img;
  final String? title;
  final bool showIcon;
  final bool showImg;
  final Icon? icon;
  final bool isTeamLead;
  final bool showname;
  final bool isHR;
  final bool isHead;
  const ReusableProfileWidget({
    super.key,
    this.img,
    this.isTeamLead = false,
    this.post,
    this.title,
    this.name,
    this.isHR = false,
    this.isHead = false,
    this.showImg = false,
    this.showIcon = false,
    this.icon,
    this.showname = false,
  });
  @override
  Widget build(BuildContext context) {
    final mheight = Get.find<MainHelper>().mScreenHeight;
    final mwidth = Get.find<MainHelper>().mScreenWidth;
    print('$title => $isHR');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (icon != null)
              GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: icon!),
            HrAppText(
              text: title ?? '',
              style: HeadingTextStyles.heading6.copyWith(
                  color: AppColors.backgroundColor,
                  fontSize: 22,
                  fontFamily: TrueBookFontFamily.gUbuntuBold),
            ),
            SizedBox(width: mwidth * 0.02),
            if (showIcon)
              GestureDetector(
                onTap: () {
                  controller.goToSettingScreen();
                },
                child: const Icon(
                  Icons.settings,
                  color: AppColors.backgroundColor,
                  size: 25,
                ),
              )
          ],
        ),
        SizedBox(height: mheight * 0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: showIcon ? mwidth * 0.22 : mwidth * 0.24,
                  width: showIcon ? mwidth * 0.22 : mwidth * 0.24,
                  decoration: showImg
                      ? BoxDecoration(
                          image: DecorationImage(image: NetworkImage(img!)))
                      : const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(AssetImagesPath.avatarSample)),
                        ),
                ),
                SizedBox(
                  width: mwidth * 0.02,
                ),
                SizedBox(
                  width: showIcon && isHR || showIcon && isTeamLead
                      ? mwidth * 0.2
                      : mwidth * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HrAppText(
                        text: name ?? '',
                        style: HeadingTextStyles.heading2.copyWith(
                          color: AppColors.backgroundColor,
                          fontFamily: TrueBookFontFamily.gUbuntuBold,
                          fontSize: 14,
                        ),
                      ),
                      HrAppText(
                        text: post ?? '',
                        style: HeadingTextStyles.heading3.copyWith(
                          fontFamily: TrueBookFontFamily.gUbuntuLight,
                          color: AppColors.backgroundColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (showIcon)
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (isHR || isTeamLead || isHead)
                      Row(
                        children: [
                          if (isHR || isHead)
                            GestureDetector(
                                onTap: () {
                                  controller.goToAnnouncementScreen();
                                },
                                child: const Icon(
                                  Icons.record_voice_over_sharp,
                                  color: Colors.green,
                                )),
                          const SizedBox(width: 5),
                          if (isHR || isHead)
                            GestureDetector(
                                onTap: () {
                                  controller.goToAllLoanScreen();
                                },
                                child: const Icon(
                                  Icons.list_alt_outlined,
                                  color: Colors.green,
                                )),
                          SizedBox(
                            width: Get.width * 0.02,
                          ),
                          if (isHR || isHead)
                            GestureDetector(
                                onTap: () {
                                  controller.goToHRMessageScreen();
                                },
                                child: HrAssetImage(
                                  path: 'assets/images/messages.png',
                                  width: 0.07 * Get.width,
                                )),
                          SizedBox(
                            width: Get.width * 0.02,
                          ),
                          GestureDetector(
                              onTap: () {
                                controller.goToPendingRequest();
                              },
                              child: HrAssetImage(
                                path: 'assets/images/leave.png',
                                width: 0.07 * Get.width,
                              )),
                          SizedBox(
                            width: Get.width * 0.02,
                          ),
                        ],
                      ),
                    GestureDetector(
                        onTap: () {
                          controller.goToNotificationScreen();
                        },
                        child: HrAssetImage(
                          path: 'assets/images/bell.png',
                          width: 0.07 * Get.width,
                        )),
                  ],
                ),
              ),
          ],
        ),
        SizedBox(height: mheight * 0.005),
      ],
    );
  }
}
