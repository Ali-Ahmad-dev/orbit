import '../network/api_services.dart';

class EvaluationHistoryRepository {
  final ApiServices _apiService;
  EvaluationHistoryRepository(this._apiService);

  Future getEvaluationHistory(String endpoint) async {
    return await _apiService.getData(endpoint);
  }
}
