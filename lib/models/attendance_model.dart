import 'dart:convert';

// To parse this JSON data, do
//
//     final attendanceReport = attendanceReportFromJson(jsonString);

AttendanceReport attendanceReportFromJson(String str) =>
    AttendanceReport.fromJson(json.decode(str));

String attendanceReportToJson(AttendanceReport data) =>
    json.encode(data.toJson());

class AttendanceReport {
  bool? isError;
  List<AttendanceList>? data;

  AttendanceReport({
    this.isError,
    this.data,
  });

  factory AttendanceReport.fromJson(Map<String, dynamic> json) =>
      AttendanceReport(
        isError: json["isError"],
        data: json["data"] == null
            ? []
            : List<AttendanceList>.from(
                json["data"]!.map((x) => AttendanceList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "isError": isError,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class AttendanceList {
  String? date;
  String? checkIn;
  String? checkOut;
  String? duration;
  int? noOfMinutes;

  AttendanceList({
    this.date,
    this.checkIn,
    this.checkOut,
    this.duration,
    this.noOfMinutes,
  });

  factory AttendanceList.fromJson(Map<String, dynamic> json) => AttendanceList(
        date: json["date"],
        checkIn: json["checkIn"],
        checkOut: json["checkOut"],
        duration: json["duration"],
        noOfMinutes: json["noOfMinutes"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "checkIn": checkIn,
        "checkOut": checkOut,
        "duration": duration,
        "noOfMinutes": noOfMinutes,
      };
}
