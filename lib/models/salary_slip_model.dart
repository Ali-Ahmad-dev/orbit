// To parse this JSON data, do
//
//     final salarySlip = salarySlipFromJson(jsonString);

import 'dart:convert';

SalarySlip salarySlipFromJson(String str) =>
    SalarySlip.fromJson(json.decode(str));

String salarySlipToJson(SalarySlip data) => json.encode(data.toJson());

class SalarySlip {
  List<Datum>? data;

  SalarySlip({
    this.data,
  });

  factory SalarySlip.fromJson(Map<String, dynamic> json) => SalarySlip(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  double? overTime;
  int? paidDays;
  int? totaldays;
  double? payrollSalary;
  double? totalAllowance;
  double? taxDeduction;
  double? netpayablesalary;

  Datum({
    this.overTime,
    this.paidDays,
    this.totaldays,
    this.payrollSalary,
    this.totalAllowance,
    this.taxDeduction,
    this.netpayablesalary,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        overTime: json["overTime"],
        paidDays: json["paidDays"],
        totaldays: json["totaldays"],
        payrollSalary: json["payrollSalary"]?.toDouble(),
        totalAllowance: json["totalAllowance"]?.toDouble(),
        taxDeduction: json["taxDeduction"]?.toDouble(),
        netpayablesalary: json["netpayablesalary"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "overTime": overTime,
        "paidDays": paidDays,
        "totaldays": totaldays,
        "payrollSalary": payrollSalary,
        "totalAllowance": totalAllowance,
        "taxDeduction": taxDeduction,
        "netpayablesalary": netpayablesalary,
      };
}
