import 'package:get/get.dart';
import 'package:orbit/constants/network/network_endpoints.dart';
import 'package:orbit/models/login_model.dart';
import 'package:orbit/models/team_member_model.dart';
import 'package:orbit/repositories/team_report_repository.dart';
import '../constants/routes/routes_endpoints.dart';

class TeamReportController extends GetxController {
  final preferencesController = Get.find<LoginModel>();
  final TeamReportRepository _repository;
  TeamReportController(this._repository);

  final isClicked = false.obs;
  final selectedIndex = 0.obs;
  var teamMemberList = <TeamMemberList>[].obs;
  var filteredTeamMemberList = <TeamMemberList>[].obs; // Filtered list
  TeamMembers teamMembers = TeamMembers();
  final RxString errorMessage = ''.obs;
  final RxBool apiCalling = false.obs;

  RxBool isPasswordObsecure = true.obs;
  var isExpanded = false.obs;

  @override
  void onInit() {
    getTeamMembers();
    super.onInit();
  }

  Future<void> getTeamMembers() async {
    final loginController = Get.find<LoginModel>();
    var id = loginController.employeeDetails!.employeeId;
    print('getTeamMembers => $id');
    try {
      errorMessage.value = '';
      apiCalling.value = true;

      final result = await _repository
          .getTeamMembers('${NetworkEndpoints.getTeamMembers}?EmployeeId=$id');

      final status = result['statusCode'];
      print(result);

      if (status == 200) {
        teamMembers = TeamMembers.fromJson(result);
        teamMemberList.value = teamMembers.data!;
        filteredTeamMemberList.value =
            teamMemberList; // Initialize the filtered list
        if (teamMembers.isError == true) {
          errorMessage.value = 'An error has occurred';
        } else {
          Get.put(teamMembers, permanent: true);
        }
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

  void filterTeamMembers(String query) {
    if (query.isEmpty) {
      // Reset to the full list when the search query is empty
      filteredTeamMemberList.value = teamMemberList;
    } else {
      // Perform a case-insensitive search by name
      filteredTeamMemberList.value = teamMemberList
          .where((member) =>
              member.teamMemberName != null &&
              member.teamMemberName!
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    }
  }

  goToEvaluationScreen(TeamMemberList teamMember) {
    Get.toNamed(RouteEndpoints.evaluationScreen, arguments: teamMember);
  }

  goToPerformanceTeamReportScreen(TeamMemberList teamMember) {
    Get.toNamed(RouteEndpoints.performanceTeamReportScreen,
        arguments: teamMember);
  }

  goToMemberAttendanceReportScreen(TeamMemberList teamMember) {
    Get.toNamed(RouteEndpoints.memberAttendanceReportScreen,
        arguments: teamMember);
  }

  goToLeaveRequestScreen(int id, String name) {
    Get.toNamed(RouteEndpoints.leaveRequestScreen,
        parameters: {'id': id.toString(), 'name': name});
  }

  goToEvaluationHistoryScreen(TeamMemberList teamMember) {
    Get.toNamed(RouteEndpoints.evaluationHistoryScreen, arguments: teamMember);
  }
}
