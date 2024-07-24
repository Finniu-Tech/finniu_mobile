import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
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
      height: 47,
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
          SvgPicture.asset(
            'assets/svg_icons/calendar_blank.svg',
            width: 24,
            height: 24,
            color: Color(isDarkMode ? iconColorDark : iconColorLight),
          ),
          const SizedBox(width: 10),
          const TextPoppins(
            text: "Tu inversión finaliza ",
            fontSize: 16,
          ),
          const SizedBox(
            width: 5,
          ),
          const TextPoppins(
            text: "10/07/2025",
            fontSize: 16,
            isBold: true,
            textDark: borderDark,
            textLight: borderLight,
          ),
        ],
      ),
    );
  }
}
