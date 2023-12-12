class PreInvestmentResponseAPI {
  PreInvestmentEntity? preInvestment;
  String? error;
  bool success = false;

  PreInvestmentResponseAPI({
    this.preInvestment,
    this.error,
    this.success = false,
  });
}

class PreInvestmentUpdateResponseAPI {
  String? error;
  bool success = false;

  PreInvestmentUpdateResponseAPI({
    this.error,
    this.success = false,
  });
}

class PreInvestmentEntity {
  String uuid;
  int amount;
  // String bankAccountNumber;
  String bankAccountTypeUuid;
  String deadLineUuid;
  String planUuid;
  String? coupon;

  PreInvestmentEntity({
    required this.uuid,
    required this.amount,
    // required this.bankAccountNumber,
    required this.bankAccountTypeUuid,
    required this.deadLineUuid,
    required this.planUuid,
    this.coupon,
  });

  PreInvestmentEntity copyWith({
    String? uuid,
    int? amount,
    // String? bankAccountNumber,
    String? bankAccountTypeUuid,
    String? deadLineUuid,
    String? planUuid,
    String? coupon,
  }) {
    return PreInvestmentEntity(
      uuid: uuid ?? this.uuid,
      amount: amount ?? this.amount,
      // bankAccountNumber: bankAccountNumber ?? this.bankAccountNumber,
      bankAccountTypeUuid: bankAccountTypeUuid ?? this.bankAccountTypeUuid,
      deadLineUuid: deadLineUuid ?? this.deadLineUuid,
      planUuid: planUuid ?? this.planUuid,
      coupon: coupon ?? this.coupon,
    );
  }
}
