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

class SetNewPasswordData {
  SetNewPasswordData({
    this.changePasswordMinimal,
  });

  ChangePasswordMinimal? changePasswordMinimal;

  factory SetNewPasswordData.fromJson(Map<String, dynamic> json) =>
      SetNewPasswordData(
        changePasswordMinimal: json["changePasswordMinimal"] == null
            ? null
            : ChangePasswordMinimal.fromJson(json["changePasswordMinimal"]),
      );

  Map<String, dynamic> toJson() => {
        "changePasswordMinimal": changePasswordMinimal?.toJson(),
      };
}

class ChangePasswordMinimal {
  ChangePasswordMinimal({
    this.success,
  });

  bool? success;

  factory ChangePasswordMinimal.fromJson(Map<String, dynamic> json) =>
      ChangePasswordMinimal(
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
      };
}
