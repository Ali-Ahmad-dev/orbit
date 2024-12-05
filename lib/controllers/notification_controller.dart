import 'package:get/get.dart';
import 'package:orbit/constants/jsons/notification_model.dart';
import 'package:orbit/constants/network/network_endpoints.dart';
import 'package:orbit/models/login_model.dart';
import 'package:orbit/models/notifications_model.dart';
import 'package:orbit/repositories/notification_repository.dart';

class NotificationController extends GetxController {
  final NotificationRepository _repository;
  NotificationController(this._repository);
  final preferencesController = Get.find<LoginModel>();

  final RxString errorMessage = ''.obs;
  final RxBool apiCalling = true.obs;

  // RxList<NotificationModel> notificationList = <NotificationModel>[].obs;
  NotificationsModel? notificationsModel;
  @override
  void onInit() {
    // notificationList.value = notification_data_model
    //     .map((item) => NotificationModel.fromJson(item))
    //     .toList();
    getAllNotification();
    super.onInit();
  }

  Future<void> getAllNotification() async {
    try {
      errorMessage.value = '';
      var id = preferencesController.employeeDetails!.employeeId;
      // var data = {
      //   "EmployeeId": id,
      //   "TypeIds": [1, 2, 3, 4, 5, 6],
      //   "PageNo": 1,
      //   "PageSize": 50
      // };
      // print(data);
      var result = await _repository.getNotifications(
          '${NetworkEndpoints.getNotifications}?EmployeeId=$id');
      final status = result['statusCode'];
      print('ddddddddddddddddddddddddd');
      print(result);

      if (status == 200) {
        // notificationList.value = (result['data'] as List)
        //     .map((item) => NotificationModel.fromJson(item))
        //     .toList();
        notificationsModel = NotificationsModel.fromJson(result);
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
