import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/animated_number.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math' as math;

class ModalInvestmentSummary extends StatelessWidget {
  const ModalInvestmentSummary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonInvestment(
      text: 'Invierte',
      onPressed: () => showModalBottomSheet(
        context: context,
        builder: (context) => const BodyModalInvestment(),
      ),
    );
  }
}

class BodyModalInvestment extends ConsumerWidget {
  const BodyModalInvestment({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const backgroudDark = 0xff1A1A1A;
    const backgroudLight = 0xffFFFFFF;

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(backgroudDark)
            : const Color(backgroudLight),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      height: 529,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          children: [
            CloseButton(),
            SizedBox(height: 10),
            TitleModal(),
            SizedBox(height: 10),
            IconFond(),
            SizedBox(height: 10),
            InvestmentAmountCardsRow(),
            SizedBox(height: 10),
            TermProfitabilityRow(),
            SizedBox(height: 10),
            SelectedBank(),
            SizedBox(height: 10),
            InvestmentEnds(),
          ],
        ),
      ),
    );
  }
}

class InvestmentEnds extends ConsumerWidget {
  const InvestmentEnds({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int borderDark = 0xffA2E6FA;
    const int borderLight = 0xff0D3A5C;
    return Container(
      height: 66,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color:
              isDarkMode ? const Color(borderDark) : const Color(borderLight),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Icon(
                Icons.calendar_today_outlined,
                color: isDarkMode
                    ? const Color(borderDark)
                    : const Color(borderLight),
                size: 23,
              ),
            ],
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Tu inversión finaliza ",
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: 16,
                ),
              ),
              Text(
                "10/07/2025",
                style: TextStyle(
                  color: isDarkMode
                      ? const Color(borderDark)
                      : const Color(borderLight),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SelectedBank extends ConsumerWidget {
  const SelectedBank({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroudDark = 0xff2A2929;
    const int backgroudLight = 0xffF1FCFF;
    return Container(
      height: 66,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isDarkMode
            ? const Color(backgroudDark)
            : const Color(backgroudLight),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 13),
          Image.asset(
            "assets/images/bankSelectImage.png",
            width: 45,
            height: 45,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Banco donde se transfiere",
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: 14,
                ),
              ),
              Text(
                "BCP *************321",
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TermProfitabilityRow extends ConsumerWidget {
  const TermProfitabilityRow({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff2A2929;
    const int backgroundLight = 0xffF1FCFF;
    const int iconDark = 0xffA2E6FA;
    const int iconLight = 0xff0D3A5C;
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 66,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isDarkMode
                  ? const Color(backgroundDark)
                  : const Color(backgroundLight),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: isDarkMode
                      ? const Color(iconDark)
                      : const Color(iconLight),
                  size: 23,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "A un Plazo de",
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "12 meses",
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            height: 66,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isDarkMode
                  ? const Color(backgroundDark)
                  : const Color(backgroundLight),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.stacked_line_chart_outlined,
                  color: isDarkMode
                      ? const Color(iconDark)
                      : const Color(iconLight),
                  size: 23,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Rentabilidad",
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "16 %",
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class InvestmentAmountCardsRow extends ConsumerWidget {
  const InvestmentAmountCardsRow({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int amoutColorDark = 0xffA2E6FA;
    const int amoutColorLight = 0xff0D3A5C;
    const int rentColorDark = 0xff83BF4F;
    const int rentColorLight = 0xff0D3A5C;
    const int dividerRentColor = 0xff83BF4F;
    const int dividerAmoutColor = 0xffA2E6FA;

    return Row(
      children: [
        Expanded(
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
                    colorText: isDarkMode ? amoutColorDark : amoutColorLight,
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
                width: 4,
                height: 47,
                color: const Color(dividerRentColor),
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

class IconFond extends ConsumerWidget {
  const IconFond({
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

class TitleModal extends ConsumerWidget {
  const TitleModal({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundColor = 0xff55B63D;
    const int textColorDark = 0xffFFFFFF;
    const int textColorLight = 0xff0D3A5C;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Resumen de mi inversión",
          style: TextStyle(
            color: isDarkMode
                ? const Color(textColorDark)
                : const Color(textColorLight),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Container(
          width: 73,
          height: 26,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(backgroundColor),
          ),
          child: Center(
            child: Text(
              "En curso",
              style: TextStyle(
                color: isDarkMode ? Colors.black : Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CloseButton extends ConsumerWidget {
  const CloseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int colorDark = 0xffFFFFFF;
    const int colorLight = 0xff515151;
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Transform.rotate(
              angle: math.pi / 4,
              child: Icon(
                Icons.add_circle_outline,
                size: 20,
                color: isDarkMode
                    ? const Color(colorDark)
                    : const Color(colorLight),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
