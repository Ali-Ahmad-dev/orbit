class LeaveType {
  final int? leaveTypeId;
  final String? leaveTypeName;

  LeaveType({
    required this.leaveTypeId,
    required this.leaveTypeName,
  });

  factory LeaveType.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw FormatException("Null JSON provided to LeaveType.fromJson");
    }
    return LeaveType(
      leaveTypeId: json['leaveTypeId'] as int?,
      leaveTypeName: json['leaveTypeName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'leaveTypeId': leaveTypeId,
      'leaveTypeName': leaveTypeName,
    };
  }
}

class LeaveTypesResponse {
  final List<LeaveType>? reasons;
  final List<LeaveType>? shortHalfKeyValPair;
  final bool? isError;

  LeaveTypesResponse({
    this.reasons,
    this.shortHalfKeyValPair,
    this.isError,
  });

  factory LeaveTypesResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw FormatException(
          "Null JSON provided to LeaveTypesResponse.fromJson");
    }

    List<LeaveType>? parseLeaveTypes(List<dynamic>? list) {
      return list
          ?.map((e) => LeaveType.fromJson(e as Map<String, dynamic>?))
          .toList();
    }

    return LeaveTypesResponse(
      reasons: parseLeaveTypes(json['reasons'] as List<dynamic>?),
      shortHalfKeyValPair:
          parseLeaveTypes(json['shortHalfKeyValPair'] as List<dynamic>?),
      isError: json['isError'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>>? leaveTypesToJson(List<LeaveType>? list) {
      return list?.map((e) => e.toJson()).toList();
    }

    return {
      'reasons': leaveTypesToJson(reasons),
      'shortHalfKeyValPair': leaveTypesToJson(shortHalfKeyValPair),
      'isError': isError,
    };
  }
}
