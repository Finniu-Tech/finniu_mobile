import 'package:finniu/domain/entities/rentability_graph_entity.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/rentability_graph_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
        ],
      ),
    );
  }
}

class GraficLinealWidget extends ConsumerStatefulWidget {
  const GraficLinealWidget({
    super.key,
  });

  @override
  ConsumerState<GraficLinealWidget> createState() => _GraficWidgetState();
}

class _GraficWidgetState extends ConsumerState<GraficLinealWidget> {
  @override
  void initState() {
    super.initState();
  }

  List<RentabilityGraphEntity>? data;
  @override
  Widget build(BuildContext context) {
    final isSoles = ref.watch(isSolesStateProvider);
    final rentabilityGraph = ref.watch(rentabilityGraphFutureProvider);
    if (rentabilityGraph.asData == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    data = isSoles
        ? rentabilityGraph.asData!.value.rentabilityInPen
        : rentabilityGraph.asData!.value.rentabilityInUsd;

    return SfCartesianChart(
      borderWidth: 5,
      plotAreaBorderWidth: 0,
      primaryXAxis: const CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
        labelPlacement: LabelPlacement.onTicks,
      ),
      primaryYAxis: NumericAxis(
        labelFormat: isSoles ? 'S/{value}K' : '\${value}K',
        axisLine: const AxisLine(width: 0),
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <CartesianSeries<RentabilityGraphEntity, String>>[
        LineSeries<RentabilityGraphEntity, String>(
          dataSource: data,
          xValueMapper: (RentabilityGraphEntity rentability, _) =>
              rentability.month.substring(0, 3),
          yValueMapper: (RentabilityGraphEntity rentability, _) =>
              double.parse(rentability.amountPoint),
        ),
      ],
    );
  }
}
