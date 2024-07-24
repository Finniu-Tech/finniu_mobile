import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IconFund extends ConsumerWidget {
  const IconFund({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int containerDark = 0xff0D3A5C;
    const int containerLight = 0xffDBF7FF;
    const int textDark = 0xffDBF7FF;
    const int textLight = 0xff0D3A5C;
    const int imageDark = 0xff08273F;
    const int imageLight = 0xff95E1F8;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              width: 273,
              height: 30,
              padding: const EdgeInsets.only(right: 10),
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isDarkMode
                    ? const Color(containerDark)
                    : const Color(containerLight),
              ),
              child: Text(
                'Fondo préstamo empresarial ',
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: isDarkMode
                      ? const Color(textDark)
                      : const Color(textLight),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? const Color(imageDark)
                      : const Color(imageLight),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Image.asset(
                  'assets/investment/business_loans_investment_icon.png',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
