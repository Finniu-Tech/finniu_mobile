import 'package:carousel_slider/carousel_slider.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/animated_number.dart';
import 'package:finniu/presentation/screens/catalog/widgets/carrousel_slide.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
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
