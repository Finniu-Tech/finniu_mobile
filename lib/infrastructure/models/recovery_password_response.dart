class RecoveryPasswordData {
  RecoveryPasswordData({
    this.recoveryPassword,
  });

  RecoveryPassword? recoveryPassword;

  factory RecoveryPasswordData.fromJson(Map<String, dynamic> json) =>
      RecoveryPasswordData(
        recoveryPassword: json["recoveryPassword"] == null
            ? null
            : RecoveryPassword.fromJson(json["recoveryPassword"]),
      );

  Map<String, dynamic> toJson() => {
        "recoveryPassword": recoveryPassword?.toJson(),
      };
}

class RecoveryPassword {
  RecoveryPassword({
    this.success,
    this.successSendCode,
  });

  bool? success;
  bool? successSendCode;

  factory RecoveryPassword.fromJson(Map<String, dynamic> json) =>
      RecoveryPassword(
        success: json["success"],
        successSendCode: json["successSendCode"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "successSendCode": successSendCode,
      };
}
