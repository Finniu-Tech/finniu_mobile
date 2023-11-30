// To parse this JSON data, do
//
//     final scanModel = scanModelFromJson(jsonString);

import 'dart:convert';

// PlanListResponse scanModelFromJson(String str) =>
//     PlanListResponse.fromJson(json.decode(str));

// String scanModelToJson(PlanListResponse data) => json.encode(data.toJson());

// class PlanListResponse {
//   PlanListResponse({
//     this.data,
//   });

//   Data? data;

//   factory PlanListResponse.fromJson(Map<String, dynamic> json) =>
//       PlanListResponse(
//         data: json["data"] == null ? null : Data.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "data": data?.toJson(),
//       };
// }

class PlanListResponse {
  PlanListResponse({
    this.planData,
  });

  List<PlanDatum>? planData;

  factory PlanListResponse.fromJson(List<dynamic> json) => PlanListResponse(
        planData: json == null
            ? []
            : List<PlanDatum>.from(json!.map((x) => PlanDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "planData": planData == null
            ? []
            : List<dynamic>.from(planData!.map((x) => x.toJson())),
      };
}

class PlanDatum {
  PlanDatum({
    this.uuid,
    this.name,
    this.description,
    this.minAmount,
    this.value,
    this.twelveMonthsReturn,
    this.sixMonthsReturn,
    this.returnDateEstimate,
    this.planImageUrl,
    this.objective,
    this.imgDistribution,
    this.features = const [],
  });

  String? uuid;
  String? name;
  String? description;
  String? minAmount;
  String? objective;
  String? imgDistribution;
  List<String> features = [];
  int? value;
  String? twelveMonthsReturn;
  String? sixMonthsReturn;
  DateTime? returnDateEstimate;
  String? planImageUrl;

  factory PlanDatum.fromJson(Map<String, dynamic> json) => PlanDatum(
        uuid: json["uuid"],
        name: json["name"],
        description: json["description"],
        minAmount: json["minAmount"],
        value: json["value"],
        twelveMonthsReturn: json["twelveMonthsReturn"],
        sixMonthsReturn: json["sixMonthsReturn"],
        returnDateEstimate: json["returnDateEstimate"] == null
            ? null
            : DateTime.parse(json["returnDateEstimate"]),
        planImageUrl: json["planImageUrl"],
        objective: json["objective"],
        imgDistribution: json["imgDistribution"],
        features: json["characteristics"] == null
            ? []
            : List<String>.from(
                json["characteristics"]
                    .where((x) => x["isActive"] == true)
                    .toList()
                    // ..sort((a, b) =>
                    //         (a["order"] as int).compareTo(b["order"] as int))
                    .map((x) => x["text"]),
              ),
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "name": name,
        "description": description,
        "minAmount": minAmount,
        "value": value,
        "twelveMonthsReturn": twelveMonthsReturn,
        "sixMonthsReturn": sixMonthsReturn,
        "returnDateEstimate":
            "${returnDateEstimate!.year.toString().padLeft(4, '0')}-${returnDateEstimate!.month.toString().padLeft(2, '0')}-${returnDateEstimate!.day.toString().padLeft(2, '0')}",
        "planImageUrl": planImageUrl,
        "objective": objective,
        "imgDistribution": imgDistribution,
        "features": List<dynamic>.from(features.map((x) => x)),
      };
}
