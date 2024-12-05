/// leadName : "Farrukh"
/// teamMemberName : "AbdulMateen Mateen"
/// employeeId : 3136
/// profilePic : "http://18.117.20.119:8086//Reservoir/Employee/3136/Photo/211a4f7d-6537-4bf9-badd-76738a6e0745WhatsApp Image 2023-02-15 at 10.17.55 AM.jpeg"
/// unApprovedLeaveCount : 1
/// fcmToken : "Not Available"
/// designation : "Full Stack"

class PendingRequestModel {
  PendingRequestModel({
      String? leadName, 
      String? teamMemberName, 
      num? employeeId, 
      String? profilePic, 
      num? unApprovedLeaveCount, 
      String? fcmToken, 
      String? designation,}){
    _leadName = leadName;
    _teamMemberName = teamMemberName;
    _employeeId = employeeId;
    _profilePic = profilePic;
    _unApprovedLeaveCount = unApprovedLeaveCount;
    _fcmToken = fcmToken;
    _designation = designation;
}

  PendingRequestModel.fromJson(dynamic json) {
    _leadName = json['leadName'];
    _teamMemberName = json['teamMemberName'];
    _employeeId = json['employeeId'];
    _profilePic = json['profilePic'];
    _unApprovedLeaveCount = json['unApprovedLeaveCount'];
    _fcmToken = json['fcmToken'];
    _designation = json['designation'];
  }
  String? _leadName;
  String? _teamMemberName;
  num? _employeeId;
  String? _profilePic;
  num? _unApprovedLeaveCount;
  String? _fcmToken;
  String? _designation;
PendingRequestModel copyWith({  String? leadName,
  String? teamMemberName,
  num? employeeId,
  String? profilePic,
  num? unApprovedLeaveCount,
  String? fcmToken,
  String? designation,
}) => PendingRequestModel(  leadName: leadName ?? _leadName,
  teamMemberName: teamMemberName ?? _teamMemberName,
  employeeId: employeeId ?? _employeeId,
  profilePic: profilePic ?? _profilePic,
  unApprovedLeaveCount: unApprovedLeaveCount ?? _unApprovedLeaveCount,
  fcmToken: fcmToken ?? _fcmToken,
  designation: designation ?? _designation,
);
  String? get leadName => _leadName;
  String? get teamMemberName => _teamMemberName;
  num? get employeeId => _employeeId;
  String? get profilePic => _profilePic;
  num? get unApprovedLeaveCount => _unApprovedLeaveCount;
  String? get fcmToken => _fcmToken;
  String? get designation => _designation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['leadName'] = _leadName;
    map['teamMemberName'] = _teamMemberName;
    map['employeeId'] = _employeeId;
    map['profilePic'] = _profilePic;
    map['unApprovedLeaveCount'] = _unApprovedLeaveCount;
    map['fcmToken'] = _fcmToken;
    map['designation'] = _designation;
    return map;
  }

}