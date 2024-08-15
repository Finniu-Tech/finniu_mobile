// lib/models/investment_fund.dart
class FundTypeSlugEnum {
  static const String aggro = 'agro_real_state_funds';
  static const String corporate = 'corporate_investment_funds';
}

class LastOperationFund {
  final String name;
  final String uuid;
  final String fundTypeSlug;

  LastOperationFund({required this.name, required this.uuid, required this.fundTypeSlug});

  factory LastOperationFund.fromJson(Map<String, dynamic> json) {
    return LastOperationFund(
      name: json['name'],
      uuid: json['uuid'],
      fundTypeSlug: json['fundType'],
    );
  }
}

class LastOperationAggroInvestment {
  final String investmentFundName;
  final String uuid;
  final double parcelAmount;
  final int parcelNumber;
  final int numberOfInstallments;
  final double parcelMonthlyInstallment;

  LastOperationAggroInvestment({
    required this.investmentFundName,
    required this.uuid,
    required this.parcelAmount,
    required this.parcelNumber,
    required this.numberOfInstallments,
    required this.parcelMonthlyInstallment,
  });

  factory LastOperationAggroInvestment.fromJson(Map<String, dynamic> json) {
    return LastOperationAggroInvestment(
      investmentFundName: json['investmentFundName'],
      uuid: json['uuid'],
      parcelAmount: num.parse(json['parcelAmount'] ?? '0').toDouble(),
      parcelNumber: num.parse(json['parcelNumber'] ?? '0').toInt(),
      // numberOfInstallments: json['numberOfInstallments'],
      numberOfInstallments: num.parse(json['numberOfInstallments'] ?? '0').toInt(),
      // parcelMonthlyInstallment: json['parcelMonthlyInstallment'],
      parcelMonthlyInstallment: num.parse(json['parcelMonthlyInstallment'] ?? '0').toDouble(),
    );
  }
}

// lib/models/pre_investment.dart
class LastOperationEnterprisePreInvestment {
  final String uuidPreInvestment;
  final double amount;
  final String status;
  final String actionStatus;
  final String currency;
  final int? rentability;
  final int deadline;
  final bool isReInvestment;

  LastOperationEnterprisePreInvestment({
    required this.uuidPreInvestment,
    required this.amount,
    required this.status,
    required this.actionStatus,
    required this.currency,
    required this.rentability,
    required this.deadline,
    required this.isReInvestment,
  });

  factory LastOperationEnterprisePreInvestment.fromJson(Map<String, dynamic> json) {
    return LastOperationEnterprisePreInvestment(
      uuidPreInvestment: json['uuidPreInvestment'],
      // amount: json['amount'] ,
      amount: num.parse(json['amount'] ?? '0').toDouble(),
      status: json['status'],
      actionStatus: json['actionStatus'],
      currency: json['currency'],
      // rentability: json['rentability'],
      rentability: parseRentability(json['rentability']),
      // deadline: json['deadline'] ,
      deadline: num.parse(json['deadline'] ?? '0').toInt(),
      isReInvestment: json['isReInvestment'] ?? false,
    );
  }
  static int? parseRentability(String? rentability) {
    try {
      return num.parse(rentability ?? '0').toInt();
    } catch (e) {
      return null;
    }
  }
}

// lib/models/last_operation.dart
class LastOperation {
  final LastOperationFund investmentFund;
  final String typeInvestment;
  final LastOperationAggroInvestment? aggroInvestment;
  final LastOperationEnterprisePreInvestment? enterprisePreInvestment;

  LastOperation({
    required this.investmentFund,
    required this.typeInvestment,
    this.aggroInvestment,
    this.enterprisePreInvestment,
  });

  factory LastOperation.fromJson(Map<String, dynamic> json) {
    return LastOperation(
      investmentFund: LastOperationFund.fromJson(json['investmentFund']),
      typeInvestment: json['typeInvestment'],
      aggroInvestment:
          json['agroInvestment'] != null ? LastOperationAggroInvestment.fromJson(json['agroInvestment']) : null,
      enterprisePreInvestment:
          json['preInvestment'] != null ? LastOperationEnterprisePreInvestment.fromJson(json['preInvestment']) : null,
    );
  }

  static filterByReInvestmentOperations(List<LastOperation> lastOperations) {
    // this method is used to filter last operations by draft, in process and in course
    if (lastOperations.isEmpty) {
      return [];
    }
    return lastOperations.where((element) => element.enterprisePreInvestment?.isReInvestment == false).toList();
  }
}

class EnterprisePreOperationEntity {
  final String fundUUID;
  final String fundName;
  final String investmentUUID;
  final String amount;
  final String currency;
  final String months;
  final String rentability;
  final String status;
  final bool isReInvestment;

  EnterprisePreOperationEntity({
    required this.fundUUID,
    required this.fundName,
    required this.investmentUUID,
    required this.amount,
    required this.currency,
    required this.months,
    required this.rentability,
    required this.status,
    required this.isReInvestment,
  });
}
