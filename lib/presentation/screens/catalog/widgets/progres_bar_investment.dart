import 'package:finniu/domain/entities/investment_rentability_report_entity.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/animated_number.dart';
import 'package:finniu/presentation/screens/catalog/widgets/progres_bar/slider_bar.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProgressBarInProgress extends ConsumerWidget {
  final String dateEnds;
  final int amount;
  final bool isReinvestmentAvailable;
  final VoidCallback? onPressed;
  final String? actionStatus;
  const ProgressBarInProgress({
    super.key,
    required this.dateEnds,
    required this.amount,
    this.isReinvestmentAvailable = false,
    required this.onPressed,
    this.actionStatus,
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
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isDarkMode
                ? const Color(backgroundDark)
                : const Color(backgroundLight),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 2,
                ),
                AmountInvestment(
                  amount: amount,
                  fundName: 'Inversión empresarial',
                ),
                const SizedBox(height: 1),
                const SliderBar(
                  image: 'assets/images/money_wings_19.png',
                  toValidate: false,
                ),
                FinalText(
                  dateFinal: dateEnds,
                ),
                const SizedBox(height: 3),
                if (isReinvestmentAvailable == true &&
                    actionStatus == ActionStatusEnum.defaultReInvestment) ...[
                  ButtonReinvest(onPressed: onPressed),
                ],
                if (isReinvestmentAvailable == true &&
                    actionStatus == ActionStatusEnum.pendingReInvestment) ...[
                  const Align(
                      alignment: Alignment.centerRight,
                      child: ReinvestmentRequestedTag()),
                ],
                if (isReinvestmentAvailable == true &&
                    actionStatus == ActionStatusEnum.disabledReInvestment) ...[
                  const Align(
                      alignment: Alignment.centerRight,
                      child: ReinvestmentCancelledTag()),
                ]
              ],
            ),
          ),
        ),
        const LabelState(
          label: "📉 Inversión en curso",
        ),
      ],
    );
  }
}

class ButtonReinvest extends ConsumerWidget {
  const ButtonReinvest({
    super.key,
    required this.onPressed,
  });
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const backgroundDark = 0xffA2E6FA;
    const backgroundLight = 0xff0D3A5C;
    const textDark = 0xff0D3A5C;
    const textLight = 0xffFFFFFF;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 188,
        height: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isDarkMode
              ? const Color(backgroundDark)
              : const Color(backgroundLight),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const TextPoppins(
              text: 'Reinvertir mi inversión',
              fontSize: 12,
              textDark: textDark,
              textLight: textLight,
            ),
            const SizedBox(width: 5),
            Icon(
              Icons.arrow_forward_rounded,
              size: 16,
              color:
                  isDarkMode ? const Color(textDark) : const Color(textLight),
            ),
          ],
        ),
      ),
    );
  }
}

class ReinvestmentRequestedTag extends ConsumerWidget {
  const ReinvestmentRequestedTag({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const backgroundDark = 0xff9AD666;
    const textDark = 0xffffffff;
    const textLight = 0xff0D3A5C;

    return GestureDetector(
      child: Container(
        width: 188,
        height: 22,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(backgroundDark),
        ),
        child: const Center(
          child: TextPoppins(
            text: 'Re-inversión Solicitada',
            fontSize: 12,
            textDark: textDark,
            textLight: textLight,
          ),
        ),
      ),
    );
  }
}

class ReinvestmentCancelledTag extends ConsumerWidget {
  const ReinvestmentCancelledTag({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const backgroundDark = 0xff7C73FE;
    const textColor = 0xffffffff;

    return GestureDetector(
      child: Container(
        width: 188,
        height: 22,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(backgroundDark),
        ),
        child: const Center(
          child: TextPoppins(
            text: 'Devolución Solicitada',
            fontSize: 12,
            textDark: textColor,
            textLight: textColor,
          ),
        ),
      ),
    );
  }
}

class FinalText extends ConsumerWidget {
  final String dateFinal;
  const FinalText({
    super.key,
    required this.dateFinal,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Finaliza $dateFinal',
          style: TextStyle(
            fontSize: 11,
            fontFamily: "Poppins",
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          'En curso',
          style: TextStyle(
            fontSize: 8,
            fontFamily: "Poppins",
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }
}

class AmountInvestment extends ConsumerWidget {
  final int amount;
  final String fundName;
  const AmountInvestment({
    super.key,
    required this.amount,
    required this.fundName,
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
            color: const Color(dividerAmountColor),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                fundName,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins",
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
    const labelLightContainer = 0xff0D3A5C;
    const labelDarkContainer = 0xffA2E6FA;
    const textDark = 0xff0D3A5C;
    const textLight = 0xffFFFFFF;
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
                fontFamily: "Poppins",
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
