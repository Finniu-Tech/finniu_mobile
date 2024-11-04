class Investment {
  final String uuid;
  final int amount;
  final int? rentability;
  final String finishDateInvestment;
  final bool? isReinvestAvailable;
  final bool? isReinvestment;
  final String? actionStatus;
  final String? boucherImage;
  final bool isCapital;

  Investment({
    required this.uuid,
    required this.amount,
    required this.finishDateInvestment,
    this.rentability,
    this.isReinvestAvailable = false,
    this.isReinvestment = false,
    this.actionStatus,
    this.boucherImage,
    this.isCapital = false,
  });

  factory Investment.fromJson(Map<String, dynamic> json) {
    return Investment(
      uuid: json['uuid'],
      amount: _parseAmount(json['amount']),
      finishDateInvestment: json['finishDateInvestment'],
      isReinvestAvailable: json['reinvestmentAvailable'] ?? false,
      isReinvestment: json['isReInvestment'] ?? false,
      actionStatus: json['actionStatus'] ?? '',
      rentability: json['rentabilityAmmount'] == null
          ? null
          : _parseAmount(json['rentabilityAmmount']),
      boucherImage: json['boucherList']?[0]?['boucherImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'amount': amount.toString(),
      'finishDateInvestment': finishDateInvestment,
      'reinvestmentAvailable': isReinvestAvailable,
      'isReInvestment': isReinvestment,
      'actionStatus': actionStatus,
    };
  }

  static int _parseAmount(String amount) {
    try {
      double parsedDouble = double.parse(amount);
      int parsedDoublee = parsedDouble.toInt();
      return parsedDoublee;
    } catch (e) {
      throw FormatException("Invalid amount format: $amount");
    }
  }
}

class InvestmentCategory {
  final List<Investment> investmentPending;
  final List<Investment> investmentInCourse;
  final List<Investment> investmentFinished;
  final List<Investment> investmentInProcess;

  InvestmentCategory({
    required this.investmentPending,
    required this.investmentInCourse,
    required this.investmentFinished,
    required this.investmentInProcess,
  });

  factory InvestmentCategory.fromJson(Map<String, dynamic> json) {
    return InvestmentCategory(
      investmentPending: _parseInvestmentList(json['investmentPending']),
      investmentInCourse: _parseInvestmentList(json['invesmentInCourse']),
      investmentFinished: _parseInvestmentList(json['invesmentFinished']),
      investmentInProcess: _parseInvestmentList(json['invesmentInProcess']),
    );
  }

  static List<Investment> _parseInvestmentList(dynamic jsonList) {
    if (jsonList == null) return [];
    return (jsonList as List).map((item) => Investment.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'investmentPending': investmentPending.map((i) => i.toJson()).toList(),
      'invesmentInCourse': investmentInCourse.map((i) => i.toJson()).toList(),
      'invesmentFinished': investmentFinished.map((i) => i.toJson()).toList(),
      'invesmentInProcess': investmentInProcess.map((i) => i.toJson()).toList(),
    };
  }
}

class UserInfoAllInvestment {
  final InvestmentCategory investmentInSoles;
  final InvestmentCategory investmentInDolares;

  UserInfoAllInvestment({
    required this.investmentInSoles,
    required this.investmentInDolares,
  });

  factory UserInfoAllInvestment.fromJson(Map<String, dynamic> json) {
    return UserInfoAllInvestment(
      investmentInSoles: json['invesmentInSoles'] != null &&
              json['invesmentInSoles'].isNotEmpty
          ? InvestmentCategory.fromJson(json['invesmentInSoles'][0])
          : InvestmentCategory(
              investmentPending: [],
              investmentInCourse: [],
              investmentFinished: [],
              investmentInProcess: [],
            ),
      investmentInDolares: json['invesmentInDolares'] != null &&
              json['invesmentInDolares'].isNotEmpty
          ? InvestmentCategory.fromJson(json['invesmentInDolares'][0])
          : InvestmentCategory(
              investmentPending: [],
              investmentInCourse: [],
              investmentFinished: [],
              investmentInProcess: [],
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'invesmentInSoles': [investmentInSoles.toJson()],
      'invesmentInDolares': [investmentInDolares.toJson()],
    };
  }

  bool hasAnyInvestment() {
    return investmentInSoles.investmentPending.isNotEmpty ||
        investmentInSoles.investmentInCourse.isNotEmpty ||
        investmentInSoles.investmentFinished.isNotEmpty ||
        investmentInDolares.investmentPending.isNotEmpty ||
        investmentInDolares.investmentInCourse.isNotEmpty ||
        investmentInDolares.investmentFinished.isNotEmpty;
  }
}

class Data {
  final UserInfoAllInvestment userInfoAllInvestment;

  Data({
    required this.userInfoAllInvestment,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      userInfoAllInvestment:
          UserInfoAllInvestment.fromJson(json['userInfoAllInvestment']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userInfoAllInvestment': userInfoAllInvestment.toJson(),
    };
  }
}
