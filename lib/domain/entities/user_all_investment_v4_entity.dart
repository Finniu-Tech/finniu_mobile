import 'package:finniu/infrastructure/models/business_investments/investment_detail_by_uuid.dart';

class InvestmentV4 {
  final String uuid;
  final int amount;
  final int? rentability;
  final String finishDateInvestment;
  final bool? isReinvestAvailable;
  final bool? isReinvestment;
  final String? actionStatus;
  final String? boucherImage;
  final String? fundName;
  final String? fundUuid;
  final bool isCapital;
  final List<ProfitabilityItem> paymentRentability;

  InvestmentV4({
    required this.uuid,
    required this.amount,
    required this.finishDateInvestment,
    required this.paymentRentability,
    this.fundUuid,
    this.rentability,
    this.isReinvestAvailable = false,
    this.isReinvestment = false,
    this.actionStatus,
    this.boucherImage,
    this.fundName,
    this.isCapital = true,
  });

  factory InvestmentV4.fromJson(Map<String, dynamic> json) {
    return InvestmentV4(
      paymentRentability: json['paymentRentability'] == null
          ? []
          : (json['paymentRentability'] as List<dynamic>)
              .map((item) => ProfitabilityItem.fromJson(item))
              .toList(),
      uuid: json['uuid'],
      amount: _parseAmount(json['amount']),
      finishDateInvestment: json['finishDateInvestment'],
      isReinvestAvailable: json['reinvestmentAvailable'] ?? false,
      isReinvestment: json['isReInvestment'] ?? false,
      actionStatus: json['actionStatus'] ?? '',
      rentability: json['rentabilityAmmount'] != null
          ? _parseAmount(json['rentabilityAmmount'])
          : json['rentabilityPercent'] != null
              ? double.parse(json['rentabilityPercent']).toInt()
              : null,
      boucherImage: json['boucherList'] == null
          ? null
          : (json['boucherList'] as List).firstWhere(
              (item) =>
                  item['boucherImage'] != null && item['boucherImage'] != "",
              orElse: () => null,
            )?['boucherImage'],
      fundName: json['investmentFund']?['name'],
      fundUuid: json['investmentFund']?['uuid'],
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
      'boucherImage': boucherImage,
      'fundName': fundName,
    };
  }

  static int _parseAmount(String amount) {
    try {
      return double.parse(amount).toInt();
    } catch (e) {
      throw FormatException("Invalid amount format: $amount");
    }
  }
}

class InvestmentCategoryV4 {
  final List<InvestmentV4> investmentInCourse;
  final List<InvestmentV4> investmentFinished;
  final List<InvestmentV4> investmentInProcess;

  InvestmentCategoryV4({
    required this.investmentInCourse,
    required this.investmentFinished,
    required this.investmentInProcess,
  });

  factory InvestmentCategoryV4.fromJson(Map<String, dynamic> json) {
    return InvestmentCategoryV4(
      investmentInCourse: _parseInvestmentList(json['invesmentInCourse']),
      investmentFinished: _parseInvestmentList(json['invesmentFinished']),
      investmentInProcess: _parseInvestmentList(json['invesmentInProcess']),
    );
  }

  static List<InvestmentV4> _parseInvestmentList(dynamic jsonList) {
    if (jsonList == null) return [];
    return (jsonList as List)
        .map((item) => InvestmentV4.fromJson(item))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'invesmentInCourse': investmentInCourse.map((i) => i.toJson()).toList(),
      'invesmentFinished': investmentFinished.map((i) => i.toJson()).toList(),
      'invesmentInProcess': investmentInProcess.map((i) => i.toJson()).toList(),
    };
  }
}

class UserInfoAllInvestmentV4 {
  final InvestmentCategoryV4 investmentInSoles;
  final InvestmentCategoryV4 investmentInDolares;

  UserInfoAllInvestmentV4({
    required this.investmentInSoles,
    required this.investmentInDolares,
  });

  factory UserInfoAllInvestmentV4.fromJson(Map<String, dynamic> json) {
    return UserInfoAllInvestmentV4(
      investmentInSoles: json['invesmentInSoles'] != null &&
              json['invesmentInSoles'].isNotEmpty
          ? InvestmentCategoryV4.fromJson(json['invesmentInSoles'][0])
          : InvestmentCategoryV4(
              investmentInCourse: [],
              investmentFinished: [],
              investmentInProcess: [],
            ),
      investmentInDolares: json['invesmentInDolares'] != null &&
              json['invesmentInDolares'].isNotEmpty
          ? InvestmentCategoryV4.fromJson(json['invesmentInDolares'][0])
          : InvestmentCategoryV4(
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
    return investmentInSoles.investmentInCourse.isNotEmpty ||
        investmentInSoles.investmentFinished.isNotEmpty ||
        investmentInDolares.investmentInCourse.isNotEmpty ||
        investmentInDolares.investmentFinished.isNotEmpty;
  }
}
