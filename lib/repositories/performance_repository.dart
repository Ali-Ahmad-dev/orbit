import '../network/api_services.dart';

class PerformanceRepository {
  final ApiServices _apiService;
  PerformanceRepository(this._apiService);

  Future getPerformance(
    String endpoint,
  ) async {
    return await _apiService.getData(endpoint);
  }
}
