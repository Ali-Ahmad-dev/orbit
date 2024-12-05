import '../network/api_services.dart';

class LeaveHistoryRepository {
  final ApiServices _apiService;
  LeaveHistoryRepository(this._apiService);

  Future getLeaveHistory(
    String endpoint,
  ) async {
    return await _apiService.getData(endpoint);
  }
}
