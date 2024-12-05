/// isError : false
/// additionalComments : ""
/// evaluationReportDtos : [{"parameterId":1,"additionalComment":"","title":"Work Quality","comment":"","rating":5,"date":"2024-08-08T17:32:50.783592"},{"parameterId":2,"additionalComment":"","title":"Attendance Punctuality","comment":"","rating":1,"date":"2024-08-08T17:32:50.8091333"},{"parameterId":3,"additionalComment":"","title":"Communication/Listening Skills","comment":"","rating":5,"date":"2024-08-08T17:32:50.8332421"},{"parameterId":4,"additionalComment":"","title":"Dependability","comment":"","rating":1,"date":"2024-08-08T17:32:50.8520178"},{"parameterId":5,"additionalComment":"","title":"Initiative","comment":"","rating":5,"date":"2024-08-08T17:32:50.8700879"},{"parameterId":6,"additionalComment":"","title":"Job Knowledge","comment":"","rating":5,"date":"2024-08-08T17:32:50.8863433"}]

class EvaluationHistoryModel {
  EvaluationHistoryModel({
      bool? isError, 
      String? additionalComments, 
      List<EvaluationReportDtos>? evaluationReportDtos,}){
    _isError = isError;
    _additionalComments = additionalComments;
    _evaluationReportDtos = evaluationReportDtos;
}

  EvaluationHistoryModel.fromJson(dynamic json) {
    _isError = json['isError'];
    _additionalComments = json['additionalComments'];
    if (json['evaluationReportDtos'] != null) {
      _evaluationReportDtos = [];
      json['evaluationReportDtos'].forEach((v) {
        _evaluationReportDtos?.add(EvaluationReportDtos.fromJson(v));
      });
    }
  }
  bool? _isError;
  String? _additionalComments;
  List<EvaluationReportDtos>? _evaluationReportDtos;
EvaluationHistoryModel copyWith({  bool? isError,
  String? additionalComments,
  List<EvaluationReportDtos>? evaluationReportDtos,
}) => EvaluationHistoryModel(  isError: isError ?? _isError,
  additionalComments: additionalComments ?? _additionalComments,
  evaluationReportDtos: evaluationReportDtos ?? _evaluationReportDtos,
);
  bool? get isError => _isError;
  String? get additionalComments => _additionalComments;
  List<EvaluationReportDtos>? get evaluationReportDtos => _evaluationReportDtos;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isError'] = _isError;
    map['additionalComments'] = _additionalComments;
    if (_evaluationReportDtos != null) {
      map['evaluationReportDtos'] = _evaluationReportDtos?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// parameterId : 1
/// additionalComment : ""
/// title : "Work Quality"
/// comment : ""
/// rating : 5
/// date : "2024-08-08T17:32:50.783592"

class EvaluationReportDtos {
  EvaluationReportDtos({
      num? parameterId, 
      String? additionalComment, 
      String? title, 
      String? comment, 
      num? rating, 
      String? date,}){
    _parameterId = parameterId;
    _additionalComment = additionalComment;
    _title = title;
    _comment = comment;
    _rating = rating;
    _date = date;
}

  EvaluationReportDtos.fromJson(dynamic json) {
    _parameterId = json['parameterId'];
    _additionalComment = json['additionalComment'];
    _title = json['title'];
    _comment = json['comment'];
    _rating = json['rating'];
    _date = json['date'];
  }
  num? _parameterId;
  String? _additionalComment;
  String? _title;
  String? _comment;
  num? _rating;
  String? _date;
EvaluationReportDtos copyWith({  num? parameterId,
  String? additionalComment,
  String? title,
  String? comment,
  num? rating,
  String? date,
}) => EvaluationReportDtos(  parameterId: parameterId ?? _parameterId,
  additionalComment: additionalComment ?? _additionalComment,
  title: title ?? _title,
  comment: comment ?? _comment,
  rating: rating ?? _rating,
  date: date ?? _date,
);
  num? get parameterId => _parameterId;
  String? get additionalComment => _additionalComment;
  String? get title => _title;
  String? get comment => _comment;
  num? get rating => _rating;
  String? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['parameterId'] = _parameterId;
    map['additionalComment'] = _additionalComment;
    map['title'] = _title;
    map['comment'] = _comment;
    map['rating'] = _rating;
    map['date'] = _date;
    return map;
  }

}