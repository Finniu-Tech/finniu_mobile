import 'package:finniu/constants/colors/product_v4_colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductContainer extends ConsumerWidget {
  const ProductContainer({
    super.key,
    required this.colors,
    required this.onPressed,
  });
  final Function()? onPressed;
  final ProductContainerStyles colors;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return Container(
      padding: const EdgeInsets.all(20),
      height: 270,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: isDarkMode
            ? Color(colors.getBackgroundContainerDark)
            : Color(colors.getBackgroundContainerLight),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextPoppins(
                text: colors.getImageProduct,
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: TextPoppins(
                  text: colors.getTitleText,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  lines: 2,
                  textDark: colors.getTitleDark,
                  textLight: colors.getTitleLight,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 95,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: isDarkMode
                        ? Color(colors.getMinimumDark)
                        : Color(colors.getMinimumLight),
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
                        text: "S/${colors.getMinimumText}",
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
                        ? Color(colors.getProfitabilityDark)
                        : Color(colors.getProfitabilityLight),
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
                        textDark: colors.textDark,
                        textLight: colors.textLight,
                      ),
                      Row(
                        children: [
                          TextPoppins(
                            text: "${colors.getProfitabilityText}% ",
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            textDark: colors.textDark,
                            textLight: colors.textLight,
                          ),
                          TextPoppins(
                            text: "anual",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            textDark: colors.textDark,
                            textLight: colors.textLight,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              elevation: WidgetStateProperty.all(5),
              backgroundColor: WidgetStateProperty.all(
                Color(
                  isDarkMode ? colors.buttonBackDark : colors.buttonBackLight,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextPoppins(
                  text: "Ver más información",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  textDark: colors.buttonTextDark,
                  textLight: colors.buttonTextLight,
                ),
                const SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.arrow_forward,
                  color: isDarkMode
                      ? Color(colors.buttonTextDark)
                      : Color(colors.buttonTextLight),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
