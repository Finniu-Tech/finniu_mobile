import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';

class RowProducts extends StatelessWidget {
  const RowProducts({
    super.key,
    required this.isDarkMode,
    required this.minimumDark,
    required this.minimumLight,
    required this.minimunText,
    required this.profitabilityDark,
    required this.profitabilityLight,
    required this.textDark,
    required this.textLight,
    required this.profitabilityText,
  });
  final bool isDarkMode;
  final int minimumDark;
  final int minimumLight;
  final int profitabilityDark;
  final int profitabilityLight;
  final int textDark;
  final int textLight;
  final String minimunText;
  final String profitabilityText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            height: 95,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: isDarkMode ? Color(minimumDark) : Color(minimumLight),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextPoppins(
                  text: "Puedes comenzar a Invertir desde",
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  lines: 2,
                ),
                TextPoppins(
                  text: "S/$minimunText",
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  lines: 2,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            height: 95,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: isDarkMode
                  ? Color(profitabilityDark)
                  : Color(profitabilityLight),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextPoppins(
                  text: "Con una rentabilidad de hasta",
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  lines: 2,
                  textDark: textDark,
                  textLight: textLight,
                ),
                Row(
                  children: [
                    TextPoppins(
                      text: "$profitabilityText% ",
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      textDark: textDark,
                      textLight: textLight,
                    ),
                    TextPoppins(
                      text: "anual",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      textDark: textDark,
                      textLight: textLight,
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
