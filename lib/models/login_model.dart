import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  final bool? isError;
  final String? message;
  final String? token;
  final Details? hrLeadDetails;
  final Details? teamLeadDetails;
  final Details? employeeDetails;
  final List<TimeSheet>? timeSheet;
  final List<dynamic>? leaves;
  final CurrentMonthHours? currentMonthHours;
  final int? currentMonthLeaves;

  LoginModel({
    this.isError,
    this.message,
    this.token,
    this.hrLeadDetails,
    this.teamLeadDetails,
    this.employeeDetails,
    this.timeSheet,
    this.leaves,
    this.currentMonthHours,
    this.currentMonthLeaves,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        isError: json["isError"] as bool?,
        message: json["message"] as String?,
        token: json["token"] as String?,
        hrLeadDetails: json["hrLeadDetails"] == null
            ? null
            : Details.fromJson(json["hrLeadDetails"] as Map<String, dynamic>),
        teamLeadDetails: json["teamLeadDetails"] == null
            ? null
            : Details.fromJson(json["teamLeadDetails"] as Map<String, dynamic>),
        employeeDetails: json["employeeDetails"] == null
            ? null
            : Details.fromJson(json["employeeDetails"] as Map<String, dynamic>),
        timeSheet: json["timeSheet"] == null
            ? []
            : List<TimeSheet>.from((json["timeSheet"] as List<dynamic>)
                .map((x) => TimeSheet.fromJson(x as Map<String, dynamic>))),
        leaves: json["leaves"] == null
            ? []
            : List<dynamic>.from(json["leaves"] as List<dynamic>),
        currentMonthHours: json["currentMonthHours"] == null
            ? null
            : CurrentMonthHours.fromJson(
                json["currentMonthHours"] as Map<String, dynamic>),
        currentMonthLeaves: json["currentMonthLeaves"] as int?,
      );

  Map<String, dynamic> toJson() => {
        "isError": isError,
        "message": message,
        "token": token,
        "hrLeadDetails": hrLeadDetails?.toJson(),
        "teamLeadDetails": teamLeadDetails?.toJson(),
        "employeeDetails": employeeDetails?.toJson(),
        "timeSheet": timeSheet == null
            ? []
            : List<dynamic>.from(timeSheet!.map((x) => x.toJson())),
        "leaves": leaves == null ? [] : List<dynamic>.from(leaves!),
        "currentMonthHours": currentMonthHours?.toJson(),
        "currentMonthLeaves": currentMonthLeaves,
      };
}

class CurrentMonthHours {
  final double? totalHours;

  CurrentMonthHours({
    this.totalHours,
  });

  factory CurrentMonthHours.fromJson(Map<String, dynamic> json) =>
      CurrentMonthHours(
        totalHours: (json["totalHours"] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "totalHours": totalHours,
      };
}

class Details {
  final int? employeeId;
  final int? aspNetUserId;
  final String? employeeName;
  final String? designation;
  final String? photo;
  final String? roleName;
  final String? fcmToken;

  Details({
    this.employeeId,
    this.aspNetUserId,
    this.employeeName,
    this.designation,
    this.photo,
    this.roleName,
    this.fcmToken,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        employeeId: json["employeeId"] as int?,
        aspNetUserId: json["aspNetUserId"] as int?,
        employeeName: json["employeeName"] as String?,
        designation: json["designation"] as String?,
        photo: json["photo"] as String?,
        roleName: json["roleName"] as String?,
        fcmToken: json["fcmToken"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "employeeId": employeeId,
        "aspNetUserId": aspNetUserId,
        "employeeName": employeeName,
        "designation": designation,
        "photo": photo,
        "roleName": roleName,
        "fcmToken": fcmToken,
      };
}

class TimeSheet {
  final String? date;
  final String? checkIn;
  final String? checkOut;
  final String? duration;
  final int? noOfMinutes;

  TimeSheet({
    this.date,
    this.checkIn,
    this.checkOut,
    this.duration,
    this.noOfMinutes,
  });

  factory TimeSheet.fromJson(Map<String, dynamic> json) => TimeSheet(
        date: json["date"] as String?,
        checkIn: json["checkIn"] as String?,
        checkOut: json["checkOut"] as String?,
        duration: json["duration"] as String?,
        noOfMinutes: json["noOfMinutes"] as int?,
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "checkIn": checkIn,
        "checkOut": checkOut,
        "duration": duration,
        "noOfMinutes": noOfMinutes,
      };
}
