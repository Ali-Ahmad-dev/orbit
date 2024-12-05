import '../network/api_services.dart';

class SettingRepository {
  final ApiServices _apiService;
  SettingRepository(this._apiService);

  Future abc(String endpoint, var data) async {
    return await _apiService.postData(endpoint, data);
  }
}
