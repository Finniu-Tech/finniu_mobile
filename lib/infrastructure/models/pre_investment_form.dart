import 'package:finniu/infrastructure/models/re_investment/input_models.dart';

class PreInvestmentForm {
  String? uuid;
  int amount;
  // String bankAccountNumber;
  String? bankAccountSender;
  OriginFunds? originFunds;
  String deadLineUuid;
  String planUuid;
  String? coupon;
  String currency;
  int? months;

  PreInvestmentForm({
    required this.amount,
    // required this.bankAccountNumber,
    required this.bankAccountSender,
    this.originFunds,
    required this.deadLineUuid,
    required this.planUuid,
    required this.currency,
    this.coupon,
    this.uuid,
    this.months,
  });
}

const String currencyNuevoSol = 'nuevo sol';
const String currencyDollar = 'dolar';
