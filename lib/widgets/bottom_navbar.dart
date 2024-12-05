import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/controllers/bottom_nav_controllers.dart';
import 'package:orbit/screens/attendance_report.dart';
import 'package:orbit/screens/dashboard_screen.dart';
import 'package:orbit/screens/performance_screen.dart';
import '../screens/apply_leave_screen.dart';
import '../screens/leave_history_screen.dart';

class HrAppBottomNav extends GetView<BottomNavController> {
  const HrAppBottomNav({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() =>
          IndexedStack(index: controller.selectedIndex.value, children: const [
            DashboardScreen(),
            AttendanceReportScreen(),
            LeaveHistoryScreen(),
            ApplyLeaveScreen(),
            PerformanceScreen()
          ])),
      bottomNavigationBar: Theme(
        data: ThemeData(
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedIconTheme: IconThemeData(
              color: AppColors.primaryColor.value,
              size: 35,
            ),
            selectedItemColor: AppColors.primaryColor.value,
            unselectedItemColor: AppColors.primarygreyColor,
            backgroundColor: AppColors.backgroundColor,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: false,
          ),
        ),
        child: Obx(() => Stack(
              children: [
                BottomNavigationBar(
                  currentIndex: controller.selectedIndex.value,
                  onTap: controller.changeIndex,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.border_all),
                      label: " ",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.description),
                      label: " ",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.schedule),
                      label: " ",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.edit_document),
                      label: " ",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.speed_outlined),
                      label: " ",
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
