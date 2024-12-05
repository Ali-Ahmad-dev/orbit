import '../network/api_services.dart';

class EvaluationRepository {
  final ApiServices _apiService;
  EvaluationRepository(this._apiService);

  Future getEvaluationReport(String endpoint) async {
    return await _apiService.getData(
      endpoint,
    );
  }

  Future addEvaluationReport(String endpoint, var data) async {
    return await _apiService.postData(endpoint, data);
  }
}
