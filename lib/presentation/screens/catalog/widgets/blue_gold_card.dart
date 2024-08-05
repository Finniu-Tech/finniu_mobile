import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/animated_number.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BlueGoldInvestmentCard extends ConsumerWidget {
  const BlueGoldInvestmentCard({
    super.key,
    required this.days,
    required this.progress,
    required this.amount,
  });
  final int days;
  final double progress;
  final int amount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const backgroundDark = 0xff315AA5;
    const backgroundLight = 0xffDFEEFF;
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 168,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isDarkMode ? const Color(backgroundDark) : const Color(backgroundLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: AmountBlueGold(amount: amount)),
          Expanded(
            child: InvestmentDays(
              days: days,
              progress: progress,
            ),
          ),
        ],
      ),
    );
  }
}

class InvestmentDays extends ConsumerWidget {
  const InvestmentDays({
    super.key,
    required this.days,
    required this.progress,
  });
  final int days;
  final double progress;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int textDayDark = 0xffFFFFFF;
    const int textDayLight = 0xff315AA5;
    const int imageColor = 0xffA2CEFE;

    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/blue_gold/plant_image.png",
                width: 24,
                height: 24,
              ),
              LineInvestment(
                isDarkMode: isDarkMode,
                progress: progress,
              ),
              TextPoppins(
                text: "$days dias",
                fontSize: 14,
                isBold: true,
                textDark: textDayDark,
                textLight: textDayLight,
              ),
            ],
          ),
        ),
        Container(
          width: 40,
          height: 40,
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(imageColor),
          ),
          child: Image.asset(
            "assets/blue_gold/blue_gold_investment.png",
            width: 24,
            height: 24,
          ),
        ),
      ],
    );
  }
}

class LineInvestment extends StatefulWidget {
  const LineInvestment({
    super.key,
    required this.isDarkMode,
    required this.progress,
  });

  final bool isDarkMode;
  final double progress;

  @override
  State<LineInvestment> createState() => _LineInvestmentState();
}

class _LineInvestmentState extends State<LineInvestment> {
  double _currentWidth = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _currentWidth = widget.progress;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    const int unselectedLineDark = 0xff4471C3;
    const int unselectedLineLight = 0xffA2CEFE;
    const int selectedLineDark = 0xffC3DFFF;
    const int selectedLineLight = 0xff315AA5;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(
                  widget.isDarkMode ? unselectedLineDark : unselectedLineLight,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              height: 7,
              width: constraints.maxWidth,
            ),
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              decoration: BoxDecoration(
                color: Color(
                  widget.isDarkMode ? selectedLineDark : selectedLineLight,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              height: 7,
              width: constraints.maxWidth * _currentWidth / 100,
            ),
          ],
        );
      },
    );
  }
}

class AmountBlueGold extends ConsumerWidget {
  final int amount;
  const AmountBlueGold({
    super.key,
    required this.amount,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int amountColorDark = 0xffFFFFFF;
    const int amountColorLight = 0xff000000;
    const int dividerAmountColor = 0xffC3DFFF;
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: const Color(dividerAmountColor),
            ),
            width: 6,
            height: 54,
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
