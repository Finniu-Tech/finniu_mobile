import 'package:carousel_slider/carousel_slider.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/constants/number_format.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CarrouselSlide extends StatelessWidget {
  const CarrouselSlide({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<dynamic> data = const [
      {"x": "Nov", "y": 10},
      {"x": "Dic", "y": 20},
      {"x": "Ene", "y": 30},
      {"x": "Feb", "y": 40},
      {"x": "Mar", "y": 50},
    ];
    final items = [
      const ManagedAssets(
        color: secondary,
        investmentsText: 5700,
      ),
      InvestedCapital(
        color: backgroundColorLight,
        data: data,
      ),
      const AnnualProfitability(
        color: colorProfitabilityCard,
        profitability: 7,
      ),
    ];
    return Container(
      color: const Color(backgroudCarousel),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: CarouselSlider(
        items: items,
        options: CarouselOptions(
          height: 341,
          enlargeCenterPage: true,
          aspectRatio: 16 / 9,
          viewportFraction: 0.8,
        ),
      ),
    );
  }
}

class AnnualProfitability extends StatelessWidget {
  final int profitability;
  final int color;
  const AnnualProfitability({
    super.key,
    required this.profitability,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SlideCarouselCard(
      color: color,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            "Rentabilidad",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "Utilidades generadas por las inversiones de capital de los inversores del Fondo",
            maxLines: 4,
            style: TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
          const Divider(
            height: 2,
            color: Color(primaryDark),
          ),
          Container(
            width: 245,
            decoration: const BoxDecoration(
              color: Color(annualCard),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Rentabilidad anualizada del \n último mes ",
                    style: TextStyle(fontSize: 11),
                    textAlign: TextAlign.left,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TweenAnimationBuilder(
                        tween: IntTween(begin: 0, end: profitability),
                        duration: const Duration(seconds: 1),
                        builder:
                            (BuildContext context, int value, Widget? child) {
                          return Text(
                            "${value.toString()}.0%",
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InvestedCapital extends StatelessWidget {
  final int color;
  final List<dynamic> data;
  const InvestedCapital({
    super.key,
    required this.data,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SlideCarouselCard(
      color: color,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            "Patrimonio neto (S/ MM)",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 200,
            child: SfCartesianChart(
              borderColor: Colors.transparent,
              series: [
                ColumnSeries(
                  color: const Color(primaryLight),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  dataSource: const [
                    {"x": "Nov", "y": 10},
                    {"x": "Dic", "y": 20},
                    {"x": "Ene", "y": 30},
                    {"x": "Feb", "y": 40},
                    {"x": "Mar", "y": 50},
                  ],
                  xValueMapper: (datum, index) => datum["x"],
                  yValueMapper: (datum, index) => datum["y"],
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                    labelAlignment: ChartDataLabelAlignment.auto,
                  ),
                  borderWidth: 0,
                ),
              ],
              primaryXAxis: const CategoryAxis(
                majorGridLines: MajorGridLines(width: 0),
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

class ManagedAssets extends ConsumerWidget {
  final int investmentsText;
  final int color;
  const ManagedAssets({
    super.key,
    required this.investmentsText,
    required this.color,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSoles = ref.watch(isSolesStateProvider);
    return SlideCarouselCard(
      color: color,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            "Activos administrados",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "Los activos administrados representan el valor de mercado de las inversiones del fondo",
            maxLines: 4,
            style: TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
          const Divider(
            height: 2,
            color: Color(primaryDark),
          ),
          const Text(
            "Activos administrados",
            style: TextStyle(fontSize: 11),
            textAlign: TextAlign.right,
          ),
          TweenAnimationBuilder(
            tween: IntTween(begin: 0, end: investmentsText),
            duration: const Duration(seconds: 2),
            builder: (BuildContext context, int value, Widget? child) {
              return Text(
                isSoles
                    ? formatterSoles.format(value)
                    : formatterUSD.format(value),
                style:
                    const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              );
            },
          ),
        ],
      ),
    );
  }
}

class SlideCarouselCard extends StatelessWidget {
  final int color;
  final Widget body;
  const SlideCarouselCard({
    super.key,
    required this.color,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(color),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: body,
      ),
    );
  }
}
