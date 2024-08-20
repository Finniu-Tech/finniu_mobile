import 'package:finniu/constants/colors.dart';
import 'package:finniu/constants/number_format.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RealStateContainer extends ConsumerWidget {
  final num minAmount;
  const RealStateContainer({
    super.key,
    required this.minAmount,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final isSoles = ref.watch(isSolesStateProvider);
    // const int numberInSoles = 1000;
    // const int numberInUSD = 1500;
    const String titleText = "Puedes comenzar a Invertir desde";
    return Container(
      width: 336,
      height: 121,
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(containerRealStateDark) : const Color(containerRealStateLight),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              titleText,
              style:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black),
              textAlign: TextAlign.left,
            ),
            Center(
              child: TweenAnimationBuilder(
                tween: IntTween(
                  begin: 0,
                  end: minAmount.toInt(),
                ),
                duration: const Duration(seconds: 1),
                builder: (BuildContext context, int value, Widget? child) {
                  return Text(
                    isSoles ? formatterSoles.format(value) : formatterUSD.format(value),
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlueGoldContainer extends ConsumerWidget {
  final String amount;
  const BlueGoldContainer({
    super.key,
    required this.amount,
  });

  int parseCurrencyToInt(String currencyString) {
    final cleanedString = currencyString.replaceAll(RegExp(r'[^\d.]'), '');

    double value = double.parse(cleanedString);

    return value.toInt();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    int numberInSoles = parseCurrencyToInt(amount);
    const String titleText = "Montos de inversión";
    const String bodyText = "Desde";

    return Container(
      width: 336,
      height: 121,
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(containerBlueGoldDark) : const Color(containerBlueGoldLight),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              titleText,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  bodyText,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                TweenAnimationBuilder(
                  tween: IntTween(
                    begin: 0,
                    end: numberInSoles,
                  ),
                  duration: const Duration(seconds: 1),
                  builder: (BuildContext context, int value, Widget? child) {
                    return Text(
                      formatterSoles.format(value),
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.end,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
