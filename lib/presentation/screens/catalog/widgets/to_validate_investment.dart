import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/animated_number.dart';
import 'package:finniu/presentation/screens/catalog/widgets/progres_bar/slider_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ToValidateInvestment extends ConsumerWidget {
  final String dateEnds;
  final int amount;
  final bool? isReinvestment;
  const ToValidateInvestment({
    super.key,
    required this.dateEnds,
    required this.amount,
    this.isReinvestment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const backgroundLight = 0xffD6F6FF;
    const backgroundDark = 0xff08273F;
    return Stack(
      children: [
        Container(
          width: 336,
          height: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isDarkMode
                ? const Color(backgroundDark)
                : const Color(backgroundLight),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Column(
              children: [
                const SizedBox(
                  height: 2,
                ),
                AmountInvestment(
                  amount: amount,
                ),
                const SizedBox(height: 1),
                const SliderBar(
                  image: 'assets/images/money_bag.png',
                  toValidate: true,
                ),
                ValidationText(
                  isReinvestment: isReinvestment,
                ),
              ],
            ),
          ),
        ),
        const LabelState(
          label: "👀 En revisión",
        ),
      ],
    );
  }
}

class ValidationText extends ConsumerWidget {
  final bool? isReinvestment;
  const ValidationText({
    super.key,
    this.isReinvestment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int iconDark = 0xffA2E6FA;
    const int iconLight = 0xff0D3A5C;
    String text = isReinvestment == true
        ? 'Tu reinversión esta a la espera de que finalice la inversión previa'
        : 'Validación';
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 7,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(width: 2),
        Icon(
          Icons.help_outline,
          color: isDarkMode ? const Color(iconDark) : const Color(iconLight),
          size: 13,
        ),
      ],
    );
  }
}

class AmountInvestment extends ConsumerWidget {
  final int amount;
  const AmountInvestment({
    super.key,
    required this.amount,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int amountColorDark = 0xffA2E6FA;
    const int amountColorLight = 0xff0D3A5C;
    const int dividerAmountColor = 0xffA2E6FA;
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          Container(
            width: 4,
            height: 47,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(dividerAmountColor),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Inversión empresarial',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              AnimationNumber(
                beginNumber: 0,
                endNumber: amount,
                duration: 1,
                fontSize: 14,
                colorText: isDarkMode ? amountColorDark : amountColorLight,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LabelState extends ConsumerWidget {
  final String label;
  const LabelState({
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const labelLightContainer = 0xffA2E6FA;
    const labelDarkContainer = 0xff114E7C;
    const textDark = 0xffFFFFFF;
    const textLight = 0xff0D3A5C;
    return Positioned(
      right: 0,
      child: Container(
        height: 24,
        width: 95,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: isDarkMode
              ? const Color(labelDarkContainer)
              : const Color(labelLightContainer),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color:
                    isDarkMode ? const Color(textDark) : const Color(textLight),
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
