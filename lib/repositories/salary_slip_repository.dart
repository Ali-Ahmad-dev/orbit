import '../network/api_services.dart';

class SalarySlipRepository {
  final ApiServices _apiService;
  SalarySlipRepository(this._apiService);

  Future attendanceList(String endpoint, var data) async {
    return await _apiService.postData(endpoint, data);
  }
}
