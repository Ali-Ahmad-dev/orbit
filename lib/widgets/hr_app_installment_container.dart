import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/constants/models/evaluation_history_model.dart';
import 'package:orbit/constants/models/installment_data.dart';
import 'package:orbit/utils/hr_datetime_util.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/hr_app_text.dart';

class HrAppInstallmentContainer extends StatelessWidget {
  final InstallmentData installmentData;
  final int index;
  final VoidCallback? onTap;
  final int? expandedIndex;

  const HrAppInstallmentContainer({
    Key? key,
    required this.index,
    this.onTap,
    this.expandedIndex,
    required this.installmentData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    double height = Get.height;

    OrbitClientApp.mLocale[ConfigKeysTitle.evaluationScreen];

    final paymentDate = installmentData.paymentDate != null &&
        installmentData.paymentDate != "";
    final dueDate =
        installmentData.dueDate != null && installmentData.dueDate != "";
    final installmentNumber = installmentData.installmentNumber != null;
    final status =
        installmentData.status != null && installmentData.status!.isNotEmpty;
    final amountDue = installmentData.amountDue != null;
    final amountPaid = installmentData.amountPaid != null;
    final penaltyAmount = installmentData.penaltyAmount != null &&
        installmentData.penaltyAmount!.isNotEmpty;
    final remainingBalance = installmentData.remainingBalance != null;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.03, vertical: height * 0.013),
        width: width * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 1,
              offset: const Offset(0.5, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HrAppText(
                  text:
                      'Due Date: ${HrDatetimeUtil.toYearMonthDay(installmentData.dueDate.toString())}',
                  style: HeadingTextStyles.heading2.copyWith(
                    color: AppColors.payment1,
                    fontFamily: TrueBookFontFamily.gUbuntuMedium,
                  ),
                ),
                if (status)
                  HrAppText(
                    maxLines: 5,
                    text: installmentData.status!,
                    style: HeadingTextStyles.heading3.copyWith(
                      color: AppColors.payment1,
                      fontFamily: TrueBookFontFamily.gUbuntuMedium,
                    ),
                  ),
                //const Icon(Icons.arrow_drop_down, color: Colors.black),
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            if (expandedIndex == index) ...[
              HrAppText(
                maxLines: 5,
                text: "Installment Number:",
                style: HeadingTextStyles.heading3.copyWith(
                  color: AppColors.payment1,
                  fontFamily: TrueBookFontFamily.gUbuntuMedium,
                ),
              ),
              if (installmentNumber)
                HrAppText(
                  maxLines: 5,
                  text: installmentData.installmentNumber!.toString(),
                  style: HeadingTextStyles.heading2.copyWith(
                    color: AppColors.payment1,
                  ),
                ),
              SizedBox(
                height: height * 0.01,
              ),
              HrAppText(
                maxLines: 5,
                text: "Amount Due:",
                style: HeadingTextStyles.heading3.copyWith(
                  color: AppColors.payment1,
                  fontFamily: TrueBookFontFamily.gUbuntuMedium,
                ),
              ),
              if (amountDue)
                HrAppText(
                  maxLines: 5,
                  text: installmentData.amountDue!.toString(),
                  style: HeadingTextStyles.heading2.copyWith(
                    color: AppColors.payment1,
                  ),
                ),
              SizedBox(
                height: height * 0.01,
              ),
              HrAppText(
                maxLines: 5,
                text: "Amount Paid:",
                style: HeadingTextStyles.heading3.copyWith(
                  color: AppColors.payment1,
                  fontFamily: TrueBookFontFamily.gUbuntuMedium,
                ),
              ),
              if (amountPaid)
                HrAppText(
                  maxLines: 5,
                  text: installmentData.amountPaid!.toString(),
                  style: HeadingTextStyles.heading2.copyWith(
                    color: AppColors.payment1,
                  ),
                ),
              SizedBox(
                height: height * 0.01,
              ),
              if (paymentDate)
                Column(
                  children: [
                    HrAppText(
                      maxLines: 5,
                      text: "Payment Date:",
                      style: HeadingTextStyles.heading3.copyWith(
                        color: AppColors.payment1,
                        fontFamily: TrueBookFontFamily.gUbuntuMedium,
                      ),
                    ),
                    HrAppText(
                      maxLines: 5,
                      text: HrDatetimeUtil.toYearMonthDay(
                          installmentData.paymentDate.toString()),
                      style: HeadingTextStyles.heading2.copyWith(
                        color: AppColors.payment1,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                  ],
                ),
              HrAppText(
                maxLines: 5,
                text: "Penalty Amount:",
                style: HeadingTextStyles.heading3.copyWith(
                  color: AppColors.payment1,
                  fontFamily: TrueBookFontFamily.gUbuntuMedium,
                ),
              ),
              if (penaltyAmount)
                HrAppText(
                  maxLines: 5,
                  text: installmentData.penaltyAmount!,
                  style: HeadingTextStyles.heading2.copyWith(
                    color: AppColors.payment1,
                  ),
                ),
              SizedBox(
                height: height * 0.01,
              ),
              HrAppText(
                maxLines: 5,
                text: "Remaining Balance:",
                style: HeadingTextStyles.heading3.copyWith(
                  color: AppColors.payment1,
                  fontFamily: TrueBookFontFamily.gUbuntuMedium,
                ),
              ),
              if (remainingBalance)
                HrAppText(
                  maxLines: 5,
                  text: installmentData.remainingBalance!.toString(),
                  style: HeadingTextStyles.heading2.copyWith(
                    color: AppColors.payment1,
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:orbit/constants/app_colors.dart';
// import 'package:orbit/constants/config/config_keys_title.dart';
// import 'package:orbit/constants/fonts/true_book_font_family.dart';
// import 'package:orbit/constants/locale/orbit_client_app.dart';
// import 'package:orbit/constants/models/evaluation_history_model.dart';
// import 'package:orbit/constants/models/installment_data.dart';
// import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
// import 'package:orbit/widgets/hr_app_text.dart';
//
// class HrAppInstallmentContainer extends StatelessWidget {
//   final InstallmentData installmentData;
//
//   final int index; // Add an index parameter
//   final VoidCallback? onTap;
//   final int? expandedIndex;
//
//   const HrAppInstallmentContainer({
//     Key? key,
//     required this.index,
//     this.onTap,
//     this.expandedIndex,
//     required this.installmentData,
//   }) : super(key: key,);
//
//   @override
//   Widget build(BuildContext context) {
//     double width = Get.width;
//     double height = Get.height;
//
//     OrbitClientApp.mLocale[ConfigKeysTitle.evaluationScreen];
//     return  GestureDetector(
//       onTap: onTap,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         padding: EdgeInsets.symmetric(
//             horizontal: width * 0.03, vertical: height * 0.013),
//         width: width * 0.9,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.5),
//               spreadRadius: 0,
//               blurRadius: 1,
//               offset: const Offset(0.5, 1), // changes position of shadow
//             ),
//           ],
//         ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               HrAppText(
//                 text:'Due Date 25-06-2024',
//                 style: HeadingTextStyles.heading2.copyWith(
//                     color: AppColors.payment1,
//                     fontFamily: TrueBookFontFamily.gUbuntuMedium
//                 ),
//               ),
//                const Icon(Icons.arrow_drop_down,color: Colors.black,)
//
//             ],
//           ),
//           if (expandedIndex == index) ...[
//           HrAppText(
//             maxLines: 5,
//             text:"InstallmentNumber"${installmentData.installmentNumber!.toString()},
//             style: HeadingTextStyles.heading2.copyWith(
//               color: AppColors.payment1,
//             ),
//           ),
//           HrAppText(
//             maxLines: 5,
//             text:installmentData.amountDue!.toString(),
//             style: HeadingTextStyles.heading2.copyWith(
//               color: AppColors.payment1,
//             ),
//           ),
//           HrAppText(
//             maxLines: 5,
//             text:installmentData.amountPaid!.toString(),
//             style: HeadingTextStyles.heading2.copyWith(
//               color: AppColors.payment1,
//             ),
//           ),
//           HrAppText(
//             maxLines: 5,
//             text:installmentData.status!,
//             style: HeadingTextStyles.heading2.copyWith(
//               color: AppColors.payment1,
//             ),
//           ),
//           HrAppText(
//             maxLines: 5,
//             text:installmentData.penaltyAmount!,
//             style: HeadingTextStyles.heading2.copyWith(
//               color: AppColors.payment1,
//             ),
//           ),
//           // HrAppText(
//           //   maxLines: 5,
//           //   text:installmentData.paymentDate,
//           //   style: HeadingTextStyles.heading2.copyWith(
//           //     color: AppColors.payment1,
//           //   ),
//           // ),
//           HrAppText(
//             maxLines: 5,
//             text:installmentData.remainingBalance!.toString(),
//             style: HeadingTextStyles.heading2.copyWith(
//               color: AppColors.payment1,
//             ),
//           ),
//     ]
//         ],
//       ),
//       ),
//     );
//   }
// }
