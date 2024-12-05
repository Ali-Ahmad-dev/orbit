import '../network/api_services.dart';

class ImageRepository {
  final ApiServices _apiService;
  ImageRepository(this._apiService);

  Future abc(String endpoint, var data) async {
    return await _apiService.postData(endpoint, data);
  }
}
