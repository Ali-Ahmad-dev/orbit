/// Title : "New Policy Update"
/// Message : "There is a new update to the company policy regarding remote work."
/// Type : "Policy"
/// rowCount : 100
/// CreatedDateTime : "2024-07-25T14:30:00Z"

class NotificationModel {
  NotificationModel({
      String? title, 
      String? message, 
      String? type, 
      num? rowCount, 
      String? createdDateTime,}){
    _title = title;
    _message = message;
    _type = type;
    _rowCount = rowCount;
    _createdDateTime = createdDateTime;
}

  NotificationModel.fromJson(dynamic json) {
    _title = json['Title'];
    _message = json['Message'];
    _type = json['Type'];
    _rowCount = json['rowCount'];
    _createdDateTime = json['CreatedDateTime'];
  }
  String? _title;
  String? _message;
  String? _type;
  num? _rowCount;
  String? _createdDateTime;
NotificationModel copyWith({  String? title,
  String? message,
  String? type,
  num? rowCount,
  String? createdDateTime,
}) => NotificationModel(  title: title ?? _title,
  message: message ?? _message,
  type: type ?? _type,
  rowCount: rowCount ?? _rowCount,
  createdDateTime: createdDateTime ?? _createdDateTime,
);
  String? get title => _title;
  String? get message => _message;
  String? get type => _type;
  num? get rowCount => _rowCount;
  String? get createdDateTime => _createdDateTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Title'] = _title;
    map['Message'] = _message;
    map['Type'] = _type;
    map['rowCount'] = _rowCount;
    map['CreatedDateTime'] = _createdDateTime;
    return map;
  }

}