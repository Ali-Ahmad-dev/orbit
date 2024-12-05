import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/config/config_keys_body.dart';
import 'package:orbit/constants/config/config_keys_title.dart';
import 'package:orbit/constants/fonts/true_book_font_family.dart';
import 'package:orbit/constants/locale/orbit_client_app.dart';
import 'package:orbit/utils/text_styles/HeadingTextStyles.dart';
import 'package:orbit/widgets/data_grid_source.dart';
import 'package:orbit/widgets/hr_app_text.dart';
import 'package:orbit/widgets/special_container.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class TimeSheetWidget extends StatelessWidget {
  final List<dynamic>? employees;
  const TimeSheetWidget({this.employees, super.key});
  @override
  Widget build(BuildContext context) {
    var employeeDataSource = EmployeeDataSource(employeeData: employees!);
    final mLocaleData = OrbitClientApp.mLocale[ConfigKeysTitle.dashboardScreen];
    double width = Get.width;
    double height = Get.height;
    double rowHeight = height * 0.053;
    return employees!.isEmpty
        ? const SpecialContainer()
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurStyle: BlurStyle.outer,
                      spreadRadius: 2.0,
                      blurRadius: 15,
                      offset: const Offset(2, 6),
                    )
                  ]),
              child: SfDataGridTheme(
                data: const SfDataGridThemeData(
                  gridLineColor: Colors.transparent,
                  gridLineStrokeWidth: 0.0,
                ),
                child: SfDataGrid(
                  verticalScrollPhysics: const NeverScrollableScrollPhysics(),
                  horizontalScrollPhysics: const NeverScrollableScrollPhysics(),
                  shrinkWrapRows: true,
                  source: employeeDataSource,
                  columnWidthMode: ColumnWidthMode.auto,
                  columns: <GridColumn>[
                    GridColumn(
                      columnName: 'Date',
                      label: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 7),
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor.value,
                              borderRadius: BorderRadius.circular(15)),
                          alignment: Alignment.center,
                          child: HrAppText(
                            text: mLocaleData![ConfigKeysBody.dashboardBody9]!,
                            style: HeadingTextStyles.heading4.copyWith(
                                color: AppColors.backgroundColor,
                                fontSize: 12,
                                fontFamily: TrueBookFontFamily.gUbuntuBold),
                          ),
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'Check In',
                      label: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 7),
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor.value,
                              borderRadius: BorderRadius.circular(15)),
                          alignment: Alignment.center,
                          child: HrAppText(
                            text: mLocaleData[ConfigKeysBody.dashboardBody10]!,
                            style: HeadingTextStyles.heading4.copyWith(
                                color: AppColors.backgroundColor,
                                fontSize: 12,
                                fontFamily: TrueBookFontFamily.gUbuntuBold),
                          ),
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'Check Out',
                      label: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 7),
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor.value,
                              borderRadius: BorderRadius.circular(15)),
                          alignment: Alignment.center,
                          child: HrAppText(
                            text: mLocaleData[ConfigKeysBody.dashboardBody11]!,
                            style: HeadingTextStyles.heading4.copyWith(
                                color: AppColors.backgroundColor,
                                fontSize: 12,
                                fontFamily: TrueBookFontFamily.gUbuntuBold),
                          ),
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'W/H',
                      label: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 7),
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor.value,
                              borderRadius: BorderRadius.circular(15)),
                          alignment: Alignment.center,
                          child: HrAppText(
                            text: mLocaleData[ConfigKeysBody.dashboardBody12]!,
                            style: HeadingTextStyles.heading4.copyWith(
                                color: AppColors.backgroundColor,
                                fontSize: 12,
                                fontFamily: TrueBookFontFamily.gUbuntuBold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
