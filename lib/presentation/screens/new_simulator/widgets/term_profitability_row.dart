import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/new_simulator/widgets/circular_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TermProfitabilityRow extends ConsumerWidget {
  const TermProfitabilityRow(
      {super.key,
      required this.month,
      required this.rentabilityPercent,
      required this.isLoader});
  final int? month;
  final int? rentabilityPercent;
  final bool isLoader;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff2A2929;
    const int backgroundLight = 0xffD3F5FF;
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
                SvgPicture.asset(
                  'assets/svg_icons/calendar_blank.svg',
                  width: 24,
                  height: 24,
                  color: Color(isDarkMode ? iconDark : iconLight),
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
                    isLoader
                        ? const CircularLoader(width: 20, height: 20)
                        : Text(
                            "${month == null ? "-" : "$month"} meses",
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
                SvgPicture.asset(
                  'assets/svg_icons/status_up.svg',
                  width: 24,
                  height: 24,
                  color: Color(isDarkMode ? iconDark : iconLight),
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
                    isLoader
                        ? const CircularLoader(
                            width: 20,
                            height: 20,
                          )
                        : Text(
                            "${rentabilityPercent == null ? "-" : "$rentabilityPercent"} %",
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
