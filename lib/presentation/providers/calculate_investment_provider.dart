import 'package:finniu/domain/entities/calculate_investment.dart';
import 'package:finniu/infrastructure/models/calculate_investment.dart';
import 'package:finniu/presentation/providers/calculate_investment_repository_provider.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/recovery_password_repository_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final calculateInvestmentFutureProvider = FutureProvider.autoDispose
    .family<PlanSimulation, CalculatorInput>(
        (ref, CalculatorInput calculatorInput) async {
  try {
    final calculateInvestmentRepository =
        ref.read(calculateInvestmentRepositoryProvider);
    final client = ref.watch(gqlClientProvider).value;
    final result = await calculateInvestmentRepository.calculate(
        client: client!,
        amount: calculatorInput.amount,
        months: calculatorInput.months,
        coupon: calculatorInput.coupon,
        currency: calculatorInput.currency);
    return result;
  } catch (e, stack) {
    return Future.error('Error: $e', stack);
  }
});

