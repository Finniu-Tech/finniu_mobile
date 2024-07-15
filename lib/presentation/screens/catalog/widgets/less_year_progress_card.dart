import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LessYearBlueGoldCard extends ConsumerWidget {
  final int daysPassed;
  final int daysMissing;

  const LessYearBlueGoldCard({
    super.key,
    required this.daysPassed,
    required this.daysMissing,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff315AA5;
    const int backgroundLight = 0xffC8E2FF;
    const int backgroundYearDark = 0xffA2CEFE;
    const int backgroundYearLight = 0xff315AA5;
    const int daysPassedDark = 0xff1F4180;
    const int daysPassedLight = 0xffFFFFFF;

    const int daysMissingDark = 0xff94C7FF;
    const int daysMissingLight = 0xff315AA5;

    return Container(
      decoration: BoxDecoration(
        color: Color(isDarkMode ? backgroundDark : backgroundLight),
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      padding: const EdgeInsets.only(right: 20),
      width: MediaQuery.of(context).size.width * 0.95,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width * 0.5,
            height: 50,
            decoration: BoxDecoration(
              color:
                  Color(isDarkMode ? backgroundYearDark : backgroundYearLight),
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset("assets/blue_gold/plant_image.png",
                      width: 22, height: 22),
                ),
                Column(
                  children: [
                    TextPoppins(
                      text: "$daysPassed días",
                      fontSize: 16,
                      isBold: true,
                      textDark: daysPassedDark,
                      textLight: daysPassedLight,
                    ),
                    const TextPoppins(
                      text: "transcurridos desde tu inversión",
                      fontSize: 9,
                      isBold: true,
                      textDark: daysPassedDark,
                      textLight: daysPassedLight,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              const TextPoppins(
                text: "faltan ",
                fontSize: 12,
                textDark: daysMissingDark,
                textLight: daysMissingLight,
                isBold: true,
              ),
              TextPoppins(
                text: "$daysMissing días ",
                fontSize: 16,
                isBold: true,
                textDark: daysMissingDark,
                textLight: daysMissingLight,
              ),
              ClipOval(
                child: Image.asset(
                  "assets/blue_gold/blue_gold_investment.png",
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
