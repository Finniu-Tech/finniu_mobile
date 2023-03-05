// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final scanModel = scanModelFromJson(jsonString);

import 'dart:convert';

ScanValidateOTPModel scanModelFromJson(String str) =>
    ScanValidateOTPModel.fromJson(json.decode(str));

String scanModelToJson(ScanValidateOTPModel data) => json.encode(data.toJson());

class ScanValidateOTPModel {
  ScanValidateOTPModel({
    this.validOtpUser,
  });

  ValidOtpUser? validOtpUser;

  factory ScanValidateOTPModel.fromJson(Map<String, dynamic> json) =>
      ScanValidateOTPModel(
        validOtpUser: json["validOtpUser"] == null
            ? null
            : ValidOtpUser.fromJson(json["validOtpUser"]),
      );

  Map<String, dynamic> toJson() => {
        "validOtpUser": validOtpUser?.toJson(),
      };
}

class ValidOtpUser {
  ValidOtpUser({
    this.success,
  });

  bool? success;

  factory ValidOtpUser.fromJson(Map<String, dynamic> json) => ValidOtpUser(
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
      };
}

class OTPForm {
  String email;
  String otp;
  OTPForm({
    required this.email,
    required this.otp,
  });
}
