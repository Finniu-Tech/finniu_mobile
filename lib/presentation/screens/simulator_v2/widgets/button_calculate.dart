import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/v2_simulator_slider_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/investment_simulation.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
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
    final defaultCorporateFund = ref.watch(defaultCorporateFundProvider);

    void toInvestPressed() {
      ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
        eventName: FirebaseAnalyticsEvents.navigateTo,
        parameters: {
          "screen": FirebaseScreen.simulatorV2,
          "currency": isSoles ? "dollar" : "soles",
          "navigate_to": FirebaseScreen.investmentStep1V2,
          'deadLine': '${months.getMonthValue()} meses',
          "amount": amount.toString(),
        },
      );
      Navigator.pushNamed(
        context,
        '/v2/investment/step-1',
        arguments: {
          'fund': defaultCorporateFund,
          'amount': amount,
          'deadLine': '${months.getMonthValue()} meses',
        },
      );
    }

    void recalculatePressed() {
      ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
        eventName: FirebaseAnalyticsEvents.clickEvent,
        parameters: {
          "screen": FirebaseScreen.simulatorV2,
          "currency": isSoles ? "dollar" : "soles",
          "recalculate": "recalculate_simulation",
        },
      );
      Navigator.of(context).pop();
    }

    Future<void> calculatePressed() async {
      if (amount < 1000) {
        showSnackBarV2(
          context: context,
          title: "Error en el monto",
          message:
              "Por favor, ingresa un monto mayor a ${isSoles ? "S/" : "\$"}1.000",
          snackType: SnackType.warning,
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
