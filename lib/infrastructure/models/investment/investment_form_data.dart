import 'package:finniu/domain/entities/user_bank_account_entity.dart';

class InvestmentFormData {
  final int amount;
  final BankAccount? uuidBank;
  final int uuidDeadline;
  final String uuidPlan;
  final String currency;
  final String coupon;

  InvestmentFormData({
    required this.amount,
    required this.uuidBank,
    required this.uuidDeadline,
    required this.uuidPlan,
    required this.currency,
    required this.coupon,
  });

  InvestmentFormData copyWith({
    int? amount,
    BankAccount? uuidBank,
    int? uuidDeadline,
    String? uuidPlan,
    String? currency,
    String? coupon,
  }) {
    return InvestmentFormData(
      amount: amount ?? this.amount,
      uuidBank: uuidBank ?? this.uuidBank,
      uuidDeadline: uuidDeadline ?? this.uuidDeadline,
      uuidPlan: uuidPlan ?? this.uuidPlan,
      currency: currency ?? this.currency,
      coupon: coupon ?? this.coupon,
    );
  }
}
