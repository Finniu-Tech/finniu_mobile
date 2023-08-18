import 'package:equatable/equatable.dart';

class CalculatorInput extends Equatable {
  final int amount;
  final int months;
  final String currency;
  final String? coupon;

  const CalculatorInput({
    required this.amount,
    required this.months,
    required this.currency,
    this.coupon,
  });

  @override
  List<Object?> get props => [amount, months];
}
