import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/constants/models/current_month_attendance_model.dart';
import 'package:orbit/constants/models/get_approved_status_model.dart';
import 'package:orbit/constants/network/network_endpoints.dart';
import 'package:orbit/helper/main_helper.dart';
import 'package:orbit/models/attendance_model.dart';
import 'package:orbit/models/login_model.dart';
import 'package:orbit/models/pending_request_model.dart';
import 'package:orbit/repositories/leave_requests_repo.dart';
import 'package:orbit/utils/hr_app_snack_bar.dart';
import 'package:orbit/utils/hr_datetime_util.dart';
import 'package:orbit/utils/hr_path_provider.dart';
import 'package:orbit/utils/hr_toast.dart';
import '../constants/routes/routes_endpoints.dart';
import 'package:intl/intl.dart';

class LeaveRequestsTestController extends GetxController {
  final preferencesController = Get.find<LoginModel>();
  final LeaveRequestsRepository _repository;
  final loginController = Get.find<LoginModel>();
  LeaveRequestsTestController(this._repository);
  final mainHelper = Get.find<MainHelper>();
  RxList<ApprovalStatus> approvedLeaveList = RxList<ApprovalStatus>([]);
  RxList<String> statusNames = <String>[].obs;
  RxString selectedStatus = '* Select Status'.obs;
  int selectStatusId = 0;
  // int id = 0;
  final TextEditingController commentsController = TextEditingController();
  PendingRequestModel? pendingRequestModel;
  Rx<CurrentMonthAttendanceModel> currentMonthAttendanceModel =
      CurrentMonthAttendanceModel.fromJson({}).obs;
  var progress = 0.0.obs;
  RxList<CurrentMonthAttendence> currentMonthAttendanceList =
      <CurrentMonthAttendence>[].obs;
  RxList<LeavesData> unApprovedLeavesList = <LeavesData>[].obs;
  List<DateTime> dateTimeList = [];
  String imageUrl = 'https://images4.alphacoders.com/122/1228259.png';
  var attendanceList = <AttendanceList>[].obs;
  AttendanceReport attendanceReport = AttendanceReport();
  var isDialogShowing = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool apiCalling = false.obs;
  final TextEditingController comments = TextEditingController();
  var expandedIndex = (-1).obs;
  final Rx<DateTime> _displayedDate =
      DateTime(DateTime.now().year, DateTime.now().month, 1).obs;
  DateTime get displayedDate => _displayedDate.value;
  String get formattedDate => DateFormat('yyyy-MM-dd').format(displayedDate);
  var renderingData = <dynamic>[].obs;
  var isCheckboxChecked = false.obs;
  RxInt selectedApproveListIndex = 0.obs;
  List<String> applyFromFormattedDate = [];
  List<String> applyToFormattedDate = [];
  List<String> createD_DATE_TIME = [];
  List<String> leaveType = [];
  Map<int, String> leaveTypeApplicationTitle = {};
  Map<int, String> leaveTypeHalfDayApplicationBody = {};
  Map<int, String> leaveTypeHalfDayApplicationTitle = {};
  List<List<bool>> mainCheckboxList = [];
  List<List<String>> mainleaveDatesTitleList = [];
  List<List<String>> approvedByTL = [];
  List<List<String>> rejectedByTL = [];
  List<List<String>> approvedByHR = [];
  List<List<String>> rejectedByHR = [];
  void toggleExpanded(int index) {
    if (expandedIndex.value == index) {
      expandedIndex.value = -1;
    } else {
      expandedIndex.value = index;
    }
  }

  Future<void> downloadImage(LeavesData unApprovedLeaves) async {
    final url = unApprovedLeaves.attachment;
    final name = url!.split("/").last;
    progress.value = 0.0001;
    print('====1');
    final result = await HrPathProvider.downloadFile(
      url: url,
      fileName: name,
      progressCallback: (current, total) {
        progress.value = (current / total);
        print('Downloading: ${progress.value}');
      },
      onDone: () async {
        progress.value = 0.0;
        print('onDone');
        HrToast.showToast(
            msg: 'File Downloaded successfully.', backgroundColor: Colors.red);
      },
    );
    if (result == 200) {
      progress.value = 0.0;
    }
  }

  // Method to toggle the checkbox state
  void toggleCheckbox() {
    isCheckboxChecked.value = !isCheckboxChecked.value;
  }

  renderDatafromList() {
    for (int i = 0;
        i < currentMonthAttendanceModel.value.leavesData!.length;
        i++) {
      print('Printing on index $i');
      renderDataUpdated(i);
    }
  }

  renderDataUpdated(int index) {
    final unApprovedLEavesDtos =
        currentMonthAttendanceModel.value.leavesData![index];
    final createdFormattedDate = unApprovedLEavesDtos.createDDATETIME!
        .substring(0, min(unApprovedLEavesDtos.createDDATETIME!.length, 10));
    applyFromFormattedDate.add(unApprovedLEavesDtos.applYFROMDATE!
        .substring(0, min(unApprovedLEavesDtos.applYFROMDATE!.length, 10)));
    applyToFormattedDate.add(unApprovedLEavesDtos.applYTODATE!
        .substring(0, min(unApprovedLEavesDtos.applYFROMDATE!.length, 10)));
    createD_DATE_TIME.add('Applied On ${createdFormattedDate}');
    approvedByTL.insert(index, unApprovedLEavesDtos.isApprovedByTL!);
    rejectedByTL.insert(index, unApprovedLEavesDtos.isRejectedByTL!);
    approvedByHR.insert(index, unApprovedLEavesDtos.isApprovedByHR!);
    rejectedByHR.insert(index, unApprovedLEavesDtos.isRejectedByHR!);
    final showDatesToTL = unApprovedLEavesDtos.isApprovedByTL!.isEmpty &&
        unApprovedLEavesDtos.isRejectedByTL!.isEmpty;
    leaveType.add(unApprovedLEavesDtos.leaveType!);
    // leaveTypeApplicationTitle.add('');
    // leaveTypeHalfDayApplicationBody.add('');
    List<String> leaveDatesTitleList = [];
    mainleaveDatesTitleList.add(leaveDatesTitleList);
    print('called again');
    var checkboxValues = <bool>[].obs;
    mainCheckboxList.add(checkboxValues);
    if (showDatesToTL) {
      if (applyToFormattedDate[index] == applyFromFormattedDate[index]) {
        checkboxValues.add(false);
        if (leaveType[index] == 'Half Day') {
          // leaveTypeApplicationTitle.add('Leave Application for Half Day');
          leaveTypeApplicationTitle[index] = 'Leave Application for Half Day';
          leaveTypeHalfDayApplicationTitle[index] = 'Half Day';
          leaveTypeHalfDayApplicationBody[index] =
              unApprovedLEavesDtos.firstHalf! ? 'First Half' : 'Second Half';
          leaveDatesTitleList.add(applyToFormattedDate[index]);
        } else {
          leaveTypeApplicationTitle[index] = 'Leave Application for 1 Day';
          leaveDatesTitleList.add(applyToFormattedDate[index]);
        }
      } else {
        // print('date printed');
        DateTime startDate = DateTime.parse(applyFromFormattedDate[index]);
        DateTime endDate = DateTime.parse(applyToFormattedDate[index]);
        List<DateTime> dateRange = getDateRange(startDate, endDate);
        for (int i = 0; i < dateRange.length; i++) {
          checkboxValues.add(false);
        }
        print('debugging => $checkboxValues');
        if (leaveType[index] == 'Half Day') {
          // print('debugging12 => $leaveTypeHalfDayApplicationTitle');
          leaveTypeHalfDayApplicationTitle[index] = 'Half Day';
          leaveTypeHalfDayApplicationBody[index] =
              unApprovedLEavesDtos.firstHalf! ? 'First Half' : 'Second Half';
        }
        leaveTypeApplicationTitle[index] =
            'Leave Application for ${dateRange.length} Days';
        print('debugging12 => $unApprovedLEavesDtos');
        final mappedDateRange = dateRange
            .map((date) => date.toString().substring(
                0, min(unApprovedLEavesDtos.applYTODATE!.length, 10)))
            .toList();
        leaveDatesTitleList.addAll(mappedDateRange);
      }
    } else if (unApprovedLEavesDtos.isApprovedByTL!.isNotEmpty) {
      for (int j = 0; j < unApprovedLEavesDtos.isApprovedByTL!.length; j++) {
        checkboxValues.add(false);
        if (leaveType[index] == 'Half Day') {
          // leaveTypeApplicationTitle.add('Leave Application for Half Day');
          leaveTypeApplicationTitle[index] = 'Leave Application for Half Day';
          leaveTypeHalfDayApplicationTitle[index] = 'Half Day';
          leaveTypeHalfDayApplicationBody[index] =
              unApprovedLEavesDtos.firstHalf! ? 'First Half' : 'Second Half';
          leaveDatesTitleList.add(HrDatetimeUtil.toYearMonthDay(
              unApprovedLEavesDtos.isApprovedByTL![j]));
        }
        leaveDatesTitleList.add(HrDatetimeUtil.toYearMonthDay(
            unApprovedLEavesDtos.isApprovedByTL![j]));
      }
      leaveTypeApplicationTitle[index] =
          'Leave Application for ${unApprovedLEavesDtos.isApprovedByTL!.length} Day';
    }
    print('renderingDataController $index => $leaveDatesTitleList');
    // mainleaveDatesTitleList.add(leaveDatesTitleList);
  }

  renderData(UnApprovedLEavesDtos unApprovedLEavesDtos) {
    final applyFromFormattedDate = unApprovedLEavesDtos.applYFROMDATE!
        .substring(0, min(unApprovedLEavesDtos.applYFROMDATE!.length, 10));
    final applyToFormattedDate = unApprovedLEavesDtos.applYTODATE!
        .substring(0, min(unApprovedLEavesDtos.applYTODATE!.length, 10));
    String leaveType = unApprovedLEavesDtos.leaveType!;
    String leaveTypeApplicationTitle = '';
    String leaveTypeHalfDayApplicationTitle = '';
    String leaveTypeHalfDayApplicationBody = '';
    List<String> leaveDatesTitleList = [];
    var checkboxValues = <bool>[].obs;
    if (applyToFormattedDate == applyFromFormattedDate) {
      checkboxValues.add(false);
      if (leaveType == 'Half Day') {
        leaveTypeApplicationTitle = 'Leave Application for Half Day';
        leaveTypeHalfDayApplicationTitle = 'Half Day';
        leaveTypeHalfDayApplicationBody =
            unApprovedLEavesDtos.firstHalf! ? 'First Half' : 'Second Half';
        leaveDatesTitleList.add(applyToFormattedDate);
      } else {
        leaveTypeApplicationTitle = 'Leave Application for 1 Day';
        leaveDatesTitleList.add(applyToFormattedDate);
      }
    } else {
      DateTime startDate = DateTime.parse(applyFromFormattedDate);
      DateTime endDate = DateTime.parse(applyToFormattedDate);
      List<DateTime> dateRange = getDateRange(startDate, endDate);
      for (int i = 0; i < dateRange.length; i++) {
        checkboxValues.add(false);
      }
      if (leaveType == 'Half Day') {
        leaveTypeHalfDayApplicationTitle = 'Half Day';
        leaveTypeHalfDayApplicationBody =
            unApprovedLEavesDtos.firstHalf! ? 'First Half' : 'Second Half';
      }
      leaveTypeApplicationTitle =
          'Leave Application for ${dateRange.length} Days';
      leaveDatesTitleList.addAll(dateRange
          .map((date) => date
              .toString()
              .substring(0, min(unApprovedLEavesDtos.applYTODATE!.length, 10)))
          .toList());
    }
  }

  List<DateTime> getDateRange(DateTime start, DateTime end) {
    List<DateTime> dateList = [];
    for (int i = 0; i <= end.difference(start).inDays; i++) {
      dateList.add(start.add(Duration(days: i)));
    }
    return dateList;
  }

  @override
  void onInit() {
    pendingRequestModel = Get.arguments;
    fetchStatusNames();
    fetchApprovalStatuses();
    initValues();
    super.onInit();
  }

  Future<void> initValues() async {
    await getCurrentMonthAttendance(); // Ensure this method is available and correctly works
  }

  Future<void> getCurrentMonthAttendance() async {
    try {
      errorMessage.value = '';
      apiCalling.value = true;
      print('-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-');
      print(
          '${NetworkEndpoints.GetCurrentMonthAttendenceOfTeamMembers}?EmployeeId=${pendingRequestModel!.employeeId}');
      CurrentMonthAttendanceModel result =
          await _repository.getCurrentMonthAttendance(
              '${NetworkEndpoints.GetCurrentMonthAttendenceOfTeamMembers}?EmployeeId=${pendingRequestModel!.employeeId}');
      print(result);
      if (result.isError == false) {
        currentMonthAttendanceModel.value = result;
        currentMonthAttendanceList.value = result.currentMonthAttendence!;
        unApprovedLeavesList.value = result.leavesData!;
        renderDatafromList();
        apiCalling.value = false;
      } else {
        errorMessage.value = 'Invalid Input';
      }
    } catch (e) {
      print(e);
      errorMessage.value = e.toString();
    } finally {
      apiCalling.value = false;
    }
  }

  @override
  void dispose() {
    comments.dispose();
    super.dispose();
  }

  Future<void> fetchStatusNames() async {
    try {
      await Future.delayed(Duration(seconds: 2));
      final response = [{}];
      statusNames.value =
          response.map((e) => e['statusName'] as String).toList();
    } catch (e) {
      print('Error fetching status names: $e');
    }
  }

  void handleAction(String action, String leaveType) {
    print("$action Leave: $leaveType");
    print("Selected Status: ${selectedStatus.value}");
    print("Comments: ${commentsController.text}");
    Future<void> getAttendanceList() async {
      try {
        errorMessage.value = '';
        apiCalling.value = true;
        var data = {
          "Date": formattedDate,
          "EmployeeId": pendingRequestModel!.employeeId,
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
          errorMessage.value = 'Invalid Input';
        }
      } catch (e) {
        print(e);
        errorMessage.value = e.toString();
      } finally {
        apiCalling.value = false;
      }
    }

    goToApplyLoanScreen() {
      Get.toNamed(RouteEndpoints.applyLoanScreen);
    }

    Future<void> getCurrentMonthAttendance() async {
      try {
        errorMessage.value = '';
        apiCalling.value = true;
        CurrentMonthAttendanceModel result =
            await _repository.getCurrentMonthAttendance(
                '${NetworkEndpoints.GetCurrentMonthAttendenceOfTeamMembers}?EmployeeId=${pendingRequestModel!.employeeId}');
        print(result);
        if (result.isError == false) {
          currentMonthAttendanceModel.value = result;
          currentMonthAttendanceList.value = result.currentMonthAttendence!;
          unApprovedLeavesList.value = result.leavesData!;
          print(unApprovedLeavesList.length);
          renderDatafromList();
          await getAttendanceList();
          apiCalling.value = false;
          // renderingData.value = renderDatafromList();
          // attendanceList.value = attendanceReport.data!;
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

  approveLeaves(LeavesData unApprovedLEavesDtos) async {
    try {
      print(dateTimeList);
      errorMessage.value = '';
      if (dateTimeList.isEmpty) {
        HrToast.showToast(
            msg: 'Please select at least 1 date to approve',
            backgroundColor: Colors.red);
        return;
      }
      apiCalling.value = true;
      var data = {
        "LeaveRequestId": unApprovedLEavesDtos.id,
        "ApproveDate":
            dateTimeList.map((value) => value.toIso8601String()).toList(),
        "Comments": comments.text.trim(),
        "isApproved": true,
        "EmployeeId": pendingRequestModel!.employeeId,
        "LeaveTypeId": unApprovedLEavesDtos.leaveTypeId,
        "ApprovalStatusId": selectStatusId, // Use dynamic value
      };
      print('approveLeaves => $data');
      var result;
      if (selectStatusId == 1) {
        result = await _repository.approveLeaves(
            NetworkEndpoints.approveLeaves, data);
      } else if (selectStatusId == 2) {
        result = await _repository.rejectLeaves(
            NetworkEndpoints.approveLeaves, data);
      }

      if (result['isError'] == false) {
        dateTimeList.clear();
        await getCurrentMonthAttendance();
        HrAppSnackBar.showSnackBar(
            title: "Success", duration: 2, message: result['message']);
      } else {
        errorMessage.value = 'Invalid Input';
      }
    } catch (e) {
      print(e);
      errorMessage.value = e.toString();
    } finally {
      apiCalling.value = false;
    }
  }

  GetApprovedStatus approvedStatus = GetApprovedStatus();
  Future<void> fetchApprovalStatuses() async {
    try {
      final response =
          await _repository.getApprovalStatus(NetworkEndpoints.approvalStatus);
      approvedStatus = GetApprovedStatus.fromJson(response);
      print('Approved Satus: $approvedStatus');
      approvedLeaveList.value = approvedStatus.approvalStatus!;
    } catch (e) {
      print('Error parsing approval statuses: $e');
    }
  }
}
