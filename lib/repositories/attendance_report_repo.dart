import '../network/api_services.dart';

class AttendanceReportRepository {
  final ApiServices _apiService;
  AttendanceReportRepository(this._apiService);

  Future attendanceList(String endpoint, var data) async {
    return await _apiService.postData(endpoint, data);
  }
}
