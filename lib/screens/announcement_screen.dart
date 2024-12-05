import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/config/config_keys_body.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/controllers/announcement_controller.dart';
import 'package:orbit/widgets/header_container_design.dart';
import 'package:orbit/widgets/reusable_profile_widget.dart';

class AnnouncementScreen extends GetView<AnnouncementController> {
  const AnnouncementScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mLocaleData =
        OrbitClientApp.mLocale[ConfigKeysTitle.announcementScreen];
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
                      ReusableProfileWidget(
                        icon: Icon(
                          Icons.arrow_back,
                          color: AppColors.walletColor2,
                        ),
                        title: mLocaleData![
                            ConfigKeysBody.announcementScreenTitle]!,
                        name:
                            mLocaleData[ConfigKeysBody.announcementScreenNku]!,
                        post: mLocaleData[ConfigKeysBody.announcementScreenHr]!,
                      ),
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
                        children: [],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
