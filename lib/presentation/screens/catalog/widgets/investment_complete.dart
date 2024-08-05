import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/animated_number.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CompleteInvestment extends ConsumerWidget {
  final String dateEnds;
  final int amount;
  const CompleteInvestment({
    super.key,
    required this.dateEnds,
    required this.amount,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    // int backgroundLight = isReInvestment ? 0xffCFC3FF : 0xffD6F6FF;
    // int backgroundDark = isReInvestment ? 0xff6749E2 : 0xff08273F;
    int backgroundLight = 0xffD6F6FF;
    int backgroundDark = 0xff08273F;
    return Stack(
      children: [
        Container(
          width: 336,
          height: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isDarkMode ? Color(backgroundDark) : Color(backgroundLight),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AmountInvestment(
                  amount: amount,
                ),
                const SizedBox(height: 1),
                Text(
                  "Finalizado el $dateEnds",
                  style: TextStyle(
                    fontSize: 10,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        LabelState(
          label: "Depositado",
        ),
        const DownloadButton(),
      ],
    );
  }
}

class DownloadButton extends ConsumerWidget {
  const DownloadButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int buttonColorDark = 0xffA2E6FA;
    const int buttonColorLight = 0xff0D3A5C;
    const int textColorDark = 0xff08273F;
    const int textColorLight = 0xffFFFFFF;
    return Positioned(
      right: 7,
      bottom: 7,
      child: GestureDetector(
        onTap: () {
          print("descargar voucher");
        },
        child: Container(
          width: 144,
          height: 26,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isDarkMode
                ? const Color(buttonColorDark)
                : const Color(buttonColorLight),
            boxShadow: [
              BoxShadow(
                color: isDarkMode
                    ? Colors.white.withOpacity(0.2)
                    : Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isDarkMode
                  ? Image.asset(
                      "assets/icons/download_icon_dark.png",
                      width: 16,
                      height: 16,
                    )
                  : Image.asset(
                      "assets/icons/download_icon_light.png",
                      width: 16,
                      height: 16,
                    ),
              const SizedBox(width: 3),
              Text(
                "Descargar voucher",
                style: TextStyle(
                  fontSize: 10,
                  color: isDarkMode
                      ? const Color(textColorDark)
                      : const Color(textColorLight),
                ),
              ),
            ],
          ),
        ),
      ),
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
    // int amountColorDark = isReInvestment ? 0xffC1FF79 : 0xffA2E6FA;
    // int amountColorLight = isReInvestment ? 0xff278B0E : 0xff0D3A5C;
    // int dividerAmountColorDark = isReInvestment ? 0xffC1FF79 : 0xffA2E6FA;
    // int dividerAmountColor = isReInvestment ? 0xff278B0E : 0xff0D3A5C;
    // int textColorDark = isReInvestment ? 0xffC1FF79 : 0xff0A2E6FA;
    // int textColorLight = isReInvestment ? 0xff278B0E : 0xff0D3A5C;
    int amountColorDark = 0xffA2E6FA;
    int amountColorLight = 0xff0D3A5C;
    int dividerAmountColorDark = 0xffA2E6FA;
    int dividerAmountColor = 0xff0D3A5C;
    int textColorDark = 0xff0A2E6FA;
    int textColorLight = 0xff0D3A5C;

    return SizedBox(
      height: 52,
      child: Row(
        children: [
          Container(
            width: 4,
            height: 47,
            color: isDarkMode
                ? Color(dividerAmountColorDark)
                : Color(dividerAmountColor),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Inversión empresarial',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              Text(
                'Monto del retorno de tu capital',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color:
                      isDarkMode ? Color(textColorDark) : Color(textColorLight),
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
    // int labelLightContainer = isReInvestment ? 0xffA48EFF : 0xff90E5FD;
    // int labelDarkContainer = isReInvestment ? 0xffA48EFF : 0xff174C74;
    // int textDark = isReInvestment ? 0xff000000 : 0xffFFFFFF;
    // int textLight = isReInvestment ? 0xffFFFFFF : 0xff0D3A5C;
    int labelLightContainer = 0xff90E5FD;
    int labelDarkContainer = 0xff174C74;
    int textDark = 0xffFFFFFF;
    int textLight = 0xff0D3A5C;
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
              ? Color(labelDarkContainer)
              : Color(labelLightContainer),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/money_bag.png', height: 12, width: 12),
            const SizedBox(width: 5),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isDarkMode ? Color(textDark) : Color(textLight),
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
