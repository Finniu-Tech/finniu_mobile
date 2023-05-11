class PreInvestmentForm {
  int amount;
  // String bankAccountNumber;
  String bankAccountTypeUuid;
  String deadLineUuid;
  String planUuid;
  String? coupon;

  PreInvestmentForm({
    required this.amount,
    // required this.bankAccountNumber,
    required this.bankAccountTypeUuid,
    required this.deadLineUuid,
    required this.planUuid,
    this.coupon,
  });
}
