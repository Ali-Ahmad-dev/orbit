import 'package:get/get.dart';
import 'package:orbit/constants/chat_keys.dart';
import 'package:orbit/constants/jsons/hr_chat_list.dart';
import 'package:orbit/constants/models/hr_chat_list_model.dart';
import 'package:orbit/constants/network/network_endpoints.dart';
import 'package:orbit/constants/routes/routes_endpoints.dart';
import 'package:orbit/models/login_model.dart';
import 'package:orbit/repositories/hr_messages_repository.dart';
import 'package:orbit/utils/shared_prefrences.dart';

class HRMessagesController extends GetxController {
  final HRMessagesRepository _repository;
  HRMessagesController(this._repository);

  final preferencesController = Get.find<LoginModel>();

  final RxString errorMessage = ''.obs;
  final RxBool apiCalling = true.obs;

  RxList<HrChatListModel> hrChatList = <HrChatListModel>[].obs;

  @override
  void onInit() {
    // hrChatList.value = (hr_chat_data as List)
    //     .map((item) => HrChatListModel.fromJson(item))
    getHrMessages();
    //     .toList();
    super.onInit();
  }

  Future<void> getHrMessages() async {
    final loginController = Get.find<LoginModel>();
    var id = loginController.employeeDetails!.employeeId;
    try {
      errorMessage.value = '';
      // apiCalling.value = true;
      print(id);
      final result = await _repository
          .getHrMessages('${NetworkEndpoints.hrChats}?UserId=$id');

      final status = result['statusCode'];
      print(result);

      if (status == 200) {
        hrChatList.value = (result['data'] as List)
            .map((item) => HrChatListModel.fromJson(item))
            .toList();
      } else {
        errorMessage.value = result['message'] ?? 'Unknown error occurred';
      }
    } catch (e) {
      errorMessage.value = 'Failed to fetch leave history: $e';
      print(e);
    } finally {
      apiCalling.value = false;
    }
  }

  goToMessageScreen(HrChatListModel chat) async {
    final login = Get.find<LoginModel>();
    final designation = (await SharedPrefs.getEmployeeDesignation())!;

    Get.toNamed(RouteEndpoints.messageScreen, arguments: {
      ChatKeys.employeeIsHR: designation == 'HR' ? true : false,
      ChatKeys.employeeChatModel: chat
    });
  }
}
