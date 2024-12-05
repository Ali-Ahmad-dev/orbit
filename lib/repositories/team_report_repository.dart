import '../network/api_services.dart';

class TeamReportRepository {
  final ApiServices _apiService;
  TeamReportRepository(this._apiService);

  Future getTeamMembers(
    String endpoint,
  ) async {
    return await _apiService.getData(endpoint);
  }
}
