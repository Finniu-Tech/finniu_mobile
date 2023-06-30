import 'package:finniu/domain/entities/plan_entities.dart';

class PlanSimulation {
  final int initialAmount;
  final int months;
  final double? profitability;
  final PlanEntity? plan;
  final double? finalRentability;

  PlanSimulation({
    required this.initialAmount,
    required this.months,
    required this.profitability,
    required this.plan,
    required this.finalRentability,
  });
}
