import 'dart:convert';

// Converts JSON string to TeamMembers object
TeamMembers teamMembersFromJson(String str) =>
    TeamMembers.fromJson(json.decode(str));

// Converts TeamMembers object to JSON string
String teamMembersToJson(TeamMembers data) => json.encode(data.toJson());

class TeamMembers {
  final String? designation;
  final List<TeamMemberList>? data;
  final bool? isError;

  TeamMembers({this.designation, this.data, this.isError});

  factory TeamMembers.fromJson(Map<String, dynamic> json) => TeamMembers(
        designation: json["designation"],
        data: json["data"] != null
            ? List<TeamMemberList>.from(
                json["data"].map((x) => TeamMemberList.fromJson(x)))
            : [],
        isError: json["isError"],
      );

  Map<String, dynamic> toJson() => {
        "designation": designation,
        "data": data != null
            ? List<dynamic>.from(data!.map((x) => x.toJson()))
            : [],
        "isError": isError,
      };
}

class TeamMemberList {
  final String? leadName;
  final String? teamMemberName;
  final int? employeeId;
  final String? profilePic;
  final int? leaveCount;
  final String? fcmToken;

  TeamMemberList({
    this.leadName,
    this.teamMemberName,
    this.employeeId,
    this.profilePic,
    this.leaveCount,
    this.fcmToken,
  });

  factory TeamMemberList.fromJson(Map<String, dynamic> json) => TeamMemberList(
        leadName: json["leadName"],
        teamMemberName: json["teamMemberName"],
        employeeId: json["employeeId"],
        profilePic: json["profilePic"],
        leaveCount: json["leaveCount"],
        fcmToken: json["fcmToken"],
      );

  Map<String, dynamic> toJson() => {
        "leadName": leadName,
        "teamMemberName": teamMemberName,
        "employeeId": employeeId,
        "profilePic": profilePic,
        "leaveCount": leaveCount,
        "fcmToken": fcmToken,
      };
}
