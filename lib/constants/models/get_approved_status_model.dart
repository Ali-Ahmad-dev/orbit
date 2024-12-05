import 'package:flutter/src/material/dropdown.dart';

class GetApprovedStatus {
  List<ApprovalStatus>? approvalStatus;
  bool? isError;
  GetApprovedStatus({this.approvalStatus, this.isError});
  GetApprovedStatus.fromJson(Map<String, dynamic> json) {
    if (json['approvalStatus'] != dynamic) {
      approvalStatus = <ApprovalStatus>[];
      json['approvalStatus'].forEach((v) {
        approvalStatus!.add(new ApprovalStatus.fromJson(v));
      });
    }
    isError = json['isError'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.approvalStatus != dynamic) {
      data['approvalStatus'] =
          this.approvalStatus!.map((v) => v.toJson()).toList();
    }
    data['isError'] = this.isError;
    return data;
  }
}

class ApprovalStatus {
  int? id;
  String? statusName;
  int? createdBy;
  dynamic? updatedBy;
  String? createdDateTime;
  dynamic? updatedDateTime;
  bool? isDeleted;
  bool? isActive;
  ApprovalStatus(
      {this.id,
      this.statusName,
      this.createdBy,
      this.updatedBy,
      this.createdDateTime,
      this.updatedDateTime,
      this.isDeleted,
      this.isActive});
  ApprovalStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    statusName = json['statusName'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    createdDateTime = json['createdDateTime'];
    updatedDateTime = json['updatedDateTime'];
    isDeleted = json['isDeleted'];
    isActive = json['isActive'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['statusName'] = this.statusName;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['createdDateTime'] = this.createdDateTime;
    data['updatedDateTime'] = this.updatedDateTime;
    data['isDeleted'] = this.isDeleted;
    data['isActive'] = this.isActive;
    return data;
  }
}
