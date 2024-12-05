import '../network/api_services.dart';

class LoanRepository {
  final ApiServices _apiService;
  LoanRepository(this._apiService);

  Future getLoanHistory(String endpoint) async {
    return await _apiService.getData(endpoint);
  }
}
