import 'dart:convert';

LeaveHistory leaveHistoryFromJson(String str) =>
    LeaveHistory.fromJson(json.decode(str));

String leaveHistoryToJson(LeaveHistory data) => json.encode(data.toJson());

class LeaveHistory {
  bool? isError;
  int? thisMonthLeaveCount;
  List<PreviousLeaveHistory>? previousLeaveHistory;
  List<LeaveHistoryDetail>? leaveHistoryDetails;

  LeaveHistory({
    this.isError,
    this.thisMonthLeaveCount,
    this.previousLeaveHistory,
    this.leaveHistoryDetails,
  });

  factory LeaveHistory.fromJson(Map<String, dynamic> json) => LeaveHistory(
        isError: json["isError"],
        thisMonthLeaveCount: json["thisMonthLeaveCount"],
        previousLeaveHistory: json["previousLeaveHistory"] == null
            ? []
            : List<PreviousLeaveHistory>.from(json["previousLeaveHistory"]
                .map((x) => PreviousLeaveHistory.fromJson(x))),
        leaveHistoryDetails: json["leaveHistoryDetails"] == null
            ? []
            : List<LeaveHistoryDetail>.from(json["leaveHistoryDetails"]
                .map((x) => LeaveHistoryDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "isError": isError,
        "thisMonthLeaveCount": thisMonthLeaveCount,
        "previousLeaveHistory": previousLeaveHistory == null
            ? []
            : List<dynamic>.from(previousLeaveHistory!.map((x) => x.toJson())),
        "leaveHistoryDetails": leaveHistoryDetails == null
            ? []
            : List<dynamic>.from(leaveHistoryDetails!.map((x) => x.toJson())),
      };
}

class LeaveHistoryDetail {
  String? leaveTypeName;
  String? applYFromDate;
  String? applYToDate;
  String? employeeComments;
  String? teamLeadComments;
  String? hrComments;
  String? rejectedLeave;
  String? leaveCatName;
  String? attachment;
  bool? iSApproved;
  dynamic admiNComments;
  dynamic firstHalf;
  dynamic secondHalf;
  dynamic startTime;
  dynamic endTime;
  String? leaveRequestCreatedDateTime;
  List<String>? isApprovedByTl;
  List<String>? isRejectedByTl;
  List<String>? isApprovedByHr;
  List<String>? isRejectedByHr;

  LeaveHistoryDetail({
    this.leaveTypeName,
    this.applYFromDate,
    this.applYToDate,
    this.hrComments,
    this.employeeComments,
    this.teamLeadComments,
    this.rejectedLeave,
    this.leaveCatName,
    this.attachment,
    this.iSApproved,
    this.admiNComments,
    this.firstHalf,
    this.secondHalf,
    this.startTime,
    this.endTime,
    this.leaveRequestCreatedDateTime,
    this.isApprovedByTl,
    this.isRejectedByTl,
    this.isApprovedByHr,
    this.isRejectedByHr,
  });

  factory LeaveHistoryDetail.fromJson(Map<String, dynamic> json) =>
      LeaveHistoryDetail(
        leaveTypeName: json["leaveTypeName"],
        applYFromDate: json["applY_FROM_DATE"],
        applYToDate: json["applY_TO_DATE"],
        hrComments: json["hrComment"],
        employeeComments: json["employeeComments"],
        teamLeadComments: json["teamLeadComment"],
        rejectedLeave: json["rejectedLeave"],
        leaveCatName: json["leaveCatName"],
        attachment: json["attachment"],
        iSApproved: json["iS_APPROVED"],
        admiNComments: json["admiN_COMMENTS"],
        firstHalf: json["firstHalf"],
        secondHalf: json["secondHalf"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        leaveRequestCreatedDateTime: json["leaveRequestCREATED_DATE_TIME"],
        isApprovedByTl: json["isApprovedByTL"] == null
            ? []
            : List<String>.from(json["isApprovedByTL"].map((x) => x)),
        isRejectedByTl: json["isRejectedByTL"] == null
            ? []
            : List<String>.from(json["isRejectedByTL"].map((x) => x)),
        isApprovedByHr: json["isApprovedByHR"] == null
            ? []
            : List<String>.from(json["isApprovedByHR"].map((x) => x)),
        isRejectedByHr: json["isRejectedByHR"] == null
            ? []
            : List<String>.from(json["isRejectedByHR"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "leaveTypeName": leaveTypeName,
        "applY_FROM_DATE": applYFromDate,
        "applY_TO_DATE": applYToDate,
        "employeeComments": employeeComments,
        "teamLeadComment": teamLeadComments,
        "rejectedLeave": rejectedLeave,
        "hrComment": hrComments,
        "leaveCatName": leaveCatName,
        "attachment": attachment,
        "iS_APPROVED": iSApproved,
        "admiN_COMMENTS": admiNComments,
        "firstHalf": firstHalf,
        "secondHalf": secondHalf,
        "startTime": startTime,
        "endTime": endTime,
        "leaveRequestCREATED_DATE_TIME": leaveRequestCreatedDateTime,
        "isApprovedByTL": isApprovedByTl == null
            ? []
            : List<dynamic>.from(isApprovedByTl!.map((x) => x)),
        "isRejectedByTL": isRejectedByTl == null
            ? []
            : List<dynamic>.from(isRejectedByTl!.map((x) => x)),
        "isApprovedByHR": isApprovedByHr == null
            ? []
            : List<dynamic>.from(isApprovedByHr!.map((x) => x)),
        "isRejectedByHR": isRejectedByHr == null
            ? []
            : List<dynamic>.from(isRejectedByHr!.map((x) => x)),
      };
}

class PreviousLeaveHistory {
  int? totalLeaves;
  int? remainingLeaves;
  String? leaveTypeName;
  int? leaveTypeId;
  int? availed;

  PreviousLeaveHistory({
    this.totalLeaves,
    this.remainingLeaves,
    this.leaveTypeName,
    this.leaveTypeId,
    this.availed,
  });

  factory PreviousLeaveHistory.fromJson(Map<String, dynamic> json) =>
      PreviousLeaveHistory(
        totalLeaves: json["totalLeaves"],
        remainingLeaves: json["remainingLeaves"],
        leaveTypeName: json["leaveTypeName"],
        leaveTypeId: json["leaveTypeId"],
        availed: json["availed"],
      );

  Map<String, dynamic> toJson() => {
        "totalLeaves": totalLeaves,
        "remainingLeaves": remainingLeaves,
        "leaveTypeName": leaveTypeName,
        "leaveTypeId": leaveTypeId,
        "availed": availed,
      };
}
