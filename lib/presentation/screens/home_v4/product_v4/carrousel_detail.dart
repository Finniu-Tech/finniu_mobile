import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/animated_number.dart';
import 'package:finniu/presentation/screens/catalog/widgets/carrousel_slide.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CarrouselDetailV4 extends ConsumerWidget {
  const CarrouselDetailV4({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSoles = ref.watch(isSolesStateProvider);
    final data = [
      {"x": "Ene 24", "y": 4.3},
      {"x": "Feb 24", "y": 4.5},
      {"x": "Mar 24", "y": 4.6},
    ];
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
      InvestedCapitalV4(
        data: data,
        cardColorDark: 0xff0A2F4A,
        cardColorLight: 0xff0A2F4A,
        columnColorDark: 0xff104872,
        columnColorLight: 0xff104872,
      ),
      const DistributionContainer(),
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

class ChartData {
  final String category;
  final double value;
  final Color color;

  ChartData(this.category, this.value, this.color);
}

class DistributionContainer extends HookConsumerWidget {
  const DistributionContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final PageController pageController = usePageController();
    final currentPage = useState(0);

    final List<ChartData> chartData = [
      ChartData('Suplementación', 25, const Color(0xff0D3A5C)),
      ChartData('Industriales', 21, const Color(0xffA2E6FA)),
      ChartData('Agroindustria', 14, const Color(0xffB9A8FF)),
      ChartData('Logística', 12, const Color(0xffAAE786)),
      ChartData('Oil & Gas', 10, const Color(0xff326A95)),
      ChartData('Inmobiliario', 9, const Color(0xff8066E8)),
      ChartData('Maquinarias', 9, const Color(0xff71DFFF)),
    ];
    useEffect(
      () {
        final timer = Timer.periodic(const Duration(seconds: 3), (timer) {
          if (currentPage.value < chartData.length - 1) {
            currentPage.value++;
          } else {
            currentPage.value = 0;
          }

          pageController.animateToPage(
            currentPage.value,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        });
        return timer.cancel;
      },
      [],
    );

    return Stack(
      alignment: Alignment.center,
      children: [
        SlideCarouselCard(
          color: isDarkMode ? 0xff1B1B1B : 0xffDCF5FC,
          body: SfCircularChart(
            series: <CircularSeries>[
              DoughnutSeries<ChartData, String>(
                dataSource: chartData,
                xValueMapper: (ChartData data, _) => data.category,
                yValueMapper: (ChartData data, _) => data.value,
                pointColorMapper: (ChartData data, _) => data.color,
                innerRadius: '70%',
                dataLabelSettings: const DataLabelSettings(
                  isVisible: false,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 150,
          child: PageView(
            controller: pageController,
            children: chartData.map((e) {
              return SizedBox(
                width: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextPoppins(
                      text: "${e.value}%",
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      textDark: 0xffFFFFFF,
                      textLight: 0xff000000,
                    ),
                    TextPoppins(
                      text: e.category,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      textDark: 0xffFFFFFF,
                      textLight: 0xff000000,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        const Positioned(
          top: 30,
          child: TextPoppins(
            text: "Distribución",
            fontSize: 16,
            fontWeight: FontWeight.w500,
            textDark: 0xffFFFFFF,
            textLight: 0xff000000,
          ),
        ),
      ],
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

class InvestedCapitalV4 extends ConsumerWidget {
  final List<dynamic> data;
  const InvestedCapitalV4({
    super.key,
    required this.data,
    required this.cardColorLight,
    required this.cardColorDark,
    required this.columnColorDark,
    required this.columnColorLight,
  });
  final int cardColorLight;
  final int cardColorDark;
  final int columnColorDark;
  final int columnColorLight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return SlideCarouselCard(
      color: isDarkMode ? cardColorDark : cardColorLight,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const TextPoppins(
            text: "Patrimonio neto (S/ MM)",
            fontSize: 16,
            fontWeight: FontWeight.w500,
            textDark: 0xffFFFFFF,
            textLight: 0xffFFFFFF,
          ),
          SizedBox(
            height: 170,
            child: SfCartesianChart(
              borderWidth: 0,
              borderColor: Colors.transparent,
              series: [
                ColumnSeries(
                  color: Color(isDarkMode ? columnColorDark : columnColorLight),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  dataSource: data,
                  xValueMapper: (datum, index) => datum["x"],
                  yValueMapper: (datum, index) => datum["y"],
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                    labelAlignment: ChartDataLabelAlignment.auto,
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  borderWidth: 0,
                ),
              ],
              primaryXAxis: const CategoryAxis(
                majorGridLines: MajorGridLines(width: 0),
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              primaryYAxis: const CategoryAxis(
                majorGridLines: MajorGridLines(width: 0),
                isVisible: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
