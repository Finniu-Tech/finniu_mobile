import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraficContainer extends StatelessWidget {
  const GraficContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: const Color(0xFF828282), width: 1),
      ),
      width: MediaQuery.of(context).size.width,
      height: 232,
      child: const GraficWidget(),
    );
  }
}

class GraficWidget extends StatefulWidget {
  const GraficWidget({
    super.key,
  });

  @override
  State<GraficWidget> createState() => _GraficWidgetState();
}

class _GraficWidgetState extends State<GraficWidget> {
  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40),
  ];
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: const CategoryAxis(),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <CartesianSeries<_SalesData, String>>[
        LineSeries<_SalesData, String>(
          dataSource: data,
          xValueMapper: (_SalesData sales, _) => sales.year,
          yValueMapper: (_SalesData sales, _) => sales.sales,

          // Enable data label
        ),
      ],
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
