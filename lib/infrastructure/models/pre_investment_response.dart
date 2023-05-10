// To parse this JSON data, do
//
//     final scanModel = scanModelFromJson(jsonString);

import 'dart:convert';

// ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));

// String scanModelToJson(ScanModel data) => json.encode(data.toJson());

// class ScanModel {
//     PreInvestmentSaveResponse? data;

//     ScanModel({
//         this.data,
//     });

//     factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
//         data: json["data"] == null ? null : PreInvestmentSaveResponse.fromJson(json["data"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "data": data?.toJson(),
//     };
// }

// class PreInvestmentSaveResponse {
//   SavePreInvestment? savePreInvestment;

//   PreInvestmentSaveResponse({
//     this.savePreInvestment,
//   });

//   factory PreInvestmentSaveResponse.fromJson(Map<String, dynamic> json) =>
//       PreInvestmentSaveResponse(
//         savePreInvestment: json["savePreInvestment"] == null
//             ? null
//             : SavePreInvestment.fromJson(json["savePreInvestment"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "savePreInvestment": savePreInvestment?.toJson(),
//       };
// }

class PreInvestmentSaveResponse {
  bool? success;
  String? preInvestmentUuid;

  PreInvestmentSaveResponse({
    this.success,
    this.preInvestmentUuid,
  });

  factory PreInvestmentSaveResponse.fromJson(Map<String, dynamic> json) =>
      PreInvestmentSaveResponse(
        success: json["success"],
        preInvestmentUuid: json["preInvestmentUuid"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "preInvestmentUuid": preInvestmentUuid,
      };
}
