// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:orbit/constants/network/network_endpoints.dart';
// import 'package:orbit/helper/main_helper.dart';
// import 'package:orbit/models/attendance_model.dart';
// import 'package:orbit/models/current_month_attendance_model.dart';
// import 'package:orbit/models/login_model.dart';
// import 'package:orbit/models/pending_request_model.dart';
// import 'package:orbit/repositories/leave_requests_repo.dart';
// import 'package:orbit/utils/hr_app_snack_bar.dart';
// import 'package:orbit/utils/hr_toast.dart';
// import '../constants/routes/routes_endpoints.dart';
// import 'package:intl/intl.dart';

// class LeaveRequestsController extends GetxController {
//   final preferencesController = Get.find<LoginModel>();
//   final LeaveRequestsRepository _repository;
//   final loginController = Get.find<LoginModel>();
//   LeaveRequestsController(this._repository);

//   final mainHelper = Get.find<MainHelper>();

//   PendingRequestModel? pendingRequestModel;
//   Rx<CurrentMonthAttendanceModel> currentMonthAttendanceModel =
//       CurrentMonthAttendanceModel.fromJson({}).obs;

//   RxList<CurrentMonthAttendence> currentMonthAttendanceList =
//       <CurrentMonthAttendence>[].obs;
//   RxList<UnApprovedLEavesDtos> unApprovedLeavesList =
//       <UnApprovedLEavesDtos>[].obs;

//   List<DateTime> dateTimeList = [];

//   var attendanceList = <AttendanceList>[].obs;
//   AttendanceReport attendanceReport = AttendanceReport();
//   var isDialogShowing = false.obs;
//   final RxString errorMessage = ''.obs;
//   final RxBool apiCalling = true.obs;
//   final TextEditingController comments = TextEditingController();
//   var expandedIndex = (-1).obs;
//   final Rx<DateTime> _displayedDate =
//       DateTime(DateTime.now().year, DateTime.now().month, 1).obs;
//   DateTime get displayedDate => _displayedDate.value;
//   String get formattedDate => DateFormat('yyyy-MM-dd').format(displayedDate);
//   var renderingData = <dynamic>[].obs;

//   List<String> applyFromFormattedDate = [];
//   List<String> applyToFormattedDate = [];
//   List<String> createD_DATE_TIME = [];

//   List<String> leaveType = [];

//   Map<int, String> leaveTypeApplicationTitle = {};

//   Map<int, String> leaveTypeHalfDayApplicationBody = {};

//   Map<int, String> leaveTypeHalfDayApplicationTitle = {};

//   List<List<bool>> mainCheckboxList = [];

//   List<List<String>> mainleaveDatesTitleList = [];

//   List<String> approvedByTL = [];
//   List<String> rejectedByTL = [];
//   List<String> approvedByHR = [];
//   List<String> rejectedByHR = [];

//   void toggleExpanded(int index) {
//     if (expandedIndex.value == index) {
//       expandedIndex.value = -1;
//     } else {
//       expandedIndex.value = index;
//     }
//   }

//   var isCheckboxChecked = false.obs;
//   RxInt selectedApproveListIndex = 0.obs;
//   void toggleCheckbox() {
//     isCheckboxChecked.value = !isCheckboxChecked.value;
//   }

//   renderDatafromList() {
//     for (int i = 0; i < unApprovedLeavesList.length; i++) {
//       print('Printing on index $i');
//       renderDataUpdated(i);
//     }
//   }

//   renderDataUpdated(int index) {
//     final unApprovedLEavesDtos = unApprovedLeavesList[index];
//     final createdFormattedDate = unApprovedLEavesDtos.createDDATETIME!
//         .substring(0, min(unApprovedLEavesDtos.createDDATETIME!.length, 10));

//     applyFromFormattedDate.add(unApprovedLEavesDtos.applYFROMDATE!
//         .substring(0, min(unApprovedLEavesDtos.applYFROMDATE!.length, 10)));

//     applyToFormattedDate.add(unApprovedLEavesDtos.applYTODATE!
//         .substring(0, min(unApprovedLEavesDtos.applYFROMDATE!.length, 10)));

//     createD_DATE_TIME.add('Applied On ${createdFormattedDate}');

//     leaveType.add(unApprovedLEavesDtos.leaveType!);
//     List<String> leaveDatesTitleList = [];
//     mainleaveDatesTitleList.add(leaveDatesTitleList);
//     print('called again');
//     var checkboxValues = <bool>[].obs;
//     mainCheckboxList.add(checkboxValues);
//     if (applyToFormattedDate[index] == applyFromFormattedDate[index]) {
//       checkboxValues.add(false);
//       if (leaveType[index] == 'Half Day') {
//         leaveTypeApplicationTitle[index] = 'Leave Application for Half Day';
//         leaveTypeHalfDayApplicationTitle[index] = 'Half Day';
//         leaveTypeHalfDayApplicationBody[index] =
//             unApprovedLEavesDtos.firstHalf! ? 'First Half' : 'Second Half';

//         leaveDatesTitleList.add(applyToFormattedDate[index]);
//       } else {
//         leaveTypeApplicationTitle[index] = 'Leave Application for 1 Day';
//         leaveDatesTitleList.add(applyToFormattedDate[index]);
//       }
//     } else {
//       DateTime startDate = DateTime.parse(applyFromFormattedDate[index]);
//       DateTime endDate = DateTime.parse(applyToFormattedDate[index]);

//       List<DateTime> dateRange = getDateRange(startDate, endDate);
//       for (int i = 0; i < dateRange.length; i++) {
//         checkboxValues.add(false);
//       }
//       print('debugging => $checkboxValues');
//       if (leaveType[index] == 'Half Day') {
//         leaveTypeHalfDayApplicationTitle[index] = 'Half Day';
//         leaveTypeHalfDayApplicationBody[index] =
//             unApprovedLEavesDtos.firstHalf! ? 'First Half' : 'Second Half';
//       }
//       leaveTypeApplicationTitle[index] =
//           'Leave Application for ${dateRange.length} Days';
//       print('debugging12 => $unApprovedLEavesDtos');
//       final mappedDateRange = dateRange
//           .map((date) => date
//           .toString()
//           .substring(0, min(unApprovedLEavesDtos.applYTODATE!.length, 10)))
//           .toList();
//       leaveDatesTitleList.addAll(mappedDateRange);
//     }
//     print('renderingDataController $index => $leaveDatesTitleList');
//     // mainleaveDatesTitleList.add(leaveDatesTitleList);
//   }

//   renderData(UnApprovedLEavesDtos unApprovedLEavesDtos) {
//     final applyFromFormattedDate = unApprovedLEavesDtos.applYFROMDATE!
//         .substring(0, min(unApprovedLEavesDtos.applYFROMDATE!.length, 10));
//     final applyToFormattedDate = unApprovedLEavesDtos.applYTODATE!
//         .substring(0, min(unApprovedLEavesDtos.applYTODATE!.length, 10));

//     String leaveType = unApprovedLEavesDtos.leaveType!;
//     String leaveTypeApplicationTitle = '';
//     String leaveTypeHalfDayApplicationTitle = '';
//     String leaveTypeHalfDayApplicationBody = '';
//     List<String> leaveDatesTitleList = [];
//     var checkboxValues = <bool>[].obs;
//     if (applyToFormattedDate == applyFromFormattedDate) {
//       checkboxValues.add(false);

//       if (leaveType == 'Half Day') {
//         leaveTypeApplicationTitle = 'Leave Application for Half Day';
//         leaveTypeHalfDayApplicationTitle = 'Half Day';
//         leaveTypeHalfDayApplicationBody =
//             unApprovedLEavesDtos.firstHalf! ? 'First Half' : 'Second Half';
//         leaveDatesTitleList.add(applyToFormattedDate);
//       } else {
//         leaveTypeApplicationTitle = 'Leave Application for 1 Day';
//         leaveDatesTitleList.add(applyToFormattedDate);
//       }
//     } else {
//       DateTime startDate = DateTime.parse(applyFromFormattedDate);
//       DateTime endDate = DateTime.parse(applyToFormattedDate);

//       List<DateTime> dateRange = getDateRange(startDate, endDate);
//       for (int i = 0; i < dateRange.length; i++) {
//         checkboxValues.add(false);
//       }
//       if (leaveType == 'Half Day') {
//         leaveTypeHalfDayApplicationTitle = 'Half Day';
//         leaveTypeHalfDayApplicationBody =
//             unApprovedLEavesDtos.firstHalf! ? 'First Half' : 'Second Half';
//       }
//       leaveTypeApplicationTitle =
//           'Leave Application for ${dateRange.length} Days';
//       leaveDatesTitleList.addAll(dateRange
//           .map((date) => date
//               .toString()
//               .substring(0, min(unApprovedLEavesDtos.applYTODATE!.length, 10)))
//           .toList());
//     }
//   }

//   List<DateTime> getDateRange(DateTime start, DateTime end) {
//     List<DateTime> dateList = [];
//     for (int i = 0; i <= end.difference(start).inDays; i++) {
//       dateList.add(start.add(Duration(days: i)));
//     }
//     return dateList;
//   }

//   @override
//   void onInit() {
//     pendingRequestModel = Get.arguments;
//     initValues();
//     super.onInit();
//   }

//   @override
//   void dispose() {
//     comments.dispose();
//     super.dispose();
//   }

//   Future<void> getAttendanceList() async {
//     try {
//       errorMessage.value = '';
//       var data = {
//         "Date": formattedDate,
//         "EmployeeId": pendingRequestModel!.employeeId,
//       };

//       var result = await _repository.attendanceList(
//           NetworkEndpoints.getAttendanceList, data);
//       final status = result['statusCode'];
//       print('ddddddddddddddddddddddddd');
//       print(result);
//       AttendanceReport attendanceReport = AttendanceReport.fromJson(result);

//       if (attendanceReport.isError == false && status == 200) {
//         attendanceList.value = attendanceReport.data!;
//       } else {
//         // Save loginModel to use across the app
//         print('ddddddddddddddddddddddddd');
//         errorMessage.value = 'Invalid Input';
//       }
//     } catch (e) {
//       print(e);
//       errorMessage.value = e.toString();
//     } finally {
//       // apiCalling.value = false;
//     }
//   }

//   goToApplyLoanScreen() {
//     Get.toNamed(RouteEndpoints.applyLoanScreen);
//   }

//   Future<void> getCurrentMonthAttendance() async {
//     try {
//       errorMessage.value = '';

//       CurrentMonthAttendanceModel result =
//           await _repository.getCurrentMonthAttendance(
//               '${NetworkEndpoints.GetCurrentMonthAttendenceOfTeamMembers}?EmployeeId=${pendingRequestModel!.employeeId}');
//       print(result);

//       if (result.isError == false) {
//         currentMonthAttendanceModel.value = result;
//         currentMonthAttendanceList.value = result.currentMonthAttendence!;
//         unApprovedLeavesList.value =
//             result.unApprovedLeaves!.unApprovedLEavesDtos!;
//         // print(unApprovedLeavesList.length);
//         renderDatafromList();
//         await getAttendanceList();
//         apiCalling.value = false;
//         // renderingData.value = renderDatafromList();
//         // attendanceList.value = attendanceReport.data!;
//       } else {
//         // Save loginModel to use across the app
//         print('ddddddddddddddddddddddddd');
//         errorMessage.value = 'Invalid Input';
//       }
//     } catch (e) {
//       print(e);
//       errorMessage.value = e.toString();
//     } finally {
//     }
//   }

//   Future<void> initValues() async {
//     await getCurrentMonthAttendance();
//   }

//   Future<void> approveLeaves(UnApprovedLEavesDtos unApprovedLEavesDtos) async {
//     try {
//       print(dateTimeList);
//       errorMessage.value = '';
//       if(dateTimeList.isEmpty) {
//         HrToast.showToast(msg: 'Please select at least 1 date to approve', backgroundColor: Colors.red);
//         return;
//       }
//       apiCalling.value = true;

//       var data = {
//         "LeaveRequestId": unApprovedLEavesDtos.id,
//         "LeaveDate":
//             dateTimeList.map((value) => value.toIso8601String()).toList(),
//         "TeamLeadComments": comments.text.trim(),
//         "isApproved": true,
//         "EmployeeId": pendingRequestModel!.employeeId,
//         "LeaveTypeId": unApprovedLEavesDtos.leaveTypeId
//       };

//       print('approveLeaves => $data');
//       // return;

//       final result = await _repository.approveLeaves(
//           '${NetworkEndpoints.approveLeaves}', data);
//       print(result);

//       final isError = result['isError'];

//       if (isError == false) {
//         dateTimeList.clear();

//         await getCurrentMonthAttendance();
//         HrAppSnackBar.showSnackBar(
//             title: "Added Successfully",
//             duration: 2,
//             message: result['message']);
//       } else {
//         print('ddddddddddddddddddddddddd');
//         errorMessage.value = 'Invalid Input';
//       }
//     } catch (e) {
//       print(e);
//       errorMessage.value = e.toString();
//     } finally {
//       apiCalling.value = false;
//     }
//   }

//   Future<void> rejectLeaves(UnApprovedLEavesDtos unApprovedLEavesDtos) async {
//     try {
//       errorMessage.value = '';
//       print(dateTimeList);
//       errorMessage.value = '';
//       if(dateTimeList.isEmpty) {
//         HrToast.showToast(msg: 'Please select at least 1 date to reject', backgroundColor: Colors.red);
//         return;
//       }
//       apiCalling.value = true;

//       var data = {
//         "LeaveRequestId": unApprovedLEavesDtos.id,
//       };

//       print('rejectLeaves => $data');

//       final result = await _repository.rejectLeaves(
//           '${NetworkEndpoints.rejectLeaves}', data);
//       print(result);
//       final isError = result['isError'];
//       if (isError == false) {
//         dateTimeList.clear();
//         await getCurrentMonthAttendance();
//         HrAppSnackBar.showSnackBar(
//             title: "Added Successfully",
//             duration: 2,
//             message: result['message']);
//       } else {
//         print('ddddddddddddddddddddddddd');
//         errorMessage.value = 'Invalid Input';
//       }
//     } catch (e) {
//       print(e);
//       errorMessage.value = e.toString();
//     } finally {
//       apiCalling.value = false;
//     }
//   }
// }
