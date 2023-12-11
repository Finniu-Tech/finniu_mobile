class PreInvestmentForm {
  String? uuid;
  int amount;
  // String bankAccountNumber;
  String bankAccountTypeUuid;
  String deadLineUuid;
  String planUuid;
  String? coupon;
  String currency;
  int? months;

  PreInvestmentForm({
    required this.amount,
    // required this.bankAccountNumber,
    required this.bankAccountTypeUuid,
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
