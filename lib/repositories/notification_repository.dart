import 'package:orbit/network/api_services.dart';

class NotificationRepository {
  final ApiServices _apiService;
  NotificationRepository(this._apiService);

  Future getNotifications(String endpoint) async {
    return await _apiService.getData(endpoint);
  }
}
