import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/models/pending_request_model.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/utils/text_styles/button_text_styles.dart';
import 'package:orbit/widgets/custom_button.dart';
import 'package:orbit/widgets/hr_app_text.dart';

class HrPendingRequestsContainer extends StatelessWidget {
  final PendingRequestModel pendingRequestModel;
  final Function()? onTap;
  final Function()? onClick;
  const HrPendingRequestsContainer({
    super.key,
    required this.onClick,
    required this.pendingRequestModel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final height = Get.height;
    final width = Get.width;
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            HrAppText(
              text: pendingRequestModel.teamMemberName!,
              style: HeadingTextStyles.heading4.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  fontFamily: TrueBookFontFamily.gUbuntuBold),
            ),
            HrAppText(
              text:
                  'Unapproved Leaves: ${pendingRequestModel.unApprovedLeaveCount}',
              style: HeadingTextStyles.heading4.copyWith(
                  color: Colors.black,
                  fontSize: 10,
                  fontFamily: TrueBookFontFamily.gUbuntuRegulat),
            ),
            SizedBox(
              height: height * 0.009,
            ),
            GestureDetector(
              onTap: onClick,
              child: OrbitClientButton(
                title: 'Leave History',
                widthBtn: 0.35,
                heightBtn: 0.03,
                style: HeadingTextStyles.heading3.copyWith(color: Colors.white),
              ),
            ),
            SizedBox(
              height: height * 0.009,
            )
          ],
        ),
      ),
    );
  }
}
