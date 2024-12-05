import 'package:orbit/models/pending_request_model.dart';

import '../network/api_services.dart';

class HRMessagesRepository {
  final ApiServices _apiService;
  HRMessagesRepository(this._apiService);

  Future getHrMessages(
    String endpoint,
  ) async {
    return await _apiService.getData(endpoint);
  }

  Future<List<PendingRequestModel>> getPendingRequests(
    String endpoint,
  ) async {
    return (await _apiService.getData(endpoint) as List)
        .map((item) => PendingRequestModel.fromJson(item))
        .toList();
  }
}
