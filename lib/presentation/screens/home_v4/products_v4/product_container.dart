import 'package:finniu/constants/colors/product_v4_colors.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v4/products_v4/row_products.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductContainer extends ConsumerWidget {
  const ProductContainer({
    super.key,
    required this.product,
    required this.onPressed,
  });

  final Function()? onPressed;
  final ProductData product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final style = product.style;
    print('product: ${product.titleText}');
    final isSoles = ref.watch(isSolesStateProvider);

    return Container(
      padding: const EdgeInsets.all(10),
      constraints: const BoxConstraints(maxWidth: 350),
      height: 270,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: isDarkMode ? Color(style.backgroundContainerDark) : Color(style.backgroundContainerLight),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _ProductHeader(product: product, style: style),
          _ProductDetails(
            product: product,
            style: style,
            isDarkMode: isDarkMode,
            isSoles: isSoles,
          ),
          _ProductButton(
            onPressed: onPressed,
            style: style,
            isDarkMode: isDarkMode,
          ),
        ],
      ),
    );
  }
}

class _ProductHeader extends StatelessWidget {
  const _ProductHeader({
    required this.product,
    required this.style,
  });

  final ProductData product;
  final ProductStyle style;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          product.imageProduct,
          height: 40,
          width: 60,
          fit: BoxFit.contain,
        ),
        // TextPoppins(
        //   text: product.imageProduct,
        //   fontSize: 32,
        //   fontWeight: FontWeight.w600,
        // ),
        const SizedBox(width: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: TextPoppins(
            text: product.titleText,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            lines: 2,
            textDark: style.titleDark,
            textLight: style.titleLight,
          ),
        ),
      ],
    );
  }
}

class _ProductDetails extends StatelessWidget {
  const _ProductDetails({
    required this.product,
    required this.style,
    required this.isDarkMode,
    required this.isSoles,
  });

  final ProductData product;
  final ProductStyle style;
  final bool isDarkMode;
  final bool isSoles;

  @override
  Widget build(BuildContext context) {
    print('product is soles  ${product.isSoles}');
    print('minimunText sokes ${product.minimumTextPEN}');
    print('minimunText dolar ${product.minimumTextUSD}');
    return RowProducts(
      isDarkMode: isDarkMode,
      isSoles: product.isSoles,
      minimumDark: style.minimumDark,
      minimumLight: style.minimumLight,
      // minimunText: product.minimumText,
      minimunText: isSoles ? product.minimumTextPEN! : product.minimumTextUSD!,
      profitabilityDark: style.profitabilityDark,
      profitabilityLight: style.profitabilityLight,
      profitabilityText: product.profitabilityText,
      textDark: style.textDark,
      textLight: style.textLight,
      minimunTextColorDark: style.minimunTextColorDark,
      minimumTextColorLight: style.minimumTextColorLight,
    );
  }
}

class _ProductButton extends StatelessWidget {
  const _ProductButton({
    required this.onPressed,
    required this.style,
    required this.isDarkMode,
  });

  final Function()? onPressed;
  final ProductStyle style;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(5),
        backgroundColor: WidgetStateProperty.all(
          Color(
            isDarkMode ? style.buttonBackDark : style.buttonBackLight,
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
            textDark: style.buttonTextDark,
            textLight: style.buttonTextLight,
          ),
          const SizedBox(width: 10),
          Icon(
            Icons.arrow_forward,
            color: isDarkMode ? Color(style.buttonTextDark) : Color(style.buttonTextLight),
          ),
        ],
      ),
    );
  }
}

// class ProductContainer extends ConsumerWidget {
//   const ProductContainer({
//     super.key,
//     required this.colors,
//     required this.onPressed,
//   });
//   final Function()? onPressed;
//   final ProductContainerStyles colors;
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
//     return Container(
//       padding: const EdgeInsets.all(10),
//       constraints: const BoxConstraints(maxWidth: 350),
//       height: 270,
//       decoration: BoxDecoration(
//         borderRadius: const BorderRadius.all(Radius.circular(15)),
//         color: isDarkMode ? Color(colors.getBackgroundContainerDark) : Color(colors.getBackgroundContainerLight),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextPoppins(
//                 text: colors.getImageProduct,
//                 fontSize: 32,
//                 fontWeight: FontWeight.w600,
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.6,
//                 child: TextPoppins(
//                   text: colors.getTitleText,
//                   fontSize: 20,
//                   fontWeight: FontWeight.w600,
//                   lines: 2,
//                   textDark: colors.getTitleDark,
//                   textLight: colors.getTitleLight,
//                 ),
//               ),
//             ],
//           ),
//           RowProducts(
//             isDarkMode: isDarkMode,
//             isSoles: colors.isSoles,
//             minimumDark: colors.getMinimumDark,
//             minimumLight: colors.getMinimumLight,
//             minimunText: colors.getMinimumText,
//             profitabilityDark: colors.getProfitabilityDark,
//             profitabilityLight: colors.getProfitabilityLight,
//             profitabilityText: colors.getProfitabilityText,
//             textDark: colors.textDark,
//             textLight: colors.textLight,
//             minimunTextColorDark: colors.minimunTextColorDark,
//             minimumTextColorLight: colors.minimumTextColorLight,
//           ),
//           ElevatedButton(
//             onPressed: onPressed,
//             style: ButtonStyle(
//               elevation: WidgetStateProperty.all(5),
//               backgroundColor: WidgetStateProperty.all(
//                 Color(
//                   isDarkMode ? colors.buttonBackDark : colors.buttonBackLight,
//                 ),
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 TextPoppins(
//                   text: "Ver más información",
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                   textDark: colors.buttonTextDark,
//                   textLight: colors.buttonTextLight,
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Icon(
//                   Icons.arrow_forward,
//                   color: isDarkMode ? Color(colors.buttonTextDark) : Color(colors.buttonTextLight),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
