import 'package:get/get.dart';
import 'package:orbit/constants/app_colors.dart';
import 'package:orbit/constants/routes/routes_endpoints.dart';
import 'package:orbit/models/login_model.dart';
import 'package:orbit/repositories/setting_repository.dart';
import 'package:orbit/utils/secure_storage.dart';
import 'package:orbit/utils/shared_prefrences.dart';

class SettingController extends GetxController {
  final preferencesController = Get.find<LoginModel>();
  final SettingRepository _repository;
  SettingController(this._repository);

  RxBool fingerPrintAble = false.obs;
  final secureStorage = SecureStorage();
  clearStorage() async {
    await secureStorage.clear();
    // AppColors.primaryColor.value = AppColors.primaryPurpleColor;
    await Get.delete<LoginModel>(force: true);
    // goToLogin();
    SharedPrefs().removeLoggedInSession(false);
    goToLogin();
  }

  Future fingerPrintFunction() async {
    if (fingerPrintAble.value) {
      return await secureStorage.saveFingerprint('ON');
    } else {
      return await secureStorage.clearFingerprint();
    }
  }

  goToLogin() {
    Get.offAllNamed(RouteEndpoints.loginScreen);
  }
}
