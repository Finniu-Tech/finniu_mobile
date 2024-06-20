class UserInfoInvestmentReportResponse {
  UserInfoInvestment? userInfoInvestment;

  UserInfoInvestmentReportResponse({
    this.userInfoInvestment,
  });

  factory UserInfoInvestmentReportResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      UserInfoInvestmentReportResponse(
        userInfoInvestment: json == null ? null : UserInfoInvestment.fromJson(json),
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
  List<Investment>? investmentPending;

  UserInfoInvestment({
    this.totalBalanceAmmount,
    this.countPlanesActive,
    this.totalBalanceRentability,
    this.invesmentInCourse,
    this.invesmentFinished,
    this.investmentPending,
  });

  factory UserInfoInvestment.fromJson(Map<String, dynamic> json) => UserInfoInvestment(
        totalBalanceAmmount: json["totalBalanceAmmount"],
        countPlanesActive: json["countPlanesActive"],
        totalBalanceRentability: json["totalBalanceRentability"],
        invesmentInCourse: json["invesmentInCourse"] == null
            ? []
            : List<Investment>.from(
                json["invesmentInCourse"]!.map((x) => Investment.fromJson(x)),
              ),
        invesmentFinished: json["invesmentFinished"] == null
            ? []
            : List<Investment>.from(
                json["invesmentFinished"]!.map((x) => Investment.fromJson(x)),
              ),
        investmentPending: json["investmentPending"] == null
            ? []
            : List<Investment>.from(
                json["investmentPending"]!.map((x) => Investment.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "totalBalanceAmmount": totalBalanceAmmount,
        "countPlanesActive": countPlanesActive,
        "totalBalanceRentability": totalBalanceRentability,
        "invesmentInCourse":
            invesmentInCourse == null ? [] : List<dynamic>.from(invesmentInCourse!.map((x) => x.toJson())),
        "invesmentFinished":
            invesmentFinished == null ? [] : List<dynamic>.from(invesmentFinished!.map((x) => x.toJson())),
        "investmentPending":
            investmentPending == null ? [] : List<dynamic>.from(investmentPending!.map((x) => x.toJson())),
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
  PartnerResponse? partner;
  List<PartnerTagResponse?>? partnerTag;
  bool isReInvestment = false;
  bool noReInvestment = false;
  String? actionStatus;

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
    this.partner,
    this.partnerTag,
    this.isReInvestment = false,
    this.noReInvestment = false,
    this.actionStatus,
  });

  factory Investment.fromJson(Map<String, dynamic> json) => Investment(
        uuid: json["uuid"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        isActive: json["isActive"],
        amount: json["amount"],
        deadline: json["deadline"] == null ? null : Deadline.fromJson(json["deadline"]),
        depositBank: json["depositBank"] == null ? null : DepositBank.fromJson(json["depositBank"]),
        contract: json["contract"],
        boucherTransaction: json["boucherTransaction"],
        status: json["status"],
        startDateInvestment: json["startDateInvestment"] == null ? null : DateTime.parse(json["startDateInvestment"]),
        finishDateInvestment:
            json["finishDateInvestment"] == null ? null : DateTime.parse(json["finishDateInvestment"]),
        rentabilityAmmount: json["rentabilityAmmount"],
        rentabilityPercent: json["rentabilityPercent"],
        planName: json["planName"],
        reinvestmentAvailable: json["reinvestmentAvailable"] == true ? true : false,
        partner: json["partnerInfo"] == null || json["partnerInfo"]?['partnerHex'] == null
            ? null
            : PartnerResponse.fromJson(json["partnerInfo"]),
        partnerTag: json["couponPartnerTags"] == null || json["couponPartnerTags"] == []
            ? []
            : List<PartnerTagResponse?>.from(
                json["couponPartnerTags"].map((x) => x == null ? null : PartnerTagResponse.fromJson(x)),
              ),
        isReInvestment: json["isReInvestment"] ?? false,
        noReInvestment: json["noReInvestment"] ?? false,
        actionStatus: json["actionStatus"],
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
        "reInvestmentAvailable": reinvestmentAvailable,
        "noReinvestment": noReInvestment,
        "actionStatus": actionStatus,
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

class PartnerTagResponse {
  String partnerTag;
  String hexColor;

  PartnerTagResponse({
    required this.partnerTag,
    required this.hexColor,
  });

  factory PartnerTagResponse.fromJson(Map<String, dynamic> json) => PartnerTagResponse(
        partnerTag: json["tagName"],
        hexColor: json["tagHex"],
      );

  Map<String, dynamic> toJson() => {
        "partnerTag": partnerTag,
        "hexColor": hexColor,
      };
}

class PartnerResponse {
  String partnerName;
  String partnerLogoUrl;
  String partnerHexColor;
  bool activateLogo;

  PartnerResponse({
    required this.partnerName,
    required this.partnerLogoUrl,
    required this.partnerHexColor,
    required this.activateLogo,
  });

  factory PartnerResponse.fromJson(Map<String, dynamic> json) => PartnerResponse(
        partnerName: json["partnerName"],
        partnerLogoUrl: json["partnerLogo"],
        partnerHexColor: json["partnerHex"],
        activateLogo: json["partnerImageActivate"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "partnerName": partnerName,
        "partnerLogoUrl": partnerLogoUrl,
        "partnerHexColor": partnerHexColor,
        "activateLogo": activateLogo,
      };
}
