import 'dart:async';

import 'package:finniu/constants/colors/product_v4_colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/animated_number.dart';
import 'package:finniu/presentation/screens/catalog/widgets/carrousel_slide.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DistributionContainer extends HookConsumerWidget {
  const DistributionContainer({super.key, required this.data});
  final List<ChartData> data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final PageController pageController = usePageController();
    final currentPage = useState(0);

    const int cardDark = 0xff1B1B1B;
    const int cardLight = 0xffDCF5FC;
    const int textDark = 0xffFFFFFF;
    const int textLight = 0xff000000;

    useEffect(
      () {
        final timer = Timer.periodic(const Duration(seconds: 3), (timer) {
          if (currentPage.value < data.length - 1) {
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
          color: isDarkMode ? cardDark : cardLight,
          body: SfCircularChart(
            series: <CircularSeries>[
              DoughnutSeries<ChartData, String>(
                dataSource: data,
                xValueMapper: (ChartData data, _) => data.category,
                yValueMapper: (ChartData data, _) => data.value,
                pointColorMapper: (ChartData data, _) => data.color,
                innerRadius: '70%',
                dataLabelSettings: const DataLabelSettings(
                  isVisible: false,
                ),
                selectionBehavior: SelectionBehavior(
                  enable: true,
                  selectedBorderWidth: 2,
                  selectedBorderColor: Colors.black,
                ),
                initialSelectedDataIndexes: [currentPage.value],
              ),
            ],
          ),
        ),
        SizedBox(
          width: 150,
          child: PageView(
            controller: pageController,
            onPageChanged: (index) {
              currentPage.value = index;
            },
            children: data.map((e) {
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
                      textDark: textDark,
                      textLight: textLight,
                    ),
                    TextPoppins(
                      text: e.category,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      textDark: textDark,
                      textLight: textLight,
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
            textDark: textDark,
            textLight: textLight,
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
          TextPoppins(
            text: "Activos administrados",
            fontSize: 16,
            fontWeight: FontWeight.w500,
            textDark: numberColorDark,
            textLight: numberColorLight,
          ),
          TextPoppins(
            text:
                "Los activos administrados representan el valor de mercado de las inversiones del fondo",
            fontSize: 13,
            lines: 4,
            textDark: numberColorDark,
            textLight: numberColorLight,
          ),
          Divider(
            height: 2,
            color: Color(
              isDarkMode ? dividerColorDark : dividerColorLight,
            ),
          ),
          TextPoppins(
            text: "Activos administrados",
            fontSize: 11,
            textDark: numberColorDark,
            textLight: numberColorLight,
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
