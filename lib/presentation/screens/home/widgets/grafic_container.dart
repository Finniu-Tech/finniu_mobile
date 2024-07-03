import 'package:finniu/constants/colors.dart';
import 'package:finniu/domain/entities/rentability_graph_entity.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/rentability_graph_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
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
      child: const GraficLinealWidget(),
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
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (rentabilityGraph.asData!.value.success == false) {}
    data = isSoles
        ? rentabilityGraph.asData!.value.rentabilityInPen
        : rentabilityGraph.asData!.value.rentabilityInUsd;

    return Stack(
      children: [
        SfCartesianChart(
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
                  rentability.month.substring(0, 3).toUpperCase(),
              yValueMapper: (RentabilityGraphEntity rentability, _) =>
                  double.parse(rentability.amountPoint) / 1000,
            ),
          ],
        ),
        rentabilityGraph.asData!.value.success == false
            ? Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: const Center(
                    child: Text('No hay datos'),
                  ),
                ),
              )
            : const SizedBox(),
        data?.isEmpty == true
            ? Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Center(
                    child: Text(
                      'No hay invesiones en ${isSoles ? 'soles' : 'dólares'}',
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        data?.isEmpty == true
            ? const SizedBox()
            : const Positioned(
                right: 10,
                top: 10,
                child: TimeLineSelect(),
              ),
      ],
    );
  }
}

class TimeLineSelect extends ConsumerWidget {
  const TimeLineSelect({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timePeriod = ref.watch(timePeriodProvider);
    final themeProvider = ref.watch(settingsNotifierProvider);

    return PopupMenuButton<TimePeriod>(
      onSelected: (TimePeriod selectedPeriod) {
        ref.read(timePeriodProvider.notifier).setTimePeriod(selectedPeriod);
      },
      itemBuilder: (BuildContext context) {
        return TimePeriod.values.map((TimePeriod period) {
          return PopupMenuItem<TimePeriod>(
            value: period,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Text(
                period.spanishValue,
                style: const TextStyle(fontSize: 12, fontFamily: "Poppins"),
              ),
            ),
          );
        }).toList();
      },
      child: Container(
        width: 93,
        height: 26,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: themeProvider.isDarkMode
              ? const Color(backgroudSelectDark)
              : const Color(backgroudSelectLight),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              timePeriod.spanishValue,
              style: const TextStyle(fontSize: 12, fontFamily: "Poppins"),
            ),
            SizedBox(
              height: 26,
              width: 26,
              child: Center(
                child: Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: themeProvider.isDarkMode
                      ? const Color(primaryLight)
                      : const Color(primaryDark),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
