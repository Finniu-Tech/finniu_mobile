class typeReinvestmentEnum {
  static const String CAPITAL_ADITIONAL = 'CAPITAL_ADITIONAL';
  static const String CAPITAL_ONLY = 'CAPITAL_ONLY';
}

class currencyEnum {
  static const String USD = 'dolar';
  static const String PEN = 'nuevo sol';
}

class ReInvestmentEntity {
  final String id;
  final String contractURL;
  final int finalAmount;
  final String currency;
  final String deadlineUUID;
  final String? coupon;
  final String originFounds;
  final String? otherOriginFounds;
  final String typeReinvestment;
  final String bankAccountSenderUUID;
  late String bankAccountReceiverUUID;
  late List<String> vouchers;
  late bool userAcceptTerms;

  ReInvestmentEntity({
    required this.id,
    required this.contractURL,
    required this.finalAmount,
    required this.currency,
    required this.deadlineUUID,
    this.coupon,
    required this.originFounds,
    this.otherOriginFounds,
    required this.typeReinvestment,
    required this.bankAccountSenderUUID,
  });
}
