import 'package:equatable/equatable.dart';

class CalculatorInput extends Equatable {
  final int amount;
  final int months;
  final String? coupon;

  const CalculatorInput({
    required this.amount,
    required this.months,
    this.coupon,
  });

  @override
  List<Object?> get props => [amount, months];
}
