// To parse this JSON data, do
//
//     final scanModel = scanModelFromJson(jsonString);

// import 'dart:convert';

// ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));

// String scanModelToJson(ScanModel data) => json.encode(data.toJson());

// class ScanModel {
//     DeadLineResponse? data;

//     ScanModel({
//         this.data,
//     });

//     factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
//         data: json["data"] == null ? null : DeadLineResponse.fromJson(json["data"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "data": data?.toJson(),
//     };
// }

class DeadLineResponse {
  List<Deadline>? deadlines;

  DeadLineResponse({
    this.deadlines,
  });

  factory DeadLineResponse.fromJson(Map<String, dynamic> json) =>
      DeadLineResponse(
        deadlines: json["deadlines"] == null
            ? []
            : List<Deadline>.from(
                json["deadlines"]!.map(
                  (x) => Deadline.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "deadlines": deadlines == null
            ? []
            : List<dynamic>.from(
                deadlines!.map(
                  (x) => x.toJson(),
                ),
              ),
      };
}

class Deadline {
  String? uuid;
  bool? isActive;
  String? name;
  int? value;
  String? description;

  Deadline({
    this.uuid,
    this.isActive,
    this.name,
    this.value,
    this.description,
  });

  factory Deadline.fromJson(Map<String, dynamic> json) => Deadline(
        uuid: json["uuid"],
        isActive: json["isActive"],
        name: json["name"],
        value: json["value"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "isActive": isActive,
        "name": name,
        "value": value,
        "description": description,
      };
}
