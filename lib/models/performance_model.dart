import 'dart:convert';

/// Converts JSON string to `PerformanceModel` object
PerformanceModel performanceModelFromJson(String str) =>
    PerformanceModel.fromJson(json.decode(str));

/// Converts `PerformanceModel` object to JSON string
String performanceModelToJson(PerformanceModel data) =>
    json.encode(data.toJson());

/// Model representing the performance data
class PerformanceModel {
  final List<Message>? message;

  PerformanceModel({this.message});

  factory PerformanceModel.fromJson(Map<String, dynamic> json) =>
      PerformanceModel(
        message: json["message"] != null
            ? List<Message>.from(
                json["message"].map((x) => Message.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "message": message != null
            ? List<dynamic>.from(message!.map((x) => x.toJson()))
            : [],
      };
}

/// Model representing a message in the performance data
class Message {
  final int? id;
  final String? problem;
  final String? suggestion;
  final String? severity;
  final int? employeeId;
  final dynamic employee;
  final int? createdBy;
  final dynamic updatedBy;
  final String? createdDateTime;
  final String? updatedDateTime;
  final bool? isDeleted;
  final bool? isActive;

  Message({
    this.id,
    this.problem,
    this.suggestion,
    this.severity,
    this.employeeId,
    this.employee,
    this.createdBy,
    this.updatedBy,
    this.createdDateTime,
    this.updatedDateTime,
    this.isDeleted,
    this.isActive,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        problem: json["problem"],
        suggestion: json["suggestion"],
        severity: json["severity"],
        employeeId: json["employeeId"],
        employee: json["employee"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        createdDateTime: json["createdDateTime"],
        updatedDateTime: json["updatedDateTime"],
        isDeleted: json["isDeleted"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "problem": problem,
        "suggestion": suggestion,
        "severity": severity,
        "employeeId": employeeId,
        "employee": employee,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "createdDateTime": createdDateTime,
        "updatedDateTime": updatedDateTime,
        "isDeleted": isDeleted,
        "isActive": isActive,
      };
}
