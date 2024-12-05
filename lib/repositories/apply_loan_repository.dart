import '../network/api_services.dart';

class ApplyLoanRepository {
  final ApiServices _apiService;
  ApplyLoanRepository(this._apiService);

  Future applyLoan(String endpoint, var data) async {
    return await _apiService.postData(endpoint, data);
  }

  Future getDeductionTypes(String endpoint) async {
    return await _apiService.getData(endpoint);
  }
}
