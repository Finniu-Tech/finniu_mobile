import 'package:finniu/constants/colors/product_v4_colors.dart';
import 'package:finniu/domain/entities/fund_entity.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/catalog/widgets/verify_identity.dart';
import 'package:finniu/presentation/screens/home_v4/product_v4/app_bar_product.dart';
import 'package:finniu/presentation/screens/home_v4/product_v4/carrousel_detail.dart';
import 'package:finniu/presentation/screens/home_v4/product_v4/item_carrousel.dart';
import 'package:finniu/presentation/screens/home_v4/products_v4/row_products.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ProductDetailV4 extends ConsumerWidget {
  const ProductDetailV4({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int colorDark = 0xff000000;
    const int colorLight = 0xffFFFFFF;
    return Scaffold(
      backgroundColor: isDarkMode ? const Color(colorDark) : const Color(colorLight),
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

  List<Map<String, dynamic>> getInvestmentGraphData(List<FundNetWorthEntity>? netWorths) {
    if (netWorths == null) return [];

    return netWorths.map((netWorth) {
      // Parsear la fecha string a DateTime
      final date = DateTime.parse(netWorth.date);

      // Crear el formateador
      final formatter = DateFormat('MMM yy', 'es');

      // Formatear la fecha y capitalizar la primera letra
      String formattedDate = formatter.format(date);
      formattedDate = formattedDate[0].toUpperCase() + formattedDate.substring(1);

      return {
        "x": formattedDate, // "Ene 24"
        "y": netWorth.value,
      };
    }).toList();
  }

  int parseMoneyString(String? moneyString) {
    if (moneyString == null || moneyString.isEmpty) return 0;

    // Remover todos los caracteres no numéricos excepto punto y coma
    String cleanString = moneyString.replaceAll(RegExp(r'[^0-9.,]'), '');

    // Remover comas
    cleanString = cleanString.replaceAll(',', '');

    // Si hay punto decimal, tomar solo la parte entera
    if (cleanString.contains('.')) {
      cleanString = cleanString.split('.')[0];
    }

    // Convertir a entero
    return int.tryParse(cleanString) ?? 0;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ModalRoute.of(context)!.settings.arguments as ProductData;
    final isSoles = ref.watch(isSolesStateProvider);
    final String objective = product.objetiveText ?? '';
    // const String objective =
    //     "Inversión en préstamos para capital de trabajo o desarrollo de proyectos en empresas que pertenecen al portafolio diversificado de Finniu.";
    // const List<String> characteristics = [
    //   "Rentabilidad hasta 17% y 19% anual",
    //   "Portafolio diversificado de empresas de sectores con alta demanda",
    //   "Pago de rentabilidades mensuales.",
    //   "Plazo de inversión desde 6 meses",
    //   "Riesgo: Moderado",
    // ];
    final List<String> characteristics = product.features!.map((e) => e.title).toList();
    final List<ChartData> chartData = [
      ChartData('Suplementación', 25, const Color(0xff0D3A5C)),
      ChartData('Industriales', 21, const Color(0xffA2E6FA)),
      ChartData('Agroindustria', 14, const Color(0xffB9A8FF)),
      ChartData('Logística', 12, const Color(0xffAAE786)),
      ChartData('Oil & Gas', 10, const Color(0xff326A95)),
      ChartData('Inmobiliario', 9, const Color(0xff8066E8)),
      ChartData('Maquinarias', 9, const Color(0xff71DFFF)),
    ];
    // const dataInvestGrafic = [
    //   {"x": "Ene 24", "y": 4.3},
    //   {"x": "Feb 24", "y": 4.5},
    //   {"x": "Mar 24", "y": 4.6},
    // ];
    final dynamic dataInvestGrafic = getInvestmentGraphData(product.netWorths);

    final List<Widget> itemsCarousel = [
      ManagedAssetsV4(
        investmentsText: parseMoneyString(product.assetsUnderManagement),
        cardColorDark: 0xFFB9A8FF,
        cardColorLight: 0xFFB9A8FF,
        dividerColorDark: 0xFF8066E8,
        dividerColorLight: 0xFF8066E8,
        numberColorDark: 0xFF000000,
        numberColorLight: 0xFF000000,
        isSoles: isSoles,
      ),
      InvestedCapitalV4(
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

    Future<void> onPressCall() async {
      Navigator.pushNamed(context, '/v4/push_to_url', arguments: 'https://calendly.com/finniumeet/30min?month=2024-12');
      // final meetUrl =
      //     Uri.parse('https://calendly.com/finniumeet/30min?month=2024-12');
      // await launchUrl(meetUrl);
    }

    void onPressSimulator() {
      Navigator.pushNamedAndRemoveUntil(context, '/v4/step_one', arguments: product, (route) => false);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            // height: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TitleDetail(
                  title: product.titleText,
                ),
                const SizedBox(
                  height: 15,
                ),
                ObjectiveDetail(
                  objective: objective,
                ),
                const SizedBox(
                  height: 15,
                ),
                Characteristics(
                  characteristics: characteristics,
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: const Divider(thickness: 2, color: Colors.grey),
          ),
        ),
        // const Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: [
        //       SwitchMoney(
        //         switchHeight: 30,
        //         switchWidth: 67,
        //       ),
        //     ],
        //   ),
        // ),
        RowMinRent(
          product: product,
        ),
        CarrouselDetailV4(
          itemCarrousel: itemsCarousel,
        ),
        const SizedBox(
          height: 15,
        ),
        RowButtons(
          onPressCall: onPressCall,
          onPressSimulator: onPressSimulator,
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}

class RowButtons extends ConsumerWidget {
  const RowButtons({
    super.key,
    required this.onPressCall,
    required this.onPressSimulator,
  });
  final Function() onPressCall;
  final Function() onPressSimulator;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int callButtonDark = 0xff252525;
    const int callButtonLight = 0xffA2E6FA;
    const int simulatorButtonDark = 0xffA2E6FA;
    const int simulatorButtonLight = 0xff0D3A5C;
    const int callTextDark = 0xffA2E6FA;
    const int callTextLight = 0xff0A2E4A;
    const int simulatorTextDark = 0xff0D3A5C;
    const int simulatorTextLight = 0xffFFFFFF;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onPressCall,
          child: Container(
            width: 155,
            height: 40,
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(callButtonDark) : const Color(callButtonLight),
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextPoppins(
                  text: "Agendar",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  textDark: callTextDark,
                  textLight: callTextLight,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.video_call_outlined,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: onPressSimulator,
          child: Container(
            width: 155,
            height: 40,
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(simulatorButtonDark) : const Color(simulatorButtonLight),
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: const Center(
              child: TextPoppins(
                text: "Simular",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                textDark: simulatorTextDark,
                textLight: simulatorTextLight,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class RowMinRent extends ConsumerWidget {
  const RowMinRent({
    super.key,
    required this.product,
  });
  final ProductData product;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final isSoles = ref.watch(isSolesStateProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: RowProducts(
        isSoles: isSoles,
        isDarkMode: isDarkMode,
        minimumDark: product.style.minimumDark,
        minimumLight: product.style.minimumLight,
        minimunText: isSoles ? product.minimumTextPEN! : product.minimumTextUSD!,
        profitabilityDark: product.style.profitabilityDark,
        profitabilityLight: product.style.profitabilityLight,
        profitabilityText: isSoles ? product.profitabilityText! : product.profitabilityTextUSD!,
        textDark: product.style.textDark,
        textLight: product.style.textLight,
        minimunTextColorDark: product.style.minimunTextColorDark,
        minimumTextColorLight: product.style.minimumTextColorLight,
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
        fontSize: 22,
        fontWeight: FontWeight.w700,
        lines: 2,
      ),
    );
  }
}
