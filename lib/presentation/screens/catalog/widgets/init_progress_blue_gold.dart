import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InitProgressBlueGoldCard extends ConsumerWidget {
  const InitProgressBlueGoldCard({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff1F4180;
    const int backgroundLight = 0xffC8E2FF;
    const int textTimeDark = 0xff6A9DFB;
    const int textTimeLight = 0xff315AA5;
    const int textTimeInDayDark = 0xff94C7FF;
    const int textTimeInDayLight = 0xff315AA5;

    const int time = 1;
    const int timeInDay = 120;
    return Container(
      decoration: BoxDecoration(
        color: Color(isDarkMode ? backgroundDark : backgroundLight),
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const TextPoppins(
            text: "$time AÑO",
            fontSize: 16,
            textDark: textTimeDark,
            textLight: textTimeLight,
            isBold: true,
          ),
          Row(
            children: [
              const TextPoppins(
                text: "faltan ",
                fontSize: 12,
                textDark: textTimeInDayDark,
                textLight: textTimeInDayLight,
                isBold: true,
              ),
              const TextPoppins(
                text: "$timeInDay días ",
                fontSize: 16,
                isBold: true,
                textDark: textTimeInDayDark,
                textLight: textTimeInDayLight,
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
