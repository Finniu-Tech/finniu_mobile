import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IconFund extends ConsumerWidget {
  const IconFund({
    super.key,
    this.fundTitle,
  });
  final String? fundTitle;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('fundTitle: $fundTitle');
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int containerDark = 0xff0D3A5C;
    const int containerLight = 0xffDBF7FF;
    const int textDark = 0xffDBF7FF;
    const int textLight = 0xff0D3A5C;
    const int imageDark = 0xff08273F;
    const int imageLight = 0xff95E1F8;
    final String title = fundTitle ?? 'Fondo préstamo empresarial';
    final String icon = fundTitle == null
        ? '🏢'
        : fundTitle == "Producto de inversión con Garantía Inmobiliaria"
            ? "🏡"
            : "🏢";

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 30,
              padding: const EdgeInsets.only(right: 10),
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isDarkMode
                    ? const Color(containerDark)
                    : const Color(containerLight),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 25,
                  ),
                  Text(
                    title,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: isDarkMode
                          ? const Color(textDark)
                          : const Color(textLight),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              child: Container(
                alignment: Alignment.center,
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? const Color(imageDark)
                      : const Color(imageLight),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: TextPoppins(
                  text: icon,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class IconFundV4 extends ConsumerWidget {
  const IconFundV4({
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
              width: MediaQuery.of(context).size.width * 0.8,
              height: 30,
              padding: const EdgeInsets.only(right: 10),
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isDarkMode
                    ? const Color(containerDark)
                    : const Color(containerLight),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 25,
                  ),
                  Text(
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
                ],
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
