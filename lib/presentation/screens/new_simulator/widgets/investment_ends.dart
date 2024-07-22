import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InvestmentEnds extends ConsumerWidget {
  const InvestmentEnds({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int borderDark = 0xffA2E6FA;
    const int borderLight = 0xff0D3A5C;
    const int iconColorDark = 0xffA2E6FA;
    const int iconColorLight = 0xff0D3A5C;
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
              SvgPicture.asset(
                'assets/svg_icons/calendar_blank.svg',
                width: 18,
                height: 18,
                color: Color(isDarkMode ? iconColorDark : iconColorLight),
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
