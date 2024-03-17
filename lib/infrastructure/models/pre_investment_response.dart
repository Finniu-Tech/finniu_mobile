class PreInvestmentSaveResponse {
  bool? success;
  String? preInvestmentUuid;
  String? errorMessage;

  PreInvestmentSaveResponse({
    this.success,
    this.preInvestmentUuid,
    this.errorMessage,
  });

  factory PreInvestmentSaveResponse.fromJson(Map<String, dynamic> json) => PreInvestmentSaveResponse(
        success: json["success"],
        preInvestmentUuid: json["preInvestmentUuid"],
        errorMessage: json["messages"]?[0]["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "preInvestmentUuid": preInvestmentUuid,
        "errorMessage": errorMessage,
      };
}
