import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/config/config_keys_body.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/constants/models/all_loans_model.dart';
import 'package:orbit/controllers/all_loan_controller.dart';
import 'package:orbit/utils/hr_datetime_util.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/header_container_design.dart';
import 'package:orbit/widgets/hr_app_circularprogressindicator.dart';
import 'package:orbit/widgets/hr_app_text.dart';
import 'package:orbit/widgets/hr_asset_images.dart';
import 'package:orbit/widgets/reusable_profile_widget.dart';
import '../constants/images/asset_images_path.dart';

class AllLoanScreen extends GetView<AllLoanController> {
  const AllLoanScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mLocaleData = OrbitClientApp.mLocale[ConfigKeysTitle.allLoanScreen];
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
                        title: mLocaleData![ConfigKeysBody.allLoanScreenTiTle]!,
                        name: mLocaleData[ConfigKeysBody.allLoanScreenNku]!,
                        post: mLocaleData[ConfigKeysBody.allLoanScreenHr]!,
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
                        children: [
                          Obx(() => ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              reverse: true,
                              itemCount: controller.apiCalling.value
                                  ? 1
                                  : controller.list.length,
                              itemBuilder: (context, index) {
                                if (controller.apiCalling.value) {
                                  return const Center(
                                      child: HrAppCircularprogressindicator());
                                }
                                final AllLoansModel allLoanModel =
                                    controller.list[index];
                                return GestureDetector(
                                  onTap: () {
                                    controller.goToLoanScreen(allLoanModel);
                                  },
                                  child: ListTile(
                                    leading: const CircleAvatar(
                                      radius: 25,
                                      child: HrAssetImage(
                                          path: AssetImagesPath.avatarSample),
                                    ),
                                    title: HrAppText(
                                      text: allLoanModel.employeeName!,
                                      // text: mLocaleData[ConfigKeysBody.allLoanScreenEmployee]!,
                                      style: HeadingTextStyles.heading2
                                          .copyWith(
                                              color: AppColors.descriptionColor,
                                              fontFamily: TrueBookFontFamily
                                                  .gUbuntuMedium),
                                    ),
                                    subtitle: HrAppText(
                                      text: allLoanModel.designation!,
                                      // text: mLocaleData[ConfigKeysBody.allLoanScreenDesignation]!,
                                      style: HeadingTextStyles.heading3
                                          .copyWith(
                                              color: AppColors.descriptionColor,
                                              fontFamily: TrueBookFontFamily
                                                  .gUbuntuBold),
                                    ),
                                    trailing: HrAppText(
                                      text: HrDatetimeUtil.toYearMonthDay(
                                          allLoanModel.timeStamp!),
                                      // text: mLocaleData[ConfigKeysBody.allLoanScreenDate]!,
                                      style: HeadingTextStyles.heading2
                                          .copyWith(
                                              color: AppColors.descriptionColor,
                                              fontFamily: TrueBookFontFamily
                                                  .gUbuntuBold),
                                    ),
                                  ),
                                );
                              }))
                        ],
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
