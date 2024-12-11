import 'package:finniu/domain/entities/fund_entity.dart';
import 'package:finniu/domain/entities/user_bank_account_entity.dart';

class InvestmentDetailUuid {
  final String uuid;
  final int amount;
  final int month;
  final int rentabilityAmount;
  final int rentabilityPercent;
  final String finishDateInvestment;
  final String operationCode;
  final String? contract;
  final String? voucher;
  final BankAccount? bankAccountReceiver;
  final BankAccount? bankAccountSender;
  final List<ProfitabilityItem> profitabilityListMonth;
  final FundEntity? fund;
  final bool? isReInvestment;

  InvestmentDetailUuid({
    required this.operationCode,
    required this.uuid,
    required this.amount,
    required this.month,
    required this.rentabilityAmount,
    required this.rentabilityPercent,
    required this.finishDateInvestment,
    required this.profitabilityListMonth,
    this.contract,
    this.voucher,
    this.bankAccountReceiver,
    this.bankAccountSender,
    this.fund,
    this.isReInvestment,
  })  : assert(uuid.isNotEmpty, 'UUID cannot be null or empty'),
        assert(
          finishDateInvestment.isNotEmpty,
          'Finish date investment cannot be null or empty',
        );

  factory InvestmentDetailUuid.fromJson(Map<String, dynamic> json) {
    return InvestmentDetailUuid(
      operationCode: json['operationCode'],
      uuid: json['uuid'],
      amount: _parseAmount(json['amount']),
      month: json['deadline']['value'],
      voucher: (json['boucherList'] as List<dynamic>).firstWhere(
        (item) =>
            item['boucherImage'] != null && item['boucherImage'].isNotEmpty,
        orElse: () => null,
      )?['boucherImage'],
      rentabilityAmount: _parseAmount(json['rentabilityAmmount']),
      rentabilityPercent: _parseAmount(json['rentabilityPercent']),
      finishDateInvestment: json['finishDateInvestment'],
      contract: json['contract'],
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
    };
  }

  static int _parseAmount(String amount) {
    try {
      double parsedDouble = double.parse(amount);
      int amountParse = parsedDouble.round();
      return amountParse;
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
    required this.numberPayment,
    this.voucher,
    this.isPaid = false,
  });

  factory ProfitabilityItem.fromJson(Map<String, dynamic> json) {
    return ProfitabilityItem(
      paymentDate: DateTime.parse(json['paymentDate']),
      amount: _parseAmount(json['amount']),
      numberPayment: json['numberPayment'],
      voucher: json['paymentVoucherUrl'],
    );
  }

  static int _parseAmount(String amount) {
    try {
      double parsedDouble = double.parse(amount);
      int amountParse = parsedDouble.round();
      return amountParse;
    } catch (e) {
      return 0;
    }
  }
}
