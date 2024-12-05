import '../network/api_services.dart';

class AddRecordRepository {
  final ApiServices _apiService;
  AddRecordRepository(this._apiService);

  Future addMemberPerformance(String endpoint, var data) async {
    return await _apiService.postData(endpoint, data);
  }
}
