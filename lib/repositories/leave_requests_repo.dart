import 'package:orbit/constants/models/current_month_attendance_model.dart';
import 'package:orbit/network/api_services.dart';

class LeaveRequestsRepository {
  final ApiServices _apiService;
  LeaveRequestsRepository(this._apiService);
  Future attendanceList(String endpoint, var data) async {
    return await _apiService.postData(endpoint, data);
  }

  Future<CurrentMonthAttendanceModel> getCurrentMonthAttendance(
    String endpoint,
  ) async {
    return CurrentMonthAttendanceModel.fromJson(
        await _apiService.getData(endpoint));
  }

  Future approveLeaves(String endpoint, var data) async {
    return await _apiService.postData(endpoint, data);
  }

  Future rejectLeaves(String endpoint, var data) async {
    return await _apiService.postData(endpoint, data);
  }

  Future<Map<String, dynamic>> getApprovalStatus(String endpoint) async {
    return await _apiService.getData(endpoint);
  }
}
