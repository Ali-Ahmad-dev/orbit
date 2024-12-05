import 'package:get/get.dart';
import 'package:orbit/constants/models/all_loans_model.dart';
import 'package:orbit/constants/network/network_endpoints.dart';
import 'package:orbit/constants/routes/routes_endpoints.dart';
import 'package:orbit/repositories/all_loan_repository.dart';

class AllLoanController extends GetxController {
  final AllLoanRepository _repository;
  AllLoanController(this._repository);

  RxList<AllLoansModel> list = <AllLoansModel>[].obs;

  final RxBool apiCalling = true.obs;

  goToLoanScreen(AllLoansModel allLoanModel) {
    Get.toNamed(RouteEndpoints.loanScreen, arguments: allLoanModel);
  }

  @override
  void onInit() {
    getAllLoans();
    super.onInit();
  }

  Future<void> getAllLoans() async {
    try {
      list.value =
          await _repository.getAllLoans('${NetworkEndpoints.getAllLoans}');
      print(list);
    } catch (e) {
      print(e);
    } finally {
      apiCalling.value = false;
    }
  }
}
