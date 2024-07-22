import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/animated_number.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InvestmentAmountCardsRow extends ConsumerWidget {
  const InvestmentAmountCardsRow({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int amountColorDark = 0xffA2E6FA;
    const int amountColorLight = 0xff0D3A5C;
    const int rentColorDark = 0xff83BF4F;
    const int rentColorLight = 0xff0D3A5C;
    const int dividerRentColor = 0xff83BF4F;
    const int dividerAmountColor = 0xffA2E6FA;

    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(dividerAmountColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 4,
                height: 47,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Monto invertido',
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
                    fontSize: 16,
                    colorText: isDarkMode ? amountColorDark : amountColorLight,
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(dividerRentColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 4,
                height: 47,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Rentabilidad Final',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  AnimationNumber(
                    endNumber: 12000,
                    beginNumber: 10000,
                    duration: 2,
                    fontSize: 16,
                    colorText: isDarkMode ? rentColorDark : rentColorLight,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
