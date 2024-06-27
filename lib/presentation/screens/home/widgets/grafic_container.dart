import 'package:finniu/domain/entities/rentability_graph_entity.dart';
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
  List<RentabilityGraphEntity> data = [
    RentabilityGraphEntity(
      amountPoint: "1011.69",
      month: "Mayo",
    ),
    RentabilityGraphEntity(
      amountPoint: "1783.39",
      month: "Junio",
    ),
    RentabilityGraphEntity(
      amountPoint: "1901.78",
      month: "Julio",
    ),
    RentabilityGraphEntity(
      amountPoint: "2580.15",
      month: "Agosto",
    ),
    RentabilityGraphEntity(
      amountPoint: "3258.52",
      month: "Septiembre",
    ),
    RentabilityGraphEntity(
      amountPoint: "3936.89",
      month: "Octubre",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: const CategoryAxis(),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <CartesianSeries<RentabilityGraphEntity, String>>[
        LineSeries<RentabilityGraphEntity, String>(
          dataSource: data,
          xValueMapper: (RentabilityGraphEntity rentability, _) =>
              rentability.month.substring(0, 3),
          yValueMapper: (RentabilityGraphEntity rentability, _) =>
              double.parse(rentability.amountPoint),

          // Enable data label
        ),
      ],
    );
  }
}
