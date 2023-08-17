class PreInvestmentForm {
  int amount;
  // String bankAccountNumber;
  String bankAccountTypeUuid;
  String deadLineUuid;
  String planUuid;
  String? coupon;
  String currency;

  PreInvestmentForm({
    required this.amount,
    // required this.bankAccountNumber,
    required this.bankAccountTypeUuid,
    required this.deadLineUuid,
    required this.planUuid,
    required this.currency,
    this.coupon,
  });
}

const String currencyNuevoSol = 'nuevo sol';
const String currencyDollar = 'dolar';
