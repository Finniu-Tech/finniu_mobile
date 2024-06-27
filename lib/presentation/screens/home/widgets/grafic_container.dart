import 'package:finniu/domain/entities/rentability_graph_entity.dart';
import 'package:finniu/presentation/screens/home/widgets/grafic/default_line_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      child: const Column(
        children: [
          GraficLinealWidget(),
          SplineDefault(),
        ],
      ),
    );
  }
}

class GraficLinealWidget extends StatefulWidget {
  const GraficLinealWidget({
    super.key,
  });

  @override
  State<GraficLinealWidget> createState() => _GraficWidgetState();
}

class _GraficWidgetState extends State<GraficLinealWidget> {
  @override
  void initState() {
    data = [
      RentabilityGraphEntity(
        amountPoint: "1",
        month: "Mayo",
      ),
      RentabilityGraphEntity(
        amountPoint: "1.7",
        month: "Junio",
      ),
      RentabilityGraphEntity(
        amountPoint: "1.9",
        month: "Julio",
      ),
      RentabilityGraphEntity(
        amountPoint: "2.5",
        month: "Agosto",
      ),
      RentabilityGraphEntity(
        amountPoint: "3.2",
        month: "Septiembre",
      ),
      RentabilityGraphEntity(
        amountPoint: "3.9",
        month: "Octubre",
      ),
    ];
    super.initState();
  }

  List<RentabilityGraphEntity>? data;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: const CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
        labelPlacement: LabelPlacement.onTicks,
      ),
      primaryYAxis: const NumericAxis(
        labelFormat: '\${value}K',
        axisLine: AxisLine(width: 0),
      ),
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
