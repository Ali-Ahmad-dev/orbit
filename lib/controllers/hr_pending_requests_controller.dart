import 'package:get/get.dart';
import 'package:orbit/constants/network/network_endpoints.dart';
import 'package:orbit/constants/routes/routes_endpoints.dart';
import 'package:orbit/models/login_model.dart';
import 'package:orbit/models/pending_request_model.dart';
import 'package:orbit/models/performance_model.dart';
import 'package:orbit/repositories/hr_messages_repository.dart';

class HRPendingRequestsController extends GetxController {
  final HRMessagesRepository _repository;
  HRPendingRequestsController(this._repository);

  final preferencesController = Get.find<LoginModel>();
  final RxString errorMessage = ''.obs;
  final RxBool apiCalling = false.obs;

  PerformanceModel performanceModel = PerformanceModel();

  RxList<PendingRequestModel> reqList = <PendingRequestModel>[].obs;

  @override
  void onInit() {
    getPendingRequests();
    super.onInit();
  }

  Future<void> getPendingRequests() async {
    try {
      errorMessage.value = '';
      apiCalling.value = true;

      final result = await _repository
          .getPendingRequests(NetworkEndpoints.pendingRequests);

      print('getPendingRequests => ${result}');

      if (result.isNotEmpty) {
        reqList.value = result;
      }
    } catch (e) {
      errorMessage.value = 'Failed to fetch leave history: $e';
      print(e);
    } finally {
      apiCalling.value = false;
    }
  }

  goToLeaveRequestScreen(PendingRequestModel request) async {
    await Get.toNamed(RouteEndpoints.leaveRequestScreen, arguments: request);
    await getPendingRequests();
  }

  goToEmployeeLeaveHistoryScreen(PendingRequestModel request) async {
    await Get.toNamed(RouteEndpoints.employeeLeaveHistoryScreen,
        arguments: request);
    await getPendingRequests();
  }
}
