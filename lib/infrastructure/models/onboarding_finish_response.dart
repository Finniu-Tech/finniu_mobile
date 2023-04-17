class FinishOnboardingResponseModel {
  FinishOnboardingResponseModel({
    this.finishOnboarding,
  });

  FinishOnboarding? finishOnboarding;

  factory FinishOnboardingResponseModel.fromJson(Map<String, dynamic> json) =>
      FinishOnboardingResponseModel(
        finishOnboarding: json["finishOnboarding"] == null
            ? null
            : FinishOnboarding.fromJson(json["finishOnboarding"]),
      );

  Map<String, dynamic> toJson() => {
        "finishOnboarding": finishOnboarding?.toJson(),
      };
}

class FinishOnboarding {
  FinishOnboarding({
    this.success,
    this.plan,
  });

  bool? success;
  Plan? plan;

  factory FinishOnboarding.fromJson(Map<String, dynamic> json) =>
      FinishOnboarding(
        success: json["success"],
        plan: json["plan"] == null ? null : Plan.fromJson(json["plan"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "plan": plan?.toJson(),
      };
}

class Plan {
  Plan({
    this.uuid,
    this.name,
    this.minAmount,
    this.value,
    this.twelveMonthsReturn,
    this.sixMonthsReturn,
    this.description,
    this.returnEstimatedDate,
  });

  String? uuid;
  String? name;
  String? minAmount;
  int? value;
  String? twelveMonthsReturn;
  String? sixMonthsReturn;
  String? description;
  DateTime? returnEstimatedDate = DateTime.now();

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        uuid: json["uuid"],
        name: json["name"],
        minAmount: json["minAmount"],
        value: json["value"],
        twelveMonthsReturn: json["twelveMonthsReturn"],
        sixMonthsReturn: json["sixMonthsReturn"],
        description: json["description"],
        returnEstimatedDate: json["returnEstimatedDate"] == null
            ? null
            : DateTime.parse(json["returnEstimatedDate"]),
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "name": name,
        "minAmount": minAmount,
        "value": value,
        "twelveMonthsReturn": twelveMonthsReturn,
        "sixMonthsReturn": sixMonthsReturn,
        "description": description,
        "returnEstimatedDate": returnEstimatedDate == null
            ? null
            : returnEstimatedDate!.toIso8601String(),
      };
}

class SelectedAnswer {
  int pageIndex;
  int answerIndex;

  SelectedAnswer(this.pageIndex, this.answerIndex);

  SelectedAnswer copyWith({
    int? pageIndex,
    int? answerIndex,
  }) {
    return SelectedAnswer(
      pageIndex ?? this.pageIndex,
      answerIndex ?? this.answerIndex,
    );
  }
}
