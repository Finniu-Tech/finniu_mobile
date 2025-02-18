import 'package:finniu/domain/entities/calculate_investment.dart';
import 'package:finniu/infrastructure/models/calculate_investment.dart';
import 'package:finniu/presentation/providers/calculate_investment_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<PlanSimulation> pushCupon({
  required CalculatorInput inputCalculator,
  required WidgetRef ref,
  required BuildContext context,
}) async {
  final planSimulation = await ref.read(
    calculateInvestmentFutureProvider(
      inputCalculator,
    ).future,
  );
  return planSimulation;
}
