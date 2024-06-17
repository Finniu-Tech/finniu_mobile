import 'package:finniu/domain/entities/plan_entities.dart';

class PlanSimulation {
  final int initialAmount;
  final int months;
  final double? profitability;
  final PlanEntity? plan;
  final double? finalRentability;
  final String? error;
  final String? endDate;
  final String? startDate;

  PlanSimulation({
    required this.initialAmount,
    required this.months,
    required this.profitability,
    required this.plan,
    required this.finalRentability,
    required this.endDate,
    required this.startDate,
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

String translateMonthToSpanish(String date) {
  Map<String, String> months = {
    'January': 'Enero',
    'February': 'Febrero',
    'March': 'Marzo',
    'April': 'Abril',
    'May': 'Mayo',
    'June': 'Junio',
    'July': 'Julio',
    'August': 'Agosto',
    'September': 'Septiembre',
    'October': 'Octubre',
    'November': 'Noviembre',
    'December': 'Diciembre',
  };

  months.forEach((key, value) {
    date = date.replaceAll(key, value);
  });

  return date;
}
