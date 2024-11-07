import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/animated_number.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class CompleteInvestment extends ConsumerWidget {
  final String dateEnds;
  final int amount;
  final bool isCapital;
  final String? boucherImage;
  const CompleteInvestment({
    super.key,
    required this.dateEnds,
    required this.amount,
    this.isCapital = false,
    this.boucherImage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    // int backgroundLight = isReInvestment ? 0xffCFC3FF : 0xffD6F6FF;
    // int backgroundDark = isReInvestment ? 0xff6749E2 : 0xff08273F;

    int backgroundDark = isCapital ? 0xff6749E2 : 0xff08273F;

    int backgroundLight = isCapital ? 0xffCFC3FF : 0xffD6F6FF;
    return Stack(
      children: [
        Container(
          width: 336,
          height: 100,
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
                AmountInvestmentFinal(
                  amount: amount,
                  isCapital: isCapital,
                ),
                const SizedBox(height: 1),
                TextPoppins(
                  text: "Finalizado el $dateEnds",
                  fontSize: 10,
                ),
              ],
            ),
          ),
        ),
        LabelStateFinal(
          label: "Depositado",
          isCapital: isCapital,
        ),
        boucherImage == null || boucherImage == ""
            ? const SizedBox()
            : DownloadButton(
                voucherUrl: boucherImage!,
              ),
      ],
    );
  }
}

class DownloadButton extends ConsumerWidget {
  final String voucherUrl;
  const DownloadButton({
    super.key,
    required this.voucherUrl,
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
        onTap: () async {
          ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
            eventName: FirebaseAnalyticsEvents.voucherDownloadHistory,
            parameters: {
              "screen": FirebaseScreen.binnacleV2,
              "voucher_url": voucherUrl,
            },
          );
          await launchUrl(Uri.parse(voucherUrl));
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
              const TextPoppins(
                text: "Descargar voucher",
                fontSize: 10,
                textDark: textColorDark,
                textLight: textColorLight,
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
  final bool? isSoles;

  const AmountInvestment({
    super.key,
    required this.amount,
    this.isSoles,
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
    int textTitleColorDark = 0xffFFFFFF;
    int textTitleColorLight = 0xff0D3A5C;
    int textColorDark = 0xff0A2E6FA;
    int textColorLight = 0xff0D3A5C;

    return SizedBox(
      height: 57,
      child: Row(
        children: [
          Container(
            width: 4,
            height: 47,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isDarkMode
                  ? Color(dividerAmountColorDark)
                  : Color(dividerAmountColor),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextPoppins(
                text: 'Inversión empresarial',
                fontSize: 12,
                textDark: textTitleColorDark,
                textLight: textTitleColorLight,
                fontWeight: FontWeight.bold,
              ),
              TextPoppins(
                text: 'Monto del retorno de tu capital',
                fontSize: 9,
                fontWeight: FontWeight.w500,
                textDark: textColorDark,
                textLight: textColorLight,
              ),
              AnimationNumber(
                beginNumber: 0,
                endNumber: amount,
                duration: 1,
                fontSize: 14,
                colorText: isDarkMode ? amountColorDark : amountColorLight,
                isSoles: isSoles,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AmountInvestmentFinal extends ConsumerWidget {
  final int amount;
  final bool? isSoles;
  final bool isCapital;

  const AmountInvestmentFinal({
    super.key,
    required this.amount,
    this.isSoles,
    required this.isCapital,
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
    int amountColorDark = isCapital ? 0xffFFFFFF : 0xffA2E6FA;
    int amountColorLight = isCapital ? 0xff0D3A5C : 0xff0D3A5C;
    int dividerAmountColorDark = isCapital ? 0xffCFC3FF : 0xffA2E6FA;
    int dividerAmountColor = isCapital ? 0xff9C84FE : 0xff0D3A5C;
    int textTitleColorDark = isCapital ? 0xffFFFFFF : 0xffFFFFFF;
    int textTitleColorLight = isCapital ? 0xff0D3A5C : 0xff0D3A5C;
    int textColorDark = isCapital ? 0xffFFFFFF : 0xff0A2E6FA;
    int textColorLight = isCapital ? 0xff0D3A5C : 0xff0D3A5C;

    return SizedBox(
      height: 60,
      child: Row(
        children: [
          Container(
            width: 4,
            height: 47,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isDarkMode
                  ? Color(dividerAmountColorDark)
                  : Color(dividerAmountColor),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextPoppins(
                text: 'Inversión empresarial',
                fontSize: 12,
                textDark: textTitleColorDark,
                textLight: textTitleColorLight,
                fontWeight: FontWeight.bold,
              ),
              TextPoppins(
                text: isCapital
                    ? 'Monto del retorno de tu capital'
                    : 'Monto de la rentabilidad',
                fontSize: 9,
                fontWeight: FontWeight.w500,
                textDark: textColorDark,
                textLight: textColorLight,
              ),
              AnimationNumberNotComma(
                beginNumber: 0,
                endNumber: amount,
                duration: 1,
                fontSize: 14,
                colorText: isDarkMode ? amountColorDark : amountColorLight,
                isSoles: isSoles,
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
            TextPoppins(
              text: label,
              fontSize: 8,
              fontWeight: FontWeight.w500,
              textDark: textDark,
              textLight: textLight,
            ),
          ],
        ),
      ),
    );
  }
}

class LabelStateFinal extends ConsumerWidget {
  final String label;
  final bool isCapital;
  const LabelStateFinal({
    required this.label,
    required this.isCapital,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    // int labelLightContainer = isReInvestment ? 0xffA48EFF : 0xff90E5FD;
    // int labelDarkContainer = isReInvestment ? 0xffA48EFF : 0xff174C74;
    // int textDark = isReInvestment ? 0xff000000 : 0xffFFFFFF;
    // int textLight = isReInvestment ? 0xffFFFFFF : 0xff0D3A5C;
    int labelDarkContainer = isCapital ? 0xffA48EFF : 0xff174C74;
    int labelLightContainer = isCapital ? 0xff9C84FE : 0xff90E5FD;
    int textDark = isCapital ? 0xff000000 : 0xffFFFFFF;
    int textLight = isCapital ? 0xffFFFFFF : 0xff0D3A5C;
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
            TextPoppins(
              text: label,
              fontSize: 8,
              fontWeight: FontWeight.w500,
              textDark: textDark,
              textLight: textLight,
            ),
          ],
        ),
      ),
    );
  }
}
