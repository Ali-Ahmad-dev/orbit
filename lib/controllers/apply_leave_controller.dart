import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orbit/utils/hr_app_snack_bar.dart';
import 'package:orbit/utils/hr_toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:table_calendar/table_calendar.dart';
import '../constants/network/network_endpoints.dart';
import '../helper/main_helper.dart';
import '../models/leave_type.dart';
import '../models/login_model.dart';
import '../models/loan_response.dart';
import '../repositories/apply_leave_repository.dart';

class ApplyLeaveController extends GetxController {
  final ApplyLeaveRepository _repository;
  ApplyLeaveController(this._repository);

  RxInt selectedValue = 1.obs;
  RxInt selectedValueContainerOne = 2.obs;
  final preferencesController = Get.find<LoginModel>();
  final mainHelper = Get.find<MainHelper>();

  final TextEditingController selectTypeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Rx<TimeOfDay?> startTime = TimeOfDay.now().obs;
  Rx<TimeOfDay?> endTime = TimeOfDay.now().obs;
  final selectedLeaveData = '* Selected Type '.obs;
  int selectedLeaveId = 0;
  final selectedLeaveData1 = '* Selected Type '.obs;
  int selectedLeaveId1 = 0;

  final RxString errorMessage = ''.obs;
  final RxBool apiCalling = false.obs;
  RxList<LeaveType> leaveTypeList1 = RxList<LeaveType>([]);
  RxList<LeaveType> leaveTypeList2 = RxList<LeaveType>([]);

  var focusedDay = DateTime.now().obs;
  var selectedDay = Rx<DateTime?>(DateTime.now());
  // var startDate = Rx<DateTime?>(DateTime.now());
  // var endDate = Rx<DateTime?>(DateTime.now());
  DateTime? startDate;
  DateTime? endDate;
  File? selectedImages;
  var uploadImage = false.obs;
  RangeSelectionMode rangeSelectionMode = RangeSelectionMode.toggledOn;
  void checkAndSelectFirstHalf(int value) {
    final now = TimeOfDay.now();
    final cutOffTime = TimeOfDay(hour: 13, minute: 0);
    final today = DateTime.now();
    if (startDate == null) {
      HrToast.showToast(
          msg: 'Please select a start date', backgroundColor: Colors.red);
      return;
    }
    if (startDate!.isAfter(today)) {
      selectedValueContainerOne.value = value;
    } else if (now.hour > cutOffTime.hour ||
        (now.hour == cutOffTime.hour && now.minute > cutOffTime.minute)) {
      HrAppSnackBar.showSnackBar(
          title: 'Invalid Selection',
          message: 'First half cannot be selected after 1:00 PM.',
          backgroundColor: Colors.red);
    } else {
      selectedValueContainerOne.value = value;
    }
  }

  @override
  void onInit() {
    getLeaveTypes();
    super.onInit();
  }

  @override
  void dispose() {
    selectTypeController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  String formatTimeOfDay(TimeOfDay time) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  Future<void> pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      selectedImages = File(pickedImage.path);

      update();
      uploadImage.value = true;
    }
  }

  Future<void> getLeaveTypes() async {
    try {
      errorMessage.value = '';
      apiCalling.value = true;

      var id = preferencesController.employeeDetails?.employeeId;
      if (id == null) {
        errorMessage.value = 'Employee ID is null';
        return;
      }

      final result = await _repository
          .getLeaveTypes('${NetworkEndpoints.leaveReasons}?EmployeeId=$id');
      if (result['statusCode'] == 200) {
        List<LeaveType> leaveTypes = (result['reasons'] as List)
            .map((element) => LeaveType.fromJson(element))
            .toList();
        leaveTypeList1.value = leaveTypes;
        // selectedLeaveData.value = leaveTypes.first.leaveTypeName!;
        // selectedLeaveId = leaveTypes.first.leaveTypeId!;
        List<LeaveType> leaveTypes1 = (result['shortHalfKeyValPair'] as List)
            .map((element) => LeaveType.fromJson(element))
            .toList();
        leaveTypeList2.value = leaveTypes1;
        // selectedLeaveData1.value = leaveTypes1.last.leaveTypeName!;
        // selectedLeaveId1 = leaveTypes1.last.leaveTypeId!;
      } else {
        errorMessage.value = result['message'] ?? 'Unknown error occurred';
      }
    } catch (e) {
      errorMessage.value = 'Failed to fetch leave history: $e';
    } finally {
      apiCalling.value = false;
    }
  }

  Future<void> applyLeave() async {
    String? base64Image;
    if (selectedImages != null) {
      List<int> imageBytes = await selectedImages!.readAsBytes();
      base64Image = base64Encode(imageBytes);
      var extension = selectedImages!.path.split('.').last.toLowerCase();
      List<String> allowedExtensions = ['jpg', 'jpeg', 'png', 'pdf'];
      if (!allowedExtensions.contains(extension)) {
        HrToast.showToast(
            msg: 'use proper format i.e. png/jpeg/jpg/pdf',
            backgroundColor: Colors.red);
        return;
      }
    }

    try {
      errorMessage.value = '';
      apiCalling.value = true;

      var id = preferencesController.employeeDetails?.employeeId;
      if (id == null) {
        errorMessage.value = 'Employee ID is null';
        return;
      }
      if (startDate == null) {
        HrToast.showToast(
            msg: 'Please select apply leave date', backgroundColor: Colors.red);
        return;
      }
      if (endDate == null) {
        HrToast.showToast(
            msg: 'Please select end date', backgroundColor: Colors.red);
        return;
      }

      var applyFromDate = startDate.toString();
      var applyToDate = endDate.toString();
      var startingTime = formatTimeOfDay(startTime.value!);
      var endingTime = formatTimeOfDay(endTime.value!);

      print(selectedLeaveId);
      print(selectedLeaveData.value);
      print(selectedLeaveData1.value);

      var data = {
        "EmpId": id,
        "ApplyFromDate": applyFromDate,
        "EmployeeComments": descriptionController.text,
        "LeaveTypeId":
            selectedValue.value == 1 ? selectedLeaveId : selectedLeaveId1,
        "LeaveTypeChildId":
            selectedValue.value == 1 ? selectedLeaveId : selectedLeaveId1,
        "Attachment": "",
        "ApplyToDate": applyToDate,
        "LeaveDuration": selectedValue.value == 2
            ? startingTime == '09:00'
                ? 'first half'
                : 'second half'
            : '',
        "LeaveType": selectedValue.value == 1
            ? selectedLeaveData.value
            : selectedLeaveData1.value,
        "StartTime": startingTime,
        "EndTime": endingTime,
        "File": selectedImages != null
            ? {
                "FileName": selectedImages!.path.split('/').last,
                "FilePath": selectedImages!.path,
                "fileContent": base64Image,
                "FileIdentifier": "",
                "fileExtension": selectedImages!.path.split('.').last,
              }
            : null,
      };
      print(data);
      var result =
          await _repository.applyLeave(NetworkEndpoints.applyLeave, data);
      print(result);
      if (result['statusCode'] == 200) {
        LoanResponse loanResponse = LoanResponse.fromJson(result);
        if (loanResponse.isError == false) {
          selectTypeController.clear();
          descriptionController.clear();
          HrAppSnackBar.showSnackBar(
              title: "Applied Successfully",
              duration: 2,
              message: "Your leave application has been sent successfuly");
        }
      } else {
        HrAppSnackBar.showSnackBar(
            title: "Failed",
            duration: 3,
            backgroundColor: Colors.red,
            message: result['message']);
        errorMessage.value = result['message'] ?? 'Invalid Input';
      }
    } catch (e) {
      print(e);
      errorMessage.value = 'Failed to apply leave: $e';
    } finally {
      apiCalling.value = false;
    }
  }
}
