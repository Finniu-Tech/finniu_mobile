import 'package:finniu/constants/colors/product_v4_colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v4/product_v4/app_bar_product.dart';
import 'package:finniu/presentation/screens/home_v4/products_v4/row_products.dart';
import 'package:finniu/widgets/switch.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductDetailV4 extends ConsumerWidget {
  const ProductDetailV4({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int colorDark = 0xff000000;
    const int colorLight = 0xffFFFFFF;
    return Scaffold(
      backgroundColor:
          isDarkMode ? const Color(colorDark) : const Color(colorLight),
      appBar: const AppBarProduct(),
      body: const SingleChildScrollView(
        child: ProductBody(),
      ),
    );
  }
}

class ProductBody extends StatelessWidget {
  const ProductBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const String objective =
        "Inversión en préstamos para capital de trabajo o desarrollo de proyectos en empresas que pertenecen al portafolio diversificado de Finniu.";
    const List<String> characteristics = [
      "Rentabilidad hasta 17% y 19% anual",
      "Portafolio diversificado de empresas de sectores con alta demanda",
      "Pago de rentabilidades mensuales.",
      "Plazo de inversión desde 6 meses",
      "Riesgo: Moderado",
    ];
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleDetail(),
        ObjectiveDetail(
          objective: objective,
        ),
        SizedBox(
          height: 15,
        ),
        Characteristics(
          characteristics: characteristics,
        ),
        SizedBox(
          height: 15,
        ),
        Divider(thickness: 2),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SwitchMoney(
              switchHeight: 30,
              switchWidth: 67,
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        RowMinRent()
      ],
    );
  }
}

class RowMinRent extends ConsumerWidget {
  const RowMinRent({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    //   titleDark: 0xffFFFFFF,
    // titleLight: 0xff0D3A5C,
    // minimumDark: 0xff0D3A5C,
    // minimumLight: 0xffBBF0FF,
    // profitabilityDark: 0xffB5FF8A,
    // profitabilityLight: 0xffD2FDBA,
    final colors = ProductContainerStyles(
      backgroundContainerDark: 0xff1B1B1B,
      backgroundContainerLight: 0xffE9FAFF,
      imageProduct: "🏢",
      titleText: "Producto de inversión a Plazo Fijo",
      minimumText: "1.000",
      profitabilityText: "19",
      titleDark: 0xffFFFFFF,
      titleLight: 0xff0D3A5C,
      minimumDark: 0xff0D3A5C,
      minimumLight: 0xffBBF0FF,
      profitabilityDark: 0xffB5FF8A,
      profitabilityLight: 0xffD2FDBA,
      isSoles: true,
      uuid: "1",
      buttonBackDark: 0xffA2E6FA,
      buttonBackLight: 0xff0D3A5C,
      buttonTextDark: 0xff0D3A5C,
      buttonTextLight: 0xffFFFFFF,
      textDark: 0xff000000,
      textLight: 0xff000000,
    );
    return RowProducts(
      isDarkMode: isDarkMode,
      minimumDark: colors.getMinimumDark,
      minimumLight: colors.getMinimumLight,
      minimunText: colors.getMinimumText,
      profitabilityDark: colors.getProfitabilityDark,
      profitabilityLight: colors.getProfitabilityLight,
      profitabilityText: colors.getProfitabilityText,
      textDark: colors.textDark,
      textLight: colors.textLight,
    );
  }
}

class Characteristics extends StatelessWidget {
  const Characteristics({
    super.key,
    required this.characteristics,
  });
  final List<String> characteristics;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.bar_chart,
          size: 24,
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const TextPoppins(
                text: "Características",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              ...characteristics.map(
                (e) => TextPoppins(
                  text: "• $e",
                  fontSize: 13,
                  lines: 2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ObjectiveDetail extends StatelessWidget {
  const ObjectiveDetail({
    super.key,
    required this.objective,
  });
  final String objective;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.track_changes_rounded,
          size: 24,
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const TextPoppins(
              text: "Objetivo",
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: TextPoppins(
                text: objective,
                fontSize: 13,
                lines: 4,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TitleDetail extends StatelessWidget {
  const TitleDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: TextPoppins(
        text: "Producto de \ninversión a Plazo Fijo",
        fontSize: 20,
        fontWeight: FontWeight.w600,
        lines: 2,
      ),
    );
  }
}
