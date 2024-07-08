import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/animated_number.dart';
import 'package:finniu/presentation/screens/catalog/widgets/progres_bar/slider_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProgresBarInProgress extends ConsumerWidget {
  const ProgresBarInProgress({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const backgroudLight = 0xffD6F6FF;
    const backgroudDark = 0xff08273F;
    return Stack(
      children: [
        Container(
          width: 336,
          height: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isDarkMode
                ? const Color(backgroudDark)
                : const Color(backgroudLight),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                AmountInvestment(),
                SizedBox(height: 1),
                SliderBar(),
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

class AmountInvestment extends ConsumerWidget {
  const AmountInvestment({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int amoutColorDark = 0xffA2E6FA;
    const int amoutColorLight = 0xff0D3A5C;
    const int dividerAmoutColor = 0xffA2E6FA;
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          Container(
            width: 4,
            height: 47,
            color: const Color(dividerAmoutColor),
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
                beginNumber: 8000,
                endNumber: 10000,
                duration: 2,
                fontSize: 14,
                colorText: isDarkMode ? amoutColorDark : amoutColorLight,
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
    const textLight = 0xffFFFFFF;
    const textDark = 0xff0D3A5C;
    return Positioned(
      right: 0,
      child: Container(
        height: 24,
        width: 95,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(15),
            topRight: Radius.circular(15),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
