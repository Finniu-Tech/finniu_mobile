import 'package:finniu/constants/colors/product_v4_colors.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/home_v4/product_v4/app_bar_product.dart';
import 'package:finniu/presentation/screens/home_v4/product_v4/carrousel_detail.dart';
import 'package:finniu/presentation/screens/home_v4/product_v4/item_carrousel.dart';
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

class ProductBody extends ConsumerWidget {
  const ProductBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSoles = ref.watch(isSolesStateProvider);
    const String objective =
        "Inversión en préstamos para capital de trabajo o desarrollo de proyectos en empresas que pertenecen al portafolio diversificado de Finniu.";
    const List<String> characteristics = [
      "Rentabilidad hasta 17% y 19% anual",
      "Portafolio diversificado de empresas de sectores con alta demanda",
      "Pago de rentabilidades mensuales.",
      "Plazo de inversión desde 6 meses",
      "Riesgo: Moderado",
    ];
    final List<ChartData> chartData = [
      ChartData('Suplementación', 25, const Color(0xff0D3A5C)),
      ChartData('Industriales', 21, const Color(0xffA2E6FA)),
      ChartData('Agroindustria', 14, const Color(0xffB9A8FF)),
      ChartData('Logística', 12, const Color(0xffAAE786)),
      ChartData('Oil & Gas', 10, const Color(0xff326A95)),
      ChartData('Inmobiliario', 9, const Color(0xff8066E8)),
      ChartData('Maquinarias', 9, const Color(0xff71DFFF)),
    ];
    const dataInvestGrafic = [
      {"x": "Ene 24", "y": 4.3},
      {"x": "Feb 24", "y": 4.5},
      {"x": "Mar 24", "y": 4.6},
    ];

    final List<Widget> itemsCarousel = [
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
      const InvestedCapitalV4(
        data: dataInvestGrafic,
        cardColorDark: 0xff0A2F4A,
        cardColorLight: 0xff0A2F4A,
        columnColorDark: 0xff104872,
        columnColorLight: 0xff104872,
      ),
      DistributionContainer(
        data: chartData,
      ),
    ];

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
      minimumLight: isSoles ? 0xffBBF0FF : 0xff0D3A5C,
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
      minimunTextColorDark: 0xffFFFFFF,
      minimumTextColorLight: isSoles ? 0xff000000 : 0xffFFFFFF,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleDetail(
          title: colors.titleText,
        ),
        const ObjectiveDetail(
          objective: objective,
        ),
        const SizedBox(
          height: 15,
        ),
        const Characteristics(
          characteristics: characteristics,
        ),
        const SizedBox(
          height: 15,
        ),
        const Divider(thickness: 2),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SwitchMoney(
                switchHeight: 30,
                switchWidth: 67,
              ),
            ],
          ),
        ),
        RowMinRent(
          colors: colors,
        ),
        CarrouselDetailV4(
          itemCarrousel: itemsCarousel,
        ),
      ],
    );
  }
}

class RowMinRent extends ConsumerWidget {
  const RowMinRent({
    super.key,
    required this.colors,
  });
  final ProductContainerStyles colors;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: RowProducts(
        isDarkMode: isDarkMode,
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
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextPoppins(
        text: title,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        lines: 2,
      ),
    );
  }
}
