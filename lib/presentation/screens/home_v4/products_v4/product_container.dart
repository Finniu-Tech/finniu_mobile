import 'package:finniu/constants/colors/product_v4_colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v4/products_v4/row_products.dart';
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
      constraints: const BoxConstraints(maxWidth: 350),
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
          RowProducts(
            isDarkMode: isDarkMode,
            isSoles: colors.isSoles,
            minimumDark: colors.getMinimumDark,
            minimumLight: colors.getMinimumLight,
            minimunText: colors.getMinimumText,
            profitabilityDark: colors.getProfitabilityDark,
            profitabilityLight: colors.getProfitabilityLight,
            profitabilityText: colors.getProfitabilityText,
            textDark: colors.textDark,
            textLight: colors.textLight,
            minimunTextColorDark: colors.minimunTextColorDark,
            minimumTextColorLight: colors.minimumTextColorLight,
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
