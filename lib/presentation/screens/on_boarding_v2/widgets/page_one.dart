import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PageOneContainer extends ConsumerWidget {
  const PageOneContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const List<Color> gradientDark = [
      Color(0xFF0D3A5C),
      Color(0xFF306281),
      Color(0xFFA2E6FA),
    ];
    const List<Color> gradientLight = [
      Color(0xFF9F8FFF),
      Color(0xFFA1D6FB),
      Color(0xFFA2E6FA),
    ];
    const String text = "Empieza a vivir una nueva experiencia con  Finniu ";
    const int textDark = 0xffFFFFFF;
    const int textLight = 0xff0D3A5C;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDarkMode ? gradientDark : gradientLight,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/onboarding/logo_onboarding_${isDarkMode ? "dark" : "light"}.png",
            width: 200,
            height: 180,
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            width: 250,
            child: TextPoppins(
              text: text,
              fontSize: 16,
              isBold: true,
              lines: 2,
              align: TextAlign.center,
              textDark: textDark,
              textLight: textLight,
            ),
          ),
          Icon(
            Icons.arrow_forward,
            size: 24,
            color: isDarkMode ? const Color(textDark) : const Color(textLight),
          ),
        ],
      ),
    );
  }
}
