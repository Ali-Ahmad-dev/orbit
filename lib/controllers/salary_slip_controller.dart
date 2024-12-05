import 'package:get/get.dart';
import 'package:orbit/constants/jsons/salary_slip_data.dart';
import 'package:orbit/helper/main_helper.dart';
import 'package:orbit/models/attendance_model.dart';
import 'package:orbit/models/login_model.dart';
import 'package:orbit/models/salary_slip_model.dart';
import 'package:orbit/repositories/salary_slip_repository.dart';
import 'package:intl/intl.dart';

class SalarySlipController extends GetxController {
  final SalarySlipRepository _repository;

  SalarySlipController(this._repository);

  final loginController = Get.find<LoginModel>();
  final mainHelper = Get.find<MainHelper>();

  var salarySlipList = <Datum>[].obs;
  SalarySlip salarySlip = SalarySlip();

  final RxString errorMessage = ''.obs;
  final RxBool apiCalling = false.obs;

  final Rx<DateTime> _displayedDate =
      DateTime(DateTime.now().year, DateTime.now().month, 1).obs;

  DateTime get displayedDate => _displayedDate.value;

  String get formattedDate => DateFormat('yyyy-MM-dd').format(displayedDate);

  @override
  void onInit() {
    salarySlip = SalarySlip.fromJson(salary_Slip_data);
    salarySlipList.value = salarySlip.data!;
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
    _displayedDate.value =
        DateTime(_displayedDate.value.year, _displayedDate.value.month + 1);
    getAttendanceList();
  }

  Future<void> getAttendanceList() async {}
}
