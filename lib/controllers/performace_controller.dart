import 'package:get/get.dart';
import 'package:orbit/constants/network/network_endpoints.dart';
import 'package:orbit/models/login_model.dart';
import 'package:orbit/models/performance_model.dart';
import 'package:orbit/repositories/performance_repository.dart';

class PerformaceController extends GetxController {
  final PerformanceRepository _repository;
  PerformaceController(this._repository);
  final preferencesController = Get.find<LoginModel>();
  PerformanceModel performanceModel = PerformanceModel();
  final RxString errorMessage = ''.obs;
  final RxBool apiCalling = false.obs;

  RxBool isPasswordObsecure = true.obs;
  var isExpanded = false.obs;
  var expandedIndex = (-1).obs;

  void toggleExpanded(int index) {
    if (expandedIndex.value == index) {
      expandedIndex.value = -1;
    } else {
      expandedIndex.value = index;
    }
  }

  @override
  void onInit() {
    getPerformance();
    super.onInit();
  }

  Future<void> getPerformance() async {
    final loginController = Get.find<LoginModel>();
    var id = loginController.employeeDetails!.employeeId;
    try {
      errorMessage.value = '';
      apiCalling.value = true;

      final result = await _repository.getPerformance(
          '${NetworkEndpoints.employePerformance}?EmployeeId=$id');

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

  Future<void> refreshPage() async {
    print('pulled');
    await getPerformance();
  }
}
