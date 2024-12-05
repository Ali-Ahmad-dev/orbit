class NetworkEndpoints {
  // static const String BASE_URL = 'https://sundashrapi.sundas.org/api/';
  static const String BASE_URL =
      'https://192.250.231.7/plesk-site-preview/sales.nkutech.com/api/';

  static const String login = 'Account/Login';
  static const String hrChats = 'Chats/GetHrChats';
  static const String pendingRequests = 'Leave/FetchPendingRequests';
  static const String GetCurrentMonthAttendenceOfTeamMembers =
      'Employee/GetCurrentMonthAttendenceOfTeamMembers';
  static const String getAttendanceList = 'Attendence/Get';
  static const String getAllLoans = 'Employee/GetAllEmployeeLoanHistory';
  static const String approveLeaves = 'Employee/Approve';
  static const String rejectLeaves = 'Employee/Reject';
  static const String getLeaveHistory = 'Leave/PreviousLeaveHistory';
  static const String getLoanHistory = 'Employee/GetLoanHistory';
  static const String getDeductionType = 'Employee/DeductionTypes';
  static const String applyLoan = 'Employee/ApplyForLoan';
  static const String leaveReasons = 'Leave/LeaveReasons';
  static const String applyLeave = 'Leave/Apply';
  static const String employePerformance = 'Employee/GetEmployeePerformance';
  static const String getTeamMembers = 'Employee/GetTeamMembers';
  static const String addMemberPerformance = 'Employee/CreateMemberPerformance';
  static const String getEvaluationParameters = 'EvaluationParameters/Get';
  static const String createReportEvaluation = 'EvaluationReport/Create';
  static const String getChats = 'Chats/GetChats';
  static const String createChats = 'Chats/Create';
  static const String getNotifications = 'Notification/GetAllNotifications';
  static const String getEvaluationHistory =
      'EvaluationReport/GetEvaluationReport';
  // static const String webSocketUrl =
  //     'https://sales.nkutech.com/api/notificationHub';
  static const String webSocketUrl =
      'https://sales.nkutech.com/notificationHub';
  static const String approvalStatus = '/Leave/GetApprovalStatus';
}
