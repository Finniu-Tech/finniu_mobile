import 'package:finniu/domain/entities/dead_line.dart';
import 'package:finniu/domain/entities/user_bank_account_entity.dart';

class InvestmentFormData {
  final int amount;
  final BankAccount? bankAccount;
  final DeadLineEntity? deadline;
  final String uuidPlan;
  final String currency;
  final String coupon;

  InvestmentFormData({
    required this.amount,
    required this.bankAccount,
    required this.deadline,
    required this.uuidPlan,
    required this.currency,
    required this.coupon,
  });

  InvestmentFormData copyWith({
    int? amount,
    BankAccount? bankAccount,
    DeadLineEntity? deadline,
    String? uuidPlan,
    String? currency,
    String? coupon,
  }) {
    return InvestmentFormData(
      amount: amount ?? this.amount,
      bankAccount: bankAccount ?? this.bankAccount,
      deadline: deadline ?? this.deadline,
      uuidPlan: uuidPlan ?? this.uuidPlan,
      currency: currency ?? this.currency,
      coupon: coupon ?? this.coupon,
    );
  }
}
