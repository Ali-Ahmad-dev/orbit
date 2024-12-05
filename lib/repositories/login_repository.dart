import '../network/api_services.dart';

class LoginRepository {
  final ApiServices _apiService;
  LoginRepository(this._apiService);

  Future loginUser(String endpoint, var data) async {
    return await _apiService.postDataWithoutToken(endpoint, data);
  }
}
