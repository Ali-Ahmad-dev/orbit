import 'package:get/get.dart';
import 'package:orbit/constants/network/network_endpoints.dart';
import 'package:orbit/models/attendance_model.dart';
import 'package:orbit/models/leave_history_model.dart';
import 'package:orbit/models/login_model.dart';
import 'package:orbit/models/team_member_model.dart';
import 'package:intl/intl.dart';
import '../repositories/member_attendance_report_repository.dart';

class MemberAttendanceReportController extends GetxController {
  final preferencesController = Get.find<LoginModel>();
  final MemberAttendanceReportRepository _repository;
  MemberAttendanceReportController(this._repository);
  var attendanceList = <AttendanceList>[].obs;
  AttendanceReport attendanceReport = AttendanceReport();
  var isDialogShowing = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool apiCalling = false.obs;
  final Rx<DateTime> _displayedDate =
      DateTime(DateTime.now().year, DateTime.now().month, 1).obs;
  DateTime get displayedDate => _displayedDate.value;
  String get formattedDate => DateFormat('yyyy-MM-dd').format(displayedDate);
  LeaveHistory leaveHistory = LeaveHistory();

  TeamMemberList? member;

  @override
  void onInit() {
    member = Get.arguments;
    getMemberAttendanceList();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void previousMonth() {
    _displayedDate.value =
        DateTime(_displayedDate.value.year, _displayedDate.value.month - 1);
    getMemberAttendanceList();
  }

  void nextMonth() {
    final currentMonth =
        DateTime(_displayedDate.value.year, _displayedDate.value.month + 1);
    if (currentMonth.isAfter(DateTime.now())) {
      return;
    }
    _displayedDate.value = currentMonth;
    getMemberAttendanceList();
  }

  Future<void> getLeaveHistory() async {
    try {
      errorMessage.value = '';
      apiCalling.value = true;

      final result = await _repository.getMemberLeaveHistory(
          '${NetworkEndpoints.getLeaveHistory}?EmployeeId=${member!.employeeId}');

      final status = result['statusCode'];
      print(result);

      if (status == 200) {
        leaveHistory = LeaveHistory.fromJson(result);

        if (leaveHistory.isError == true) {
          errorMessage.value = 'An error has occurred';
        }
      } else {
        errorMessage.value = result['message'] ?? 'Unknown error occurred';
      }
    } catch (e) {
      errorMessage.value = 'Failed to fetch leave history: $e';
      print(e);
    } finally {
      apiCalling.value = false;
    }
  }

  Future<void> getMemberAttendanceList() async {
    try {
      errorMessage.value = '';
      apiCalling.value = true;
      var id = member!.employeeId;
      print('getMemberAttendanceList => $id');
      var data = {
        "Date": formattedDate,
        "EmployeeId": id,
      };

      var result = await _repository.getMemberAttendanceList(
          NetworkEndpoints.getAttendanceList, data);
      final status = result['statusCode'];
      print('ddddddddddddddddddddddddd');
      print(result);
      AttendanceReport attendanceReport = AttendanceReport.fromJson(result);

      if (attendanceReport.isError == false && status == 200) {
        attendanceList.value = attendanceReport.data!;
      } else {
        print('ddddddddddddddddddddddddd');
        errorMessage.value = 'Invalid Input';
      }
    } catch (e) {
      print(e);
      errorMessage.value = e.toString();
    } finally {
      apiCalling.value = false;
    }
  }
}
