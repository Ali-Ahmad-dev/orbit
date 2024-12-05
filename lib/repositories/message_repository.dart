import '../network/api_services.dart';

class MessageRepository {
  final ApiServices _apiService;
  MessageRepository(this._apiService);

  Future getChats(String endpoint, var data) async {
    return await _apiService.postData(endpoint, data);
  }

  Future createChats(String endpoint, var data) async {
    return await _apiService.postData(endpoint, data);
  }
}
