import 'package:finniu/constants/colors.dart';
import 'package:finniu/constants/number_format.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RealStateContainer extends HookConsumerWidget {
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
    final isAmountRender = useState(true);
    int changeDark = isSoles ? 0xff204F72 : 0xff2A9BBA;
    int changeLight = isSoles ? 0xff8EE6FF : 0xffFFD9B3;
    int containerDark = isSoles ? 0xff0D3A5C : 0xff00799C;
    int containerLight = isSoles ? 0xffBBF0FF : 0xffFFEEDD;

    return Container(
      width: 336,
      height: 121,
      decoration: BoxDecoration(
        color: isDarkMode ? Color(containerDark) : Color(containerLight),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  titleText,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                GestureDetector(
                  onTap: () {
                    isAmountRender.value = !isAmountRender.value;
                  },
                  child: SvgPicture.asset(
                    'assets/svg_icons/${isAmountRender.value ? 'alert_circle' : "close_x_icon"}.svg',
                    color: isDarkMode ? Colors.white : Colors.black,
                    width: 25,
                    height: 25,
                  ),
                ),
              ],
            ),
            isAmountRender.value
                ? Center(
                    child: TweenAnimationBuilder(
                      tween: IntTween(
                        begin: 0,
                        end: minAmount.toInt(),
                      ),
                      duration: const Duration(seconds: 1),
                      builder:
                          (BuildContext context, int value, Widget? child) {
                        return Text(
                          isSoles
                              ? formatterSoles.format(value)
                              : formatterUSD.format(value),
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        );
                      },
                    ),
                  )
                : Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 270,
                      height: 60,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color:
                            isDarkMode ? Color(changeDark) : Color(changeLight),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const TextPoppins(
                        text:
                            "¡Ahora nuestras tasas se ajustan inteligentemente según el monto y el plazo que elijas para invertir en la plataforma!",
                        fontSize: 10,
                        lines: 3,
                        align: TextAlign.end,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class BlueGoldContainer extends HookConsumerWidget {
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
        color: isDarkMode
            ? const Color(containerBlueGoldDark)
            : const Color(containerBlueGoldLight),
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
