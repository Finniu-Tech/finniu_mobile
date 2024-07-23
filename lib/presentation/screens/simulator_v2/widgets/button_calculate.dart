import 'package:finniu/infrastructure/models/calculate_investment.dart';
import 'package:finniu/presentation/providers/calculate_investment_provider.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/v2_simulator_slider_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ButtonCalculate extends ConsumerWidget {
  const ButtonCalculate({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSoles = ref.watch(isSolesStateProvider);
    final months = ref.watch(sliderValueProvider);
    final amount = ref.watch(amountValueProvider);
    String currency = isSoles ? 'nuevo sol' : 'dolar';

    Future<void> calculatePressed() async {
      CalculatorInput calculatorInput = CalculatorInput(
        amount: amount,
        months: months.getMonthValue(),
        currency: isSoles ? 'nuevo sol' : 'dolar',
      );
      final future =
          ref.read(calculateInvestmentFutureProvider(calculatorInput));
      try {
        final result = future;
        print('Resultado del cálculo: $result');
      } catch (e) {
        print('Error: $e');
      }
    }

    return Center(
      child: ButtonInvestment(text: "Calcular", onPressed: calculatePressed),
    );
  }
}
