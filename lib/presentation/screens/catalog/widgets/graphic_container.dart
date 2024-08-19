import 'package:finniu/constants/colors.dart';
import 'package:finniu/domain/entities/fund_entity.dart';
import 'package:finniu/domain/entities/rentability_graph_entity.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/rentability_graphic_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphicContainer extends ConsumerWidget {
  final FundEntity? fund;
  GraphicContainer({
    super.key,
    this.fund,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: const Color(borderColorGray), width: 1),
        color: currentTheme.isDarkMode ? const Color(backGroundColorGraphContainer) : Colors.white,
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: GraphicLinealWidget(fund: fund),
    );
  }
}

class GraphicLinealWidget extends ConsumerStatefulWidget {
  final FundEntity? fund;
  const GraphicLinealWidget({
    super.key,
    this.fund,
  });

  @override
  ConsumerState<GraphicLinealWidget> createState() => _GraphicWidgetState();
}

class _GraphicWidgetState extends ConsumerState<GraphicLinealWidget> {
  @override
  void initState() {
    super.initState();
  }

  List<RentabilityGraphicEntity>? data;
  @override
  Widget build(BuildContext context) {
    final isSoles = ref.watch(isSolesStateProvider);
    final timeLine = ref.watch(timePeriodProvider);
    final rentabilityParams = RentabilityParamsProvider(timeline: timeLine.value, fundUUID: widget.fund?.uuid ?? '');
    final rentabilityGraph = ref.watch(rentabilityGraphicFutureProvider(rentabilityParams).select((value) => value));

    //add a future builder
    return rentabilityGraph.when(
      data: (data) {
        return Stack(
          children: [
            SfCartesianChart(
              borderWidth: 5,
              plotAreaBorderWidth: 0,
              primaryXAxis: const CategoryAxis(
                majorGridLines: MajorGridLines(width: 0),
                labelPlacement: LabelPlacement.onTicks,
                plotOffset: 10,
              ),
              primaryYAxis: NumericAxis(
                labelFormat: isSoles ? 'S/{value}K' : '\${value}K',
                axisLine: const AxisLine(width: 0),
              ),
              tooltipBehavior: TooltipBehavior(
                enable: true,
                duration: 1000,
                header: "",
              ),
              series: <CartesianSeries<RentabilityGraphicEntity, String>>[
                LineSeries<RentabilityGraphicEntity, String>(
                  color: const Color(primaryLight),
                  dataSource: isSoles ? data.rentabilityInPen : data.rentabilityInUsd,
                  xValueMapper: (RentabilityGraphicEntity rentability, _) =>
                      rentability.month.substring(0, 3).toUpperCase(),
                  yValueMapper: (RentabilityGraphicEntity rentability, _) =>
                      double.parse(rentability.amountPoint) / 1000,
                  markerSettings: const MarkerSettings(
                    isVisible: true,
                    shape: DataMarkerType.circle,
                    borderColor: Color(graphicMarker),
                    borderWidth: 2,
                    color: Color(graphicMarker),
                  ),
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
                        child: Text(''),
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
                          'No hay inversiones en ${isSoles ? 'soles' : 'dólares'}',
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
      },
      error: (error, stackTrace) {
        return const Center(
          child: Text('Error'),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
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
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    return PopupMenuButton<TimePeriod>(
      onSelected: (TimePeriod selectedPeriod) {
        ref.read(timePeriodProvider.notifier).setTimePeriod(selectedPeriod);
      },
      itemBuilder: (BuildContext context) {
        return TimePeriod.values.reversed.map((TimePeriod period) {
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
          color: isDarkMode ? const Color(backgroundSelectDark) : const Color(backgroundSelectLight),
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
                  color: isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
