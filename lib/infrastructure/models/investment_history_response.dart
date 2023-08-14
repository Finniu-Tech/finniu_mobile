class HistoryInvestmentResponse {
  UserInfoInvestment? userInfoInvestment;

  HistoryInvestmentResponse({
    this.userInfoInvestment,
  });

  factory HistoryInvestmentResponse.fromJson(Map<String, dynamic> json) =>
      HistoryInvestmentResponse(
        userInfoInvestment:
            json == null ? null : UserInfoInvestment.fromJson(json),
      );

  Map<String, dynamic> toJson() => {
        "userInfoInvestment": userInfoInvestment?.toJson(),
      };
}

class UserInfoInvestment {
  int? totalBalanceAmount;
  int? countPlanesActive;
  String? totalBalanceRentability;
  List<InvesmentFinishedElement>? invesmentInCourse;
  List<InvesmentFinishedElement>? invesmentFinished;
  List<InvesmentCanceledElement>? invesmentInProcess;
  List<InvesmentCanceledElement>? invesmentCanceled;

  UserInfoInvestment({
    this.totalBalanceAmount,
    this.countPlanesActive,
    this.totalBalanceRentability,
    this.invesmentInCourse,
    this.invesmentFinished,
    this.invesmentInProcess,
    this.invesmentCanceled,
  });

  factory UserInfoInvestment.fromJson(Map<String, dynamic> json) =>
      UserInfoInvestment(
        totalBalanceAmount: json["totalBalanceAmmount"],
        countPlanesActive: json["countPlanesActive"],
        totalBalanceRentability: json["totalBalanceRentability"],
        invesmentInCourse: json["invesmentInCourse"] == null
            ? []
            : List<InvesmentFinishedElement>.from(json["invesmentInCourse"]!
                .map((x) => InvesmentFinishedElement.fromJson(x))),
        invesmentFinished: json["invesmentFinished"] == null
            ? []
            : List<InvesmentFinishedElement>.from(json["invesmentFinished"]!
                .map((x) => InvesmentFinishedElement.fromJson(x))),
        invesmentInProcess: json["invesmentInProcess"] == null
            ? []
            : List<InvesmentCanceledElement>.from(json["invesmentInProcess"]!
                .map((x) => InvesmentCanceledElement.fromJson(x))),
        invesmentCanceled: json["invesmentCanceled"] == null
            ? []
            : List<InvesmentCanceledElement>.from(json["invesmentCanceled"]!
                .map((x) => InvesmentCanceledElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalBalanceAmmount": totalBalanceAmount,
        "countPlanesActive": countPlanesActive,
        "totalBalanceRentability": totalBalanceRentability,
        "invesmentInCourse": invesmentInCourse == null
            ? []
            : List<dynamic>.from(invesmentInCourse!.map((x) => x.toJson())),
        "invesmentFinished": invesmentFinished == null
            ? []
            : List<dynamic>.from(invesmentFinished!.map((x) => x.toJson())),
        "invesmentInProcess": invesmentInProcess == null
            ? []
            : List<dynamic>.from(invesmentInProcess!.map((x) => x.toJson())),
        "invesmentCanceled": invesmentCanceled == null
            ? []
            : List<dynamic>.from(invesmentCanceled!.map((x) => x.toJson())),
      };
}

class InvesmentCanceledElement {
  String? uuid;
  String? amount;
  String? planName;
  String? status;

  InvesmentCanceledElement({
    this.uuid,
    this.amount,
    this.planName,
    this.status,
  });

  factory InvesmentCanceledElement.fromJson(Map<String, dynamic> json) =>
      InvesmentCanceledElement(
        uuid: json["uuid"],
        amount: json["amount"],
        planName: json["planName"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "amount": amount,
        "planName": planName,
        "status": status,
      };
}

class InvesmentFinishedElement {
  String? uuid;
  String? amount;
  Deadline? deadline;
  String? status;
  DateTime? startDateInvestment;
  DateTime? finishDateInvestment;
  String? rentabilityAmmount;
  String? rentabilityPercent;
  String? planName;

  InvesmentFinishedElement({
    this.uuid,
    this.amount,
    this.deadline,
    this.status,
    this.startDateInvestment,
    this.finishDateInvestment,
    this.rentabilityAmmount,
    this.rentabilityPercent,
    this.planName,
  });

  factory InvesmentFinishedElement.fromJson(Map<String, dynamic> json) =>
      InvesmentFinishedElement(
        uuid: json["uuid"],
        amount: json["amount"],
        deadline: json["deadline"] == null
            ? null
            : Deadline.fromJson(json["deadline"]),
        status: json["status"],
        startDateInvestment: json["startDateInvestment"] == null
            ? null
            : DateTime.parse(json["startDateInvestment"]),
        finishDateInvestment: json["finishDateInvestment"] == null
            ? null
            : DateTime.parse(json["finishDateInvestment"]),
        rentabilityAmmount: json["rentabilityAmmount"],
        rentabilityPercent: json["rentabilityPercent"],
        planName: json["planName"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "amount": amount,
        "deadline": deadline?.toJson(),
        "status": status,
        "startDateInvestment":
            "${startDateInvestment!.year.toString().padLeft(4, '0')}-${startDateInvestment!.month.toString().padLeft(2, '0')}-${startDateInvestment!.day.toString().padLeft(2, '0')}",
        "finishDateInvestment":
            "${finishDateInvestment!.year.toString().padLeft(4, '0')}-${finishDateInvestment!.month.toString().padLeft(2, '0')}-${finishDateInvestment!.day.toString().padLeft(2, '0')}",
        "rentabilityAmmount": rentabilityAmmount,
        "rentabilityPercent": rentabilityPercent,
        "planName": planName,
      };
}

class Deadline {
  String? uuid;
  String? name;
  int? value;
  String? description;

  Deadline({
    this.uuid,
    this.name,
    this.value,
    this.description,
  });

  factory Deadline.fromJson(Map<String, dynamic> json) => Deadline(
        uuid: json["uuid"],
        name: json["name"],
        value: json["value"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "name": name,
        "value": value,
        "description": description,
      };
}
