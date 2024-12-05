import 'package:orbit/network/api_services.dart';

class EmployeeLeaveHistoryRepo {
  final ApiServices _apiService;
  EmployeeLeaveHistoryRepo(this._apiService);

  Future getEmployeeLeaveHistory(
    String endpoint,
  ) async {
    return await _apiService.getData(endpoint);
  }
}
