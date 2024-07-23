import 'package:finniu/infrastructure/models/calculate_investment.dart';
import 'package:finniu/presentation/providers/calculate_investment_provider.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/animated_number.dart';
import 'package:finniu/presentation/screens/catalog/widgets/blue_gold_card/buttons_card.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InvestmentSimulationButton extends ConsumerWidget {
  const InvestmentSimulationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void toInvestPressed() {
      Navigator.of(context).pop();
    }

    void recalculatePressed() {
      Navigator.of(context).pop();
    }

    return ElevatedButton(
      onPressed: () => investmentSimulationModal(
        context,
        finalAmount: 9000,
        startingAmount: 8000,
        mouthInvestment: 6,
        toInvestPressed: toInvestPressed,
        recalculatePressed: recalculatePressed,
      ),
      child: const Text('modal invesrtion calculada'),
    );
  }
}

Future<dynamic> investmentSimulationModal(
  BuildContext context, {
  required int startingAmount,
  required int finalAmount,
  required int mouthInvestment,
  VoidCallback? toInvestPressed,
  VoidCallback? recalculatePressed,
}) async {
  showModalBottomSheet(
    context: context,
    builder: (context) => BodySimulation(
      startingAmount: startingAmount,
      mouthInvestment: mouthInvestment,
      toInvestPressed: toInvestPressed,
      recalculatePressed: recalculatePressed,
    ),
  );
}

class BodySimulation extends ConsumerWidget {
  const BodySimulation({
    super.key,
    required this.startingAmount,
    required this.mouthInvestment,
    this.toInvestPressed,
    this.recalculatePressed,
  });
  final int startingAmount;
  final int mouthInvestment;
  final VoidCallback? toInvestPressed;
  final VoidCallback? recalculatePressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff1A1A1A;
    const int backgroundLight = 0xffFFFFFF;
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(backgroundDark)
            : const Color(backgroundLight),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Stack(
        children: [
          Dialog(
            insetPadding: const EdgeInsets.all(20.0),
            backgroundColor: isDarkMode
                ? const Color(backgroundDark)
                : const Color(backgroundLight),
            child: BodyDialog(
              startingAmount: startingAmount,
              mouthInvestment: mouthInvestment,
              toInvestPressed: toInvestPressed,
              recalculatePressed: recalculatePressed,
            ),
          ),
          const CloseButtonModal(),
        ],
      ),
    );
  }
}

class BodyDialog extends ConsumerStatefulWidget {
  const BodyDialog({
    super.key,
    required this.startingAmount,
    required this.mouthInvestment,
    this.toInvestPressed,
    this.recalculatePressed,
  });

  final int startingAmount;
  final int mouthInvestment;

  final VoidCallback? toInvestPressed;
  final VoidCallback? recalculatePressed;

  @override
  ConsumerState<BodyDialog> createState() => _BodyDialogState();
}

class _BodyDialogState extends ConsumerState<BodyDialog> {
  @override
  Widget build(BuildContext context) {
    final isSoles = ref.watch(isSolesStateProvider);
    CalculatorInput calculatorInput = CalculatorInput(
      amount: widget.startingAmount,
      months: widget.mouthInvestment,
      currency: isSoles ? 'nuevo sol' : 'dolar',
    );
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final response =
        ref.watch(calculateInvestmentFutureProvider(calculatorInput));

    const int numberDark = 0xffFFFFFF;
    const int numberLight = 0xff000000;
    const int monthTextDark = 0xffA2E6FA;
    const int monthTextLight = 0xff44879F;
    const int returnDark = 0xff0D3A5C;
    const int returnLight = 0xffDFF7FF;

    return response.when(
      data: (data) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo_simulation${isDarkMode ? "_dark" : "_light"}.png",
              width: 75,
              height: 75,
              fit: BoxFit.fill,
            ),
            const TextPoppins(
              text: "Si comienzas con",
              fontSize: 16,
            ),
            AnimationNumber(
              beginNumber: 0,
              endNumber: widget.startingAmount,
              duration: 1,
              fontSize: 24,
              colorText: isDarkMode ? numberDark : numberLight,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const TextPoppins(
                  text: "En ",
                  fontSize: 24,
                  isBold: true,
                ),
                TextPoppins(
                  text: "${widget.mouthInvestment} meses ",
                  fontSize: 24,
                  isBold: true,
                  textDark: monthTextDark,
                  textLight: monthTextLight,
                ),
                const TextPoppins(
                  text: "recibirás 💸",
                  fontSize: 24,
                  isBold: true,
                ),
              ],
            ),
            Container(
              width: 287,
              height: 66,
              decoration: BoxDecoration(
                color: isDarkMode
                    ? const Color(returnDark)
                    : const Color(returnLight),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Center(
                child: AnimationNumber(
                  beginNumber: 1,
                  endNumber: data.profitability!.toInt(),
                  duration: 1,
                  fontSize: 24,
                  colorText: isDarkMode ? numberDark : numberLight,
                ),
              ),
            ),
            ButtonInvestment(
              text: "Quiero invertir",
              onPressed: widget.toInvestPressed,
            ),
            GestureDetector(
              onTap: widget.recalculatePressed,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 30,
                child: const Center(
                  child: TextPoppins(
                    text: "Volver a calcular",
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        );
      },
      loading: () {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo_simulation${isDarkMode ? "_dark" : "_light"}.png",
              width: 75,
              height: 75,
              fit: BoxFit.fill,
            ),
            const TextPoppins(
              text: "Si comienzas con",
              fontSize: 16,
            ),
            AnimationNumber(
              beginNumber: 0,
              endNumber: widget.startingAmount,
              duration: 1,
              fontSize: 24,
              colorText: isDarkMode ? numberDark : numberLight,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const TextPoppins(
                  text: "En ",
                  fontSize: 24,
                  isBold: true,
                ),
                TextPoppins(
                  text: "${widget.mouthInvestment} meses ",
                  fontSize: 24,
                  isBold: true,
                  textDark: monthTextDark,
                  textLight: monthTextLight,
                ),
                const TextPoppins(
                  text: "recibirás 💸",
                  fontSize: 24,
                  isBold: true,
                ),
              ],
            ),
            Container(
              width: 287,
              height: 66,
              decoration: BoxDecoration(
                color: isDarkMode
                    ? const Color(returnDark)
                    : const Color(returnLight),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: const Center(
                child: TextPoppins(
                  text: "Calculando...",
                  fontSize: 24,
                  textDark: numberDark,
                  textLight: numberLight,
                ),
              ),
            ),
            ButtonInvestment(
              text: "Quiero invertir",
              onPressed: widget.toInvestPressed,
            ),
            GestureDetector(
              onTap: widget.recalculatePressed,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 30,
                child: const Center(
                  child: TextPoppins(
                    text: "Volver a calcular",
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        );
      },
      error: (error, stack) => Text('Error: $error'),
    );
  }
}
