import 'package:carousel_slider/carousel_slider.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/animated_number.dart';
import 'package:finniu/presentation/screens/catalog/widgets/carrousel_slide.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CarrouselDetailV4 extends ConsumerWidget {
  const CarrouselDetailV4({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSoles = ref.watch(isSolesStateProvider);
    final List<Widget> items = [
      ManagedAssetsV4(
        investmentsText: isSoles ? 5700000 : 570000,
        cardColorDark: 0xFFB9A8FF,
        cardColorLight: 0xFFB9A8FF,
        dividerColorDark: 0xFF8066E8,
        dividerColorLight: 0xFF8066E8,
        numberColorDark: 0xFF000000,
        numberColorLight: 0xFF000000,
        isSoles: isSoles,
      ),
    ];

    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: CarouselSlider(
        items: items,
        options: CarouselOptions(
          height: 280,
          enlargeCenterPage: true,
          aspectRatio: 3 / 2,
          viewportFraction: 0.7,
        ),
      ),
    );
  }
}

class ManagedAssetsV4 extends ConsumerWidget {
  const ManagedAssetsV4({
    super.key,
    required this.investmentsText,
    required this.cardColorLight,
    required this.cardColorDark,
    required this.dividerColorLight,
    required this.dividerColorDark,
    required this.numberColorDark,
    required this.numberColorLight,
    required this.isSoles,
  });
  final int investmentsText;
  final int cardColorLight;
  final int cardColorDark;
  final int dividerColorLight;
  final int dividerColorDark;
  final int numberColorDark;
  final int numberColorLight;
  final bool isSoles;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    return SlideCarouselCard(
      color: isDarkMode ? cardColorDark : cardColorLight,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const TextPoppins(
            text: "Activos administrados",
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          const TextPoppins(
            text:
                "Los activos administrados representan el valor de mercado de las inversiones del fondo",
            fontSize: 13,
            lines: 4,
          ),
          Divider(
            height: 2,
            color: Color(
              isDarkMode ? dividerColorDark : dividerColorLight,
            ),
          ),
          const TextPoppins(
            text: "Activos administrados",
            fontSize: 11,
          ),
          AnimationNumberNotComma(
            isSoles: isSoles,
            endNumber: investmentsText,
            duration: 2,
            fontSize: 32,
            colorText: isDarkMode ? numberColorDark : numberColorLight,
            beginNumber: 0,
          ),
        ],
      ),
    );
  }
}
