// To parse this JSON data, do
//
//     final evaluationParameters = evaluationParametersFromJson(jsonString);

import 'dart:convert';

EvaluationParameters evaluationParametersFromJson(String str) =>
    EvaluationParameters.fromJson(json.decode(str));

String evaluationParametersToJson(EvaluationParameters data) =>
    json.encode(data.toJson());

class EvaluationParameters {
  bool? isError;
  List<Parameter>? parameters;

  EvaluationParameters({
    this.isError,
    this.parameters,
  });

  factory EvaluationParameters.fromJson(Map<String, dynamic> json) =>
      EvaluationParameters(
        isError: json["isError"],
        parameters: json["data"] == null
            ? []
            : List<Parameter>.from(
                json["data"]!.map((x) => Parameter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "isError": isError,
        "data": parameters == null
            ? []
            : List<dynamic>.from(parameters!.map((x) => x.toJson())),
      };
}

class Parameter {
  int? id;
  String? parameter;

  Parameter({
    this.id,
    this.parameter,
  });

  factory Parameter.fromJson(Map<String, dynamic> json) => Parameter(
        id: json["id"],
        parameter: json["parameter"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parameter": parameter,
      };
}
