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
          stops: const [0.0, 0.35, 1.0],
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

class PageTwoContainer extends ConsumerWidget {
  const PageTwoContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff191919;
    const int backgroundLight = 0xffFFFFFF;

    const int lineColor = 0xff65DCFF;
    const String text =
        "Comienza a invertir desde S/1,000 y \$1,000  sin comisiones";
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: isDarkMode
          ? const Color(backgroundDark)
          : const Color(backgroundLight),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Image.asset(
                "assets/onboarding/onboarding_image_1.png",
                width: 250,
                height: 305,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: SizedBox(
                  width: 250,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 170,
                        height: 7,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(lineColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 250,
            child: TextPoppins(
              text: text,
              fontSize: 16,
              isBold: true,
              lines: 2,
              align: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class PageThreeContainer extends ConsumerWidget {
  const PageThreeContainer({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String text =
        "Puedes invertir en plazos de 6, 12 y 24 meses con intereses mensuales";
    const String imageUrl = "assets/onboarding/onboarding_image_2.png";

    return const ImageAndGradientPage(
      text: text,
      imageUrl: imageUrl,
    );
  }
}

class PageFourContainer extends ConsumerWidget {
  const PageFourContainer({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String text = "Simula tu inversión y proyecta tus rendimientos";
    const String imageUrl = "assets/onboarding/onboarding_image_3.png";

    return const ImageAndGradientPage(
      text: text,
      imageUrl: imageUrl,
    );
  }
}

class PageFiveContainer extends ConsumerWidget {
  const PageFiveContainer({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String text =
        "Recibe tu capital y tus intereses garantizado en la fecha establecida";
    const String imageUrl = "assets/onboarding/onboarding_image_4.png";

    return const ImageAndGradientPage(
      text: text,
      imageUrl: imageUrl,
    );
  }
}

class ImageAndGradientPage extends ConsumerWidget {
  const ImageAndGradientPage({
    super.key,
    required this.text,
    required this.imageUrl,
  });
  final String text;
  final String imageUrl;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const List<Color> gradient = [
      Colors.transparent,
      Color(0xFF171717),
    ];

    const int textDark = 0xffFFFFFF;
    const int textLight = 0xffFFFFFF;
    return Stack(
      children: [
        Image.asset(imageUrl),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: gradient,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
                0.5,
                1.0,
              ],
            ),
          ),
          child: Center(
            child: SizedBox(
              width: 250,
              child: TextPoppins(
                text: text,
                fontSize: 16,
                isBold: true,
                lines: 3,
                align: TextAlign.center,
                textDark: textDark,
                textLight: textLight,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
