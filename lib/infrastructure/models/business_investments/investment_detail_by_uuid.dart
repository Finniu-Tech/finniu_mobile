import 'package:finniu/domain/entities/user_bank_account_entity.dart';

class InvestmentDetailUuid {
  final String uuid;
  final int amount;
  final int month;
  final int rentabilityAmount;
  final int rentabilityPercent;
  final String finishDateInvestment;
  final String? contract;
  final String? voucher;
  final BankAccount? bankAccountReceiver;
  final BankAccount? bankAccountSender;

  InvestmentDetailUuid({
    required this.uuid,
    required this.amount,
    required this.month,
    required this.rentabilityAmount,
    required this.rentabilityPercent,
    required this.finishDateInvestment,
    this.contract,
    this.voucher,
    this.bankAccountReceiver,
    this.bankAccountSender,
  })  : assert(uuid.isNotEmpty, 'UUID cannot be null or empty'),
        assert(
          finishDateInvestment.isNotEmpty,
          'Finish date investment cannot be null or empty',
        );

  factory InvestmentDetailUuid.fromJson(Map<String, dynamic> json) {
    return InvestmentDetailUuid(
      uuid: json['uuid'],
      amount: _parseAmount(json['amount']),
      month: json['deadline']['value'],
      voucher: (json['boucherList'] as List<dynamic>).isNotEmpty
          ? json['boucherList'][0]["boucherImage"]
          : null,
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
    double parsedDouble = double.parse(amount);
    if (parsedDouble == parsedDouble.toInt()) {
      return parsedDouble.toInt();
    } else {
      throw FormatException("Invalid amount format: $amount");
    }
  }
}
