import 'package:get/get.dart';
import 'package:orbit/bindings/add_record_binding.dart';
import 'package:orbit/bindings/all_loan_binding.dart';
import 'package:orbit/bindings/announcement_binding.dart';
import 'package:orbit/bindings/apply_leave_binding.dart';
import 'package:orbit/bindings/apply_loan_binding.dart';
import 'package:orbit/bindings/attendance_report_binding.dart';
import 'package:orbit/bindings/bottom_nav_binding.dart';
import 'package:orbit/bindings/dashboard_binding.dart';
import 'package:orbit/bindings/employee_leave_history_binding.dart';
import 'package:orbit/bindings/evaluation_binding.dart';
import 'package:orbit/bindings/evaluation_history_binding.dart';
import 'package:orbit/bindings/hr_messages_binding.dart';
import 'package:orbit/bindings/hr_pending_requests_binding.dart';
import 'package:orbit/bindings/image_binding.dart';
import 'package:orbit/bindings/leave_history_binding.dart';
import 'package:orbit/bindings/leave_history_binding_test.dart';
import 'package:orbit/bindings/leave_request_binding.dart';
import 'package:orbit/bindings/leave_request_test_binding.dart';
import 'package:orbit/bindings/loan_binding.dart';
import 'package:orbit/bindings/login_bindings.dart';
import 'package:orbit/bindings/member_attendance_report_binding.dart';
import 'package:orbit/bindings/message_binding.dart';
import 'package:orbit/bindings/notification_binding.dart';
import 'package:orbit/bindings/performance_binding.dart';
import 'package:orbit/bindings/performance_team_report_binding.dart';
import 'package:orbit/bindings/salary_slip_binding.dart';
import 'package:orbit/bindings/team_report_binding.dart';
import 'package:orbit/screens/add_record_screen.dart';
import 'package:orbit/screens/all_loan_screen.dart';
import 'package:orbit/screens/announcement_screen.dart';
import 'package:orbit/screens/attendance_report.dart';
import 'package:orbit/screens/dashboard_screen.dart';
import 'package:orbit/screens/apply_leave_screen.dart';
import 'package:orbit/screens/employee_leave_history.dart';
import 'package:orbit/screens/evaluation_history.dart';
import 'package:orbit/screens/evaluation_screen.dart';
import 'package:orbit/screens/hr_messages_screen.dart';
import 'package:orbit/screens/hr_pending_requests_screen.dart';
import 'package:orbit/screens/image_screen.dart';
import 'package:orbit/screens/leave_history_screen.dart';
import 'package:orbit/screens/leave_requests_screen.dart';
import 'package:orbit/screens/loan_screen.dart';
import 'package:orbit/screens/login_screen.dart';
import 'package:orbit/screens/member_attendance_report.dart';
import 'package:orbit/screens/message_screen.dart';
import 'package:orbit/screens/notification_screen.dart';
import 'package:orbit/screens/performance_screen.dart';
import 'package:orbit/screens/performance_team_report_screen.dart';
import 'package:orbit/screens/salary_slip_screen.dart';
import 'package:orbit/screens/setting_screen.dart';
import 'package:orbit/screens/team_report_screen.dart';
import 'package:orbit/widgets/bottom_navbar.dart';
import '../bindings/setting_binding.dart';
import '../constants/routes/routes_endpoints.dart';
import '../screens/apply_loan_screen.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
            name: RouteEndpoints.loginScreen,
            page: () => const LoginScreen(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade,
            binding: LoginBinding()),
        GetPage(
          name: RouteEndpoints.dashboardScreen,
          page: () => const DashboardScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteEndpoints.attendanceReport,
          page: () => const AttendanceReportScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteEndpoints.applyLeave,
          page: () => const ApplyLeaveScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteEndpoints.leaveHistory,
          page: () => const LeaveHistoryScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteEndpoints.performanceScreen,
          page: () => const PerformanceScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
            name: RouteEndpoints.bottomNav,
            page: () => const HrAppBottomNav(),
            transitionDuration: const Duration(milliseconds: 250),
            transition: Transition.leftToRightWithFade,
            bindings: [
              BottomNavBinding(),
              DashboardBinding(),
              AttendanceReportBinding(),
              LeaveHistoryBindingTest(),
              ApplyLeaveBinding(),
              PerformanceBinding(),
            ]),
        GetPage(
          name: RouteEndpoints.notificationScreen,
          page: () => const NotificationScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
          binding: NotificationBinding(),
        ),
        GetPage(
          name: RouteEndpoints.salarySlipScreen,
          page: () => const SalarySlipScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
          binding: SalarySlipBinding(),
        ),
        GetPage(
          name: RouteEndpoints.loanScreen,
          page: () => const LoanScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
          binding: LoanBinding(),
        ),
        GetPage(
          name: RouteEndpoints.applyLoanScreen,
          page: () => const ApplyLoanScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
          binding: ApplyLoanBinding(),
        ),
        GetPage(
          name: RouteEndpoints.hrMessagesScreen,
          page: () => const HRMessagesScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
          binding: HrMessagesBinding(),
        ),
        GetPage(
          name: RouteEndpoints.hrPendingRequestsScreen,
          page: () => const HRPendingRequestScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
          binding: HrPendingRequestsBinding(),
        ),
        GetPage(
          name: RouteEndpoints.messageScreen,
          page: () => const MessageScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
          binding: MessageBinding(),
        ),
        GetPage(
          name: RouteEndpoints.settingScreen,
          page: () => const SettingScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
          binding: SettingBinding(),
        ),
        GetPage(
          name: RouteEndpoints.teamReportScreen,
          page: () => const TeamReportScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
          binding: TeamReportBinding(),
        ),
        GetPage(
          name: RouteEndpoints.employeeLeaveHistoryScreen,
          page: () => const EmployeeLeaveHistoryScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
          binding: EmployeeLeaveHistoryBinding(),
        ),
        GetPage(
          name: RouteEndpoints.evaluationScreen,
          page: () => const EvaluationScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
          binding: EvaluationBinding(),
        ),
        GetPage(
          name: RouteEndpoints.performanceTeamReportScreen,
          page: () => const PerformanceTeamReportScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
          binding: PerformanceTeamReportBinding(),
        ),
        GetPage(
          name: RouteEndpoints.addRecordScreen,
          page: () => const AddRecordScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
          binding: AddRecordBinding(),
        ),
        GetPage(
          name: RouteEndpoints.memberAttendanceReportScreen,
          page: () => const MemberAttendanceReport(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
          binding: MemberAttendanceReportBinding(),
        ),
        GetPage(
          name: RouteEndpoints.leaveRequestScreen,
          page: () => const LeaveRequestScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
          binding: LeaveRequestsTestBinding(),
          // binding: LeaveRequestsBinding(),
        ),
        GetPage(
          name: RouteEndpoints.imageScreen,
          page: () => const ImageScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
          binding: ImageBinding(),
        ),
        GetPage(
          name: RouteEndpoints.evaluationHistoryScreen,
          page: () => const EvaluationHistory(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
          binding: EvaluationHistoryBinding(),
        ),
        GetPage(
          name: RouteEndpoints.allLoanScreen,
          page: () => const AllLoanScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
          binding: AllLoanBinding(),
        ),
        GetPage(
          name: RouteEndpoints.announcementScreen,
          page: () => const AnnouncementScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
          binding: AnnouncementBinding(),
        ),
      ];
}
