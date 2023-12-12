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
  String action;
  OTPForm({
    required this.email,
    required this.otp,
    required this.action,
  });
}

// ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));

// String scanModelToJson(ScanModel data) => json.encode(data.toJson());

// class ScanModel {
//   ScanModel({
//     this.resendOtpCode,
//   });

//   ResendOtpCode? resendOtpCode;

//   factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
//         resendOtpCode: json["resendOtpCode"] == null
//             ? null
//             : ResendOtpCode.fromJson(json["resendOtpCode"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "resendOtpCode": resendOtpCode?.toJson(),
//       };
// }

class ResendOtpCode {
  ResendOtpCode({
    this.success,
    this.successResendCode,
  });

  bool? success;
  bool? successResendCode;

  factory ResendOtpCode.fromJson(Map<String, dynamic> json) => ResendOtpCode(
        success: json["success"],
        successResendCode: json["successResendCode"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "successResendCode": successResendCode,
      };
}

class EmailOTPCodeResponse {
  bool? success;
  bool? successResendCode;
  EmailOTPCodeResponse({
    this.success,
    this.successResendCode,
  });

  factory EmailOTPCodeResponse.fromJson(Map<String, dynamic> json) =>
      EmailOTPCodeResponse(
        success: json["success"],
        successResendCode: json["successResendCode"],
      );
}
