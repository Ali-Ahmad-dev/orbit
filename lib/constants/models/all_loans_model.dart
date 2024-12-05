/// employeeName : "Usman  Sharif"
/// designation : "SQA"
/// profile : "No Profile Photo"
/// employeeId : 3200
/// timeStamp : "2023-05-02T00:00:00"

class AllLoansModel {
  AllLoansModel({
      String? employeeName, 
      String? designation, 
      String? profile, 
      num? employeeId, 
      String? timeStamp,}){
    _employeeName = employeeName;
    _designation = designation;
    _profile = profile;
    _employeeId = employeeId;
    _timeStamp = timeStamp;
}

  AllLoansModel.fromJson(dynamic json) {
    _employeeName = json['employeeName'];
    _designation = json['designation'];
    _profile = json['profile'];
    _employeeId = json['employeeId'];
    _timeStamp = json['timeStamp'];
  }
  String? _employeeName;
  String? _designation;
  String? _profile;
  num? _employeeId;
  String? _timeStamp;
AllLoansModel copyWith({  String? employeeName,
  String? designation,
  String? profile,
  num? employeeId,
  String? timeStamp,
}) => AllLoansModel(  employeeName: employeeName ?? _employeeName,
  designation: designation ?? _designation,
  profile: profile ?? _profile,
  employeeId: employeeId ?? _employeeId,
  timeStamp: timeStamp ?? _timeStamp,
);
  String? get employeeName => _employeeName;
  String? get designation => _designation;
  String? get profile => _profile;
  num? get employeeId => _employeeId;
  String? get timeStamp => _timeStamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['employeeName'] = _employeeName;
    map['designation'] = _designation;
    map['profile'] = _profile;
    map['employeeId'] = _employeeId;
    map['timeStamp'] = _timeStamp;
    return map;
  }

}