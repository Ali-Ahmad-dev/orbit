import '../network/api_services.dart';

class ApplyLeaveRepository {
  final ApiServices _apiService;
  ApplyLeaveRepository(this._apiService);

  Future applyLeave(String endpoint, var data) async {
    return await _apiService.postData(endpoint, data);
  }

  Future getLeaveTypes(String endpoint) async {
    return await _apiService.getData(endpoint);
  }
}
