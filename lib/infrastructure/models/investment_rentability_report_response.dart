class UserInfoInvestmentReportResponse {
  UserInfoInvestment? userInfoInvestment;

  UserInfoInvestmentReportResponse({
    this.userInfoInvestment,
  });

  factory UserInfoInvestmentReportResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      UserInfoInvestmentReportResponse(
        userInfoInvestment:
            json == null ? null : UserInfoInvestment.fromJson(json),
      );

  Map<String, dynamic> toJson() => {
        "userInfoInvestment": userInfoInvestment?.toJson(),
      };
}

class UserInfoInvestment {
  int? totalBalanceAmmount;
  int? countPlanesActive;
  String? totalBalanceRentability;
  List<Investment>? invesmentInCourse;
  List<Investment>? invesmentFinished;

  UserInfoInvestment({
    this.totalBalanceAmmount,
    this.countPlanesActive,
    this.totalBalanceRentability,
    this.invesmentInCourse,
    this.invesmentFinished,
  });

  factory UserInfoInvestment.fromJson(Map<String, dynamic> json) =>
      UserInfoInvestment(
        totalBalanceAmmount: json["totalBalanceAmmount"],
        countPlanesActive: json["countPlanesActive"],
        totalBalanceRentability: json["totalBalanceRentability"],
        invesmentInCourse: json["invesmentInCourse"] == null
            ? []
            : List<Investment>.from(
                json["invesmentInCourse"]!.map((x) => Investment.fromJson(x)),),
        invesmentFinished: json["invesmentFinished"] == null
            ? []
            : List<Investment>.from(
                json["invesmentFinished"]!.map((x) => Investment.fromJson(x)),),
      );

  Map<String, dynamic> toJson() => {
        "totalBalanceAmmount": totalBalanceAmmount,
        "countPlanesActive": countPlanesActive,
        "totalBalanceRentability": totalBalanceRentability,
        "invesmentInCourse": invesmentInCourse == null
            ? []
            : List<dynamic>.from(invesmentInCourse!.map((x) => x.toJson())),
        "invesmentFinished": invesmentFinished == null
            ? []
            : List<dynamic>.from(invesmentFinished!.map((x) => x.toJson())),
      };
}

class Investment {
  String? uuid;
  DateTime? createdAt;
  bool? isActive;
  String? amount;
  Deadline? deadline;
  DepositBank? depositBank;
  String? contract;
  String? boucherTransaction;
  String? status;
  DateTime? startDateInvestment;
  DateTime? finishDateInvestment;
  String? rentabilityAmmount;
  String? rentabilityPercent;
  String? planName;
  bool? reinvestmentAvailable;

  Investment({
    this.uuid,
    this.createdAt,
    this.isActive,
    this.amount,
    this.deadline,
    this.depositBank,
    this.contract,
    this.boucherTransaction,
    this.status,
    this.startDateInvestment,
    this.finishDateInvestment,
    this.rentabilityAmmount,
    this.rentabilityPercent,
    this.planName,
    this.reinvestmentAvailable,
  });

  factory Investment.fromJson(Map<String, dynamic> json) => Investment(
        uuid: json["uuid"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        isActive: json["isActive"],
        amount: json["amount"],
        deadline: json["deadline"] == null
            ? null
            : Deadline.fromJson(json["deadline"]),
        depositBank: json["depositBank"] == null
            ? null
            : DepositBank.fromJson(json["depositBank"]),
        contract: json["contract"],
        boucherTransaction: json["boucherTransaction"],
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
        reinvestmentAvailable:
            json["reinvestmentAvailable"] == true ? true : false,
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "createdAt": createdAt?.toIso8601String(),
        "isActive": isActive,
        "amount": amount,
        "deadline": deadline?.toJson(),
        "depositBank": depositBank?.toJson(),
        "contract": contract,
        "boucherTransaction": boucherTransaction,
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

class DepositBank {
  String? bankName;
  String? bankLogo;
  String? slug;

  DepositBank({
    this.bankName,
    this.bankLogo,
    this.slug,
  });

  factory DepositBank.fromJson(Map<String, dynamic> json) => DepositBank(
        bankName: json["bankName"],
        bankLogo: json["bankLogo"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "bankName": bankName,
        "bankLogo": bankLogo,
        "slug": slug,
      };
}
