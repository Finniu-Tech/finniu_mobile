import 'package:equatable/equatable.dart';

class CalculatorInput extends Equatable {
  final int amount;
  final int months;

  const CalculatorInput({
    required this.amount,
    required this.months,
  });

  @override
  List<Object?> get props => [amount, months];
}
