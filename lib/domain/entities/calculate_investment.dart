import 'package:finniu/domain/entities/plan_entities.dart';
import 'package:finniu/utils/translate_month_to_spanish.dart';

class PlanSimulation {
  final int initialAmount;
  final int months;
  final double? profitability;
  final PlanEntity? plan;
  final double? finalRentability;
  final String? error;
  final String? endDate;
  final String? startDate;
  final double? rentabilityPerMonth;

  PlanSimulation({
    required this.initialAmount,
    required this.months,
    required this.profitability,
    required this.plan,
    required this.finalRentability,
    required this.endDate,
    required this.startDate,
    required this.rentabilityPerMonth,
    this.error,
  });

  String getEndDateInSpanish() {
    if (endDate != null) {
      return translateMonthToSpanish(endDate!);
    } else {
      return 'N/A';
    }
  }

  String getStartDateInSpanish() {
    if (startDate != null) {
      return translateMonthToSpanish(startDate!);
    } else {
      return 'N/A';
    }
  }
}
