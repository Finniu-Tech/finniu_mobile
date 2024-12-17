import 'package:finniu/domain/entities/fund_entity.dart';
import 'package:finniu/domain/entities/user_bank_account_entity.dart';

class InvestmentDetailUuid {
  final String uuid;
  final int amount;
  final int month;
  final int rentabilityAmount;
  final int rentabilityPercent;
  final String startDateInvestment;
  final String finishDateInvestment;
  final String paymentCapitalDateInvestment;
  final String operationCode;
  final String? contract;
  final String? voucher;
  final BankAccount? bankAccountReceiver;
  final BankAccount? bankAccountSender;
  final List<ProfitabilityItem> profitabilityListMonth;
  final FundEntity? fund;
  final bool isReInvestment;
  final ReInvestmentInfo? reinvestmentInfo;

  InvestmentDetailUuid({
    required this.startDateInvestment,
    required this.operationCode,
    required this.uuid,
    required this.amount,
    required this.month,
    required this.rentabilityAmount,
    required this.rentabilityPercent,
    required this.finishDateInvestment,
    required this.profitabilityListMonth,
    required this.reinvestmentInfo,
    required this.paymentCapitalDateInvestment,
    this.contract,
    this.voucher,
    this.bankAccountReceiver,
    this.bankAccountSender,
    this.fund,
    this.isReInvestment = false,
  });

  factory InvestmentDetailUuid.fromJson(Map<String, dynamic> json) {
    return InvestmentDetailUuid(
      paymentCapitalDateInvestment: json['paymentCapitalDateInvestment'],
      startDateInvestment: json['startDateInvestment'],
      operationCode: json['operationCode'] ?? '',
      uuid: json['uuid'],
      amount: _parseAmount(json['amount']),
      month: json['deadline']['value'],
      rentabilityAmount: _parseAmount(json['rentabilityAmmount']),
      rentabilityPercent: _parseAmount(json['rentabilityPercent']),
      finishDateInvestment: json['finishDateInvestment'],
      contract: json['contract'],
      voucher: (json['boucherList'] as List<dynamic>).firstWhere(
        (item) =>
            item['boucherImage'] != null && item['boucherImage'].isNotEmpty,
        orElse: () => null,
      )?['boucherImage'],
      bankAccountReceiver: json['bankAccountReceiver'] != null
          ? BankAccount.fromJson(json['bankAccountReceiver'])
          : null,
      bankAccountSender: json['bankAccountSender'] != null
          ? BankAccount.fromJson(json['bankAccountSender'])
          : null,
      profitabilityListMonth: (json['paymentRentability'] as List<dynamic>)
          .map((item) => ProfitabilityItem.fromJson(item))
          .toList(),
      fund: json['investmentFund'] != null
          ? FundEntity.fromJson(json['investmentFund'])
          : null,
      isReInvestment: json['isReInvestment'] ?? false,
      reinvestmentInfo: ReInvestmentInfo.fromJson(json['reinvestmentInfo']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'amount': amount,
      'rentabilityAmmount': rentabilityAmount,
      'rentabilityPercent': rentabilityPercent,
      'finishDateInvestment': finishDateInvestment,
      'contract': contract,
      'voucher': voucher,
      'isReInvestment': isReInvestment,
    };
  }

  static int _parseAmount(String amount) {
    try {
      double parsedDouble = double.parse(amount);
      return parsedDouble.round();
    } catch (e) {
      return 0;
    }
  }
}

class ProfitabilityItem {
  final DateTime paymentDate;
  final int amount;
  final String? voucher;
  final int? numberPayment;
  final bool isPaid;

  ProfitabilityItem({
    required this.paymentDate,
    required this.amount,
    this.numberPayment,
    this.voucher,
    this.isPaid = false,
  });

  factory ProfitabilityItem.fromJson(Map<String, dynamic> json) {
    return ProfitabilityItem(
      paymentDate: DateTime.parse(json['paymentDate']),
      amount: InvestmentDetailUuid._parseAmount(json['amount']),
      numberPayment: json['numberPayment'],
      voucher: json['paymentVoucherUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'paymentDate': paymentDate.toIso8601String(),
      'amount': amount,
      'numberPayment': numberPayment,
      'voucher': voucher,
      'isPaid': isPaid,
    };
  }
}

class TablePayV4 {
  final double rentabilityAmount;
  final double rentabilityPercent;
  final double amount;
  final DateTime paymentCapitalDateInvestment;
  final BankAccount? bankAccountSender;
  final List<ProfitabilityItemV4> profitabilityListMonth;
  final String fundName;
  final String operationCode;

  TablePayV4({
    required this.rentabilityAmount,
    required this.rentabilityPercent,
    required this.amount,
    required this.paymentCapitalDateInvestment,
    required this.profitabilityListMonth,
    required this.bankAccountSender,
    required this.fundName,
    required this.operationCode,
  });

  factory TablePayV4.fromJson(Map<String, dynamic> json) {
    final investmentDetail = json['investmentDetail'];
    return TablePayV4(
      operationCode: investmentDetail['operationCode'],
      rentabilityAmount: double.parse(investmentDetail['rentabilityAmmount']),
      rentabilityPercent: double.parse(investmentDetail['rentabilityPercent']),
      amount: double.parse(investmentDetail['amount']),
      paymentCapitalDateInvestment:
          DateTime.parse(investmentDetail['paymentCapitalDateInvestment']),
      profitabilityListMonth: (investmentDetail['paymentRentability'] as List)
          .map((item) => ProfitabilityItemV4.fromJson(item))
          .toList(),
      bankAccountSender: investmentDetail['bankAccountReceiver'] != null
          ? BankAccount.fromJson(investmentDetail['bankAccountReceiver'])
          : null,
      fundName: investmentDetail['investmentFund']['name'],
    );
  }
}

class ProfitabilityItemV4 {
  final DateTime paymentDate;
  final double amount;
  final String? voucher;
  final int? numberPayment;
  final bool isCapitalPayment;
  final bool isActive;

  ProfitabilityItemV4({
    required this.paymentDate,
    required this.amount,
    this.numberPayment,
    this.voucher,
    required this.isCapitalPayment,
    required this.isActive,
  });

  factory ProfitabilityItemV4.fromJson(Map<String, dynamic> json) {
    return ProfitabilityItemV4(
      paymentDate: DateTime.parse(json['paymentDate']),
      amount: double.parse(json['amount']),
      numberPayment: json['numberPayment'],
      voucher: json['paymentVoucherUrl'],
      isCapitalPayment: json['isCapitalPayment'],
      isActive: json['isActive'] ?? false,
    );
  }
}

enum TypeReinvestmentEnum { capitalAditional, capitalOnly }

class ReInvestmentInfo {
  final TypeReinvestmentEnum? type;
  final int? investmentInitialAmount;
  final int? reinvestmentAditionalAmount;
  final String? startDate;
  final String? contractUrl;

  ReInvestmentInfo({
    this.type,
    this.investmentInitialAmount,
    this.reinvestmentAditionalAmount,
    this.startDate,
    this.contractUrl,
  });

  factory ReInvestmentInfo.fromJson(Map<String, dynamic> json) {
    return ReInvestmentInfo(
      type: _parseReinvestmentType(json['reinvestmentType']),
      investmentInitialAmount: json['investmentInitialAmount'],
      reinvestmentAditionalAmount: json['reinvestmentAditionalAmount'],
      startDate: json['startDate'],
      contractUrl: json['contractUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type?.toString().split('.').last,
      'investmentInitialAmount': investmentInitialAmount,
      'reinvestmentAditionalAmount': reinvestmentAditionalAmount,
      'startDate': startDate,
      'contractUrl': contractUrl,
    };
  }

  static TypeReinvestmentEnum? _parseReinvestmentType(String? type) {
    switch (type) {
      case 'CAPITAL_ADITIONAL':
        return TypeReinvestmentEnum.capitalAditional;
      case 'CAPITAL_ONLY':
        return TypeReinvestmentEnum.capitalOnly;
      default:
        return null;
    }
  }

  bool hasValidValues() {
    return type != null &&
        investmentInitialAmount != null &&
        reinvestmentAditionalAmount != null &&
        startDate != null &&
        contractUrl != null;
  }
}
