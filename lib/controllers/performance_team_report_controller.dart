import 'package:get/get.dart';
import 'package:orbit/constants/network/network_endpoints.dart';
import 'package:orbit/models/login_model.dart';
import 'package:orbit/models/performance_model.dart';
import 'package:orbit/models/team_member_model.dart';
import '../constants/routes/routes_endpoints.dart';
import '../repositories/performance_team_report_repository.dart';

class PerformanceTeamReportController extends GetxController {
  final preferencesController = Get.find<LoginModel>();
  final PerformanceTeamReportRepository _repository;
  PerformanceTeamReportController(this._repository);
  PerformanceModel performanceModel = PerformanceModel();
  final RxString errorMessage = ''.obs;
  final RxBool apiCalling = false.obs;

  RxBool isPasswordObsecure = true.obs;
  var isExpanded = false.obs;
  var expandedIndex = (-1).obs;

  TeamMemberList? member;

  void toggleExpanded(int index) {
    if (expandedIndex.value == index) {
      expandedIndex.value = -1;
    } else {
      expandedIndex.value = index;
    }
  }

  @override
  void onInit() {
    member = Get.arguments;
    getPerformance();
    super.onInit();
  }

  Future<void> getPerformance() async {
    try {
      errorMessage.value = '';
      apiCalling.value = true;

      final result = await _repository.getPerformance(
          '${NetworkEndpoints.employePerformance}?EmployeeId=${member!.employeeId}');

      final status = result['statusCode'];
      print(result);

      if (status == 200) {
        performanceModel = PerformanceModel.fromJson(result);
        if (performanceModel.message!.isEmpty) {
          print('empty');
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

  goToAddRecordScreen() async {
    await Get.toNamed(RouteEndpoints.addRecordScreen, arguments: member!);
    await getPerformance();
  }
}
