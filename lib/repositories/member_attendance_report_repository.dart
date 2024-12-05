import '../network/api_services.dart';

class MemberAttendanceReportRepository {
  final ApiServices _apiService;
  MemberAttendanceReportRepository(this._apiService);

  Future getMemberAttendanceList(String endpoint, var data) async {
    return await _apiService.postData(endpoint, data);
  }

  Future getMemberLeaveHistory(
    String endpoint,
  ) async {
    return await _apiService.getData(endpoint);
  }
}
