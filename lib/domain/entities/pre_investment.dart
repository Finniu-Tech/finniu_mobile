import 'package:finniu/infrastructure/models/re_investment/input_models.dart';

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
  String deadLineUuid;
  String planUuid;
  String? coupon;
  String? bankAccountSender;
  OriginFunds? originFunds;

  PreInvestmentEntity({
    required this.uuid,
    required this.amount,
    // required this.bankAccountNumber,
    required this.deadLineUuid,
    required this.planUuid,
    required this.bankAccountSender,
    required this.originFunds,
    this.coupon,
  });

  PreInvestmentEntity copyWith({
    String? uuid,
    int? amount,
    // String? bankAccountNumber,
    String? deadLineUuid,
    String? planUuid,
    String? coupon,
    String? bankAccountSender,
    OriginFunds? originFunds,
  }) {
    return PreInvestmentEntity(
      uuid: uuid ?? this.uuid,
      amount: amount ?? this.amount,
      // bankAccountNumber: bankAccountNumber ?? this.bankAccountNumber,
      deadLineUuid: deadLineUuid ?? this.deadLineUuid,
      planUuid: planUuid ?? this.planUuid,
      coupon: coupon ?? this.coupon,
      bankAccountSender: bankAccountSender ?? this.bankAccountSender,
      originFunds: originFunds ?? this.originFunds,
    );
  }
}
