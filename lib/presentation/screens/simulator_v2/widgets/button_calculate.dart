import 'package:finniu/presentation/providers/v2_simulator_slider_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/investment_simulation.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ButtonCalculate extends ConsumerWidget {
  const ButtonCalculate({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final months = ref.watch(sliderValueProvider);
    final amount = ref.watch(amountValueProvider);
    void toInvestPressed() {
      Navigator.of(context).pop();
    }

    void recalculatePressed() {
      Navigator.of(context).pop();
    }

    Future<void> calculatePressed() async {
      if (amount <= 499) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Por favor, ingresa un monto mayor a \$500'),
          ),
        );
      } else {
        investmentSimulationModal(
          context,
          finalAmount: 1,
          startingAmount: amount,
          mouthInvestment: months.getMonthValue(),
          toInvestPressed: toInvestPressed,
          recalculatePressed: recalculatePressed,
        );
      }
    }

    return Center(
      child: ButtonInvestment(text: "Calcular", onPressed: calculatePressed),
    );
  }
}
