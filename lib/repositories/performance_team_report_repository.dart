import '../network/api_services.dart';

class PerformanceTeamReportRepository {
  final ApiServices _apiService;
  PerformanceTeamReportRepository(this._apiService);
  Future getPerformance(
    String endpoint,
  ) async {
    return await _apiService.getData(endpoint);
  }
}
