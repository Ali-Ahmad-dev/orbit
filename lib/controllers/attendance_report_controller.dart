import 'package:get/get.dart';
import 'package:orbit/constants/network/network_endpoints.dart';
import 'package:orbit/helper/main_helper.dart';
import 'package:orbit/models/attendance_model.dart';
import 'package:orbit/models/login_model.dart';
import 'package:orbit/repositories/attendance_report_repo.dart';
import 'package:intl/intl.dart';

class AttendanceReportController extends GetxController {
  final AttendanceReportRepository _repository;
  AttendanceReportController(this._repository);

  final loginController = Get.find<LoginModel>();
  final mainHelper = Get.find<MainHelper>();

  var attendanceList = <AttendanceList>[].obs;
  AttendanceReport attendanceReport = AttendanceReport();
  var isDialogShowing = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool apiCalling = false.obs;

  final Rx<DateTime> _displayedDate =
      DateTime(DateTime.now().year, DateTime.now().month, 1).obs;
  DateTime get displayedDate => _displayedDate.value;
  String get formattedDate => DateFormat('yyyy-MM-dd').format(displayedDate);
  @override
  void onInit() {
    getAttendanceList();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void previousMonth() {
    _displayedDate.value =
        DateTime(_displayedDate.value.year, _displayedDate.value.month - 1);
    getAttendanceList();
  }

  void nextMonth() {
    final currentMonth =
        DateTime(_displayedDate.value.year, _displayedDate.value.month + 1);
    if (currentMonth.isAfter(DateTime.now())) {
      return;
    }
    _displayedDate.value = currentMonth;
    getAttendanceList();
  }

  Future<void> getAttendanceList() async {
    try {
      errorMessage.value = '';
      apiCalling.value = true;
      var id = loginController.employeeDetails!.employeeId;
      var data = {
        "Date": formattedDate,
        "EmployeeId": id,
      };

      var result = await _repository.attendanceList(
          NetworkEndpoints.getAttendanceList, data);
      final status = result['statusCode'];
      print('ddddddddddddddddddddddddd');
      print(result);
      AttendanceReport attendanceReport = AttendanceReport.fromJson(result);

      if (attendanceReport.isError == false && status == 200) {
        attendanceList.value = attendanceReport.data!;
      } else {
        // Save loginModel to use across the app
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
