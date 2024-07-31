import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/v2_simulator_slider_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/investment_simulation.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/widgets/snackbar.dart';
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
    final isSoles = ref.watch(isSolesStateProvider);
    void toInvestPressed() {
      Navigator.pushNamed(context, '/v2/investment');
    }

    void recalculatePressed() {
      Navigator.of(context).pop();
    }

    Future<void> calculatePressed() async {
      if (amount < 1000) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 1),
            backgroundColor: Colors.transparent.withOpacity(0),
            content: SnackBarBody(
              message: 'Por favor, ingresa un monto mayor a ${isSoles ? "S/" : "\$"}1.000',
              type: "error",
              onDismiss: () {},
            ),
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
