import 'dart:convert';

DeductionTypes DeductionTypesFromJson(String str) =>
    DeductionTypes.fromJson(json.decode(str));

String DeductionTypesToJson(DeductionTypes data) => json.encode(data.toJson());

class DeductionTypes {
  int? id;
  String? name;

  DeductionTypes({
    this.id,
    this.name,
  });

  factory DeductionTypes.fromJson(Map<String, dynamic> json) => DeductionTypes(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
