// class EvaluationHistoryModel {
//   EvaluationHistoryModel({
//       String? date,
//       num? rating,
//       String? comment,
//       String? title,}){
//     _date = date;
//     _rating = rating;
//     _comment = comment;
//     _title = title;
// }
//
//   EvaluationHistoryModel.fromJson(dynamic json) {
//     _date = json['date'];
//     _rating = json['rating'];
//     _comment = json['comment'];
//     _title = json['Title'];
//   }
//   String? _date;
//   num? _rating;
//   String? _comment;
//   String? _title;
// EvaluationHistoryModel copyWith({  String? date,
//   num? rating,
//   String? comment,
//   String? title,
// }) => EvaluationHistoryModel(  date: date ?? _date,
//   rating: rating ?? _rating,
//   comment: comment ?? _comment,
//   title: title ?? _title,
// );
//   String? get date => _date;
//   num? get rating => _rating;
//   String? get comment => _comment;
//   String? get title => _title;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['date'] = _date;
//     map['rating'] = _rating;
//     map['comment'] = _comment;
//     map['Title'] = _title;
//     return map;
//   }
//
// }