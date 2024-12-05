import 'package:orbit/constants/models/all_loans_model.dart';

import '../network/api_services.dart';

class AllLoanRepository {
  final ApiServices _apiService;
  AllLoanRepository(this._apiService);

  Future<List<AllLoansModel>> getAllLoans(String endpoint) async {
    return (await _apiService.getDataWithoutStatusCode(endpoint) as List)
        .map((item) => AllLoansModel.fromJson(item))
        .toList();
  }
}
