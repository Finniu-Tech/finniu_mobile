// To parse this JSON data, do
//
//     final scanModel = scanModelFromJson(jsonString);

import 'dart:convert';

CalculateInvestmentResponse scanModelFromJson(String str) =>
    CalculateInvestmentResponse.fromJson(json.decode(str));

String scanModelToJson(CalculateInvestmentResponse data) =>
    json.encode(data.toJson());

class CalculateInvestmentResponse {
  CalculateInvestmentResponse({
    this.calculateInvestment,
  });

  CalculateInvestment? calculateInvestment;

  factory CalculateInvestmentResponse.fromJson(Map<String, dynamic> json) =>
      CalculateInvestmentResponse(
        calculateInvestment: json["calculateInvestment"] == null
            ? null
            : CalculateInvestment.fromJson(json["calculateInvestment"]),
      );

  Map<String, dynamic> toJson() => {
        "calculateInvestment": calculateInvestment?.toJson(),
      };
}

class CalculateInvestment {
  CalculateInvestment({
    this.success,
    this.profitability,
    this.plan,
  });

  bool? success;
  Profitability? profitability;
  Plan? plan;

  factory CalculateInvestment.fromJson(Map<String, dynamic> json) =>
      CalculateInvestment(
        success: json["success"],
        profitability: json["profitability"] == null
            ? null
            : Profitability.fromJson(json["profitability"]),
        plan: json["plan"] == null ? null : Plan.fromJson(json["plan"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "profitability": profitability?.toJson(),
        "plan": plan?.toJson(),
      };
}

class Plan {
  Plan({
    this.uuid,
    this.name,
    this.description,
    this.minAmount,
    this.value,
    this.twelveMonthsReturn,
    this.sixMonthsReturn,
    this.returnDateEstimate,
    this.planImageUrl,
  });

  String? uuid;
  String? name;
  String? description;
  String? minAmount;
  int? value;
  String? twelveMonthsReturn;
  String? sixMonthsReturn;
  DateTime? returnDateEstimate;
  String? planImageUrl;

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
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
      };
}

class Profitability {
  Profitability({
    this.preInvestmentAmount,
  });

  int? preInvestmentAmount;

  factory Profitability.fromJson(Map<String, dynamic> json) => Profitability(
        preInvestmentAmount: json["preInvestmentAmount"],
      );

  Map<String, dynamic> toJson() => {
        "preInvestmentAmount": preInvestmentAmount,
      };
}