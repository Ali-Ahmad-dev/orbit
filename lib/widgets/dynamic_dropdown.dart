import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/hr_app_text.dart';

class DynamicDropdownBottomSheet extends StatelessWidget {
  final List<String> items;
  String? selectedValue;
  final void Function(String?) onChanged;
  final String? heading;
  final String title;
  final double? width;

  DynamicDropdownBottomSheet({
    this.heading = '',
    required this.items,
    required this.selectedValue,
    required this.title,
    required this.onChanged,
    this.width,
  });

  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    final constraint =
        MediaQuery.of(context).size.width + MediaQuery.of(context).size.height;
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width * 0.9,
      height: heading != '' ? constraint * 0.045 : constraint * 0.034,
      child: ElevatedButton(
          style: ButtonStyle(
            side: WidgetStateProperty.all(
                BorderSide(color: AppColors.listContainerTextColor, width: 1)),
            padding: WidgetStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 8)),
            elevation: WidgetStateProperty.all(0),
            backgroundColor: WidgetStateProperty.all(
                isDark == true ? Colors.grey.shade900 : Colors.white),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(10.0), // Border radius value
              ),
            ),
          ),
          onPressed: () {
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                context: context,
                builder: (context) {
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    height: Get.height / 2,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                height: 5,
                                width: 35,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, top: 20, bottom: 15),
                                    child: HrAppText(
                                      text: '$title',
                                      style: HeadingTextStyles.heading3,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding:
                              const EdgeInsets.only(top: 10, left: 8, right: 8),
                          height: Get.height / 3,
                          alignment: Alignment.center,
                          child: ListView.separated(
                              itemCount: items.length,
                              separatorBuilder: (context, int) {
                                return Divider(
                                  color: Colors.grey.shade200,
                                );
                              },
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, bottom: 5, top: 5),
                                      child: HrAppText(
                                        text: items[index].toString() == "null"
                                            ? "* Name"
                                            : items[index],
                                        style: HeadingTextStyles.heading3,
                                      ),
                                    ),
                                    onTap: () {
                                      selectedValue = items[index];
                                      onChanged(selectedValue);
                                      Navigator.of(context).pop();
                                    });
                              }),
                        ),
                      ],
                    ),
                  );
                });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: heading != '' ? 2.5 : 0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: heading == ''
                        ? HrAppText(
                            text: '$heading',
                            style: HeadingTextStyles.heading3,
                          )
                        : Text(
                            '$selectedValue',
                            overflow: TextOverflow.ellipsis,
                            style: HeadingTextStyles.heading6.copyWith(
                              color: AppColors.listContainerTextColor,
                            ),
                          ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: isDark == true ? Colors.white : Colors.black,
                  )
                ],
              ),
              SizedBox(
                height: heading != '' ? 1 : 0,
              ),
            ],
          )),
    );
  }
}
