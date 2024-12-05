class HrChatListModel {
  HrChatListModel({
    String? employeeName,
    String? designation,
    String? timeStamp,
    num? employeeId,
    int? aspNetUserId,
    String? profile,
    String? message,
  }) {
    _employeeName = employeeName;
    _designation = designation;
    _timeStamp = timeStamp;
    _employeeId = employeeId;
    _aspNetUserId = aspNetUserId;
    _profile = profile;
    _message = message;
  }

  HrChatListModel.fromJson(dynamic json) {
    _employeeName = json['employeeName'];
    _designation = json['designation'];
    _timeStamp = json['timeStamp'];
    _employeeId = json['employeeId'];
    _aspNetUserId = json['aspNetUserId'];
    _profile = json['profile'];
    _message = json['message'];
  }
  String? _employeeName;
  String? _designation;
  String? _timeStamp;
  num? _employeeId;
  int? _aspNetUserId;
  String? _profile;
  String? _message;
  HrChatListModel copyWith({
    String? employeeName,
    String? designation,
    String? timeStamp,
    num? employeeId,
    int? aspNetUserId,
    String? profile,
    String? message,
  }) =>
      HrChatListModel(
        employeeName: employeeName ?? _employeeName,
        designation: designation ?? _designation,
        timeStamp: timeStamp ?? _timeStamp,
        employeeId: employeeId ?? _employeeId,
        aspNetUserId: aspNetUserId ?? _aspNetUserId,
        profile: profile ?? _profile,
        message: message ?? _message,
      );
  String? get employeeName => _employeeName;
  String? get designation => _designation;
  String? get timeStamp => _timeStamp;
  num? get employeeId => _employeeId;
  int? get aspNetUserId => _aspNetUserId;
  String? get profile => _profile;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['employeeName'] = _employeeName;
    map['designation'] = _designation;
    map['timeStamp'] = _timeStamp;
    map['employeeId'] = _employeeId;
    map['aspNetUserId'] = _aspNetUserId;
    map['profile'] = _profile;
    map['message'] = _message;
    return map;
  }
}
