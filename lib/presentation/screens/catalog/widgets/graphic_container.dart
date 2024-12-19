import 'dart:math';

import 'package:finniu/constants/colors.dart';
import 'package:finniu/domain/entities/fund_entity.dart';
import 'package:finniu/domain/entities/rentability_graph_entity.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/rentability_graphic_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/non_investmenr.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphicContainer extends ConsumerWidget {
  final FundEntity? fund;
  const GraphicContainer({super.key, this.fund});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: const Color(borderColorGray), width: 1),
        color: currentTheme.isDarkMode
            ? const Color(backGroundColorGraphContainer)
            : Colors.white,
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: GraphicLinealWidget(fund: fund),
    );
  }
}

class GraphicLinealWidget extends ConsumerStatefulWidget {
  final FundEntity? fund;
  const GraphicLinealWidget({super.key, this.fund});

  @override
  ConsumerState<GraphicLinealWidget> createState() => _GraphicWidgetState();
}

class _GraphicWidgetState extends ConsumerState<GraphicLinealWidget> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  String formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    final formatter = DateFormat('MMM-yyyy', 'es_ES');
    String formattedDate = formatter.format(date);
    // Capitalizar la primera letra del mes
    return formattedDate[0].toUpperCase() + formattedDate.substring(1);
  }

  List<RentabilityGraphicEntity> sortAndFormatData(
      List<RentabilityGraphicEntity> data) {
    data.sort(
        (a, b) => DateTime.parse(a.date!).compareTo(DateTime.parse(b.date!)));
    return data
        .map((item) => RentabilityGraphicEntity(
              date: item.date,
              month: formatDate(item.date!),
              amountPoint: item.amountPoint,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final isSoles = ref.watch(isSolesStateProvider);
    final timeLine = ref.watch(timePeriodProvider);
    final rentabilityParams = RentabilityParamsProvider(
        timeline: timeLine.value, fundUUID: widget.fund?.uuid ?? '');
    final rentabilityGraph = ref.watch(
        rentabilityGraphicFutureProvider(rentabilityParams)
            .select((value) => value));

    return rentabilityGraph.when(
      data: (data) {
        final chartData = sortAndFormatData(isSoles
            ? data.rentabilityInPen ?? []
            : data.rentabilityInUsd ?? []);

        final lenghtData = isSoles
            ? data.rentabilityInPen?.length ?? 0
            : data.rentabilityInUsd?.length ?? 0;

        final chartWidth =
            max(MediaQuery.of(context).size.width, lenghtData * 80.0);

        return Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              child: SizedBox(
                width: chartWidth.toDouble(),
                child: SfCartesianChart(
                  borderWidth: 5,
                  plotAreaBorderWidth: 0,
                  // primaryXAxis: const CategoryAxis(
                  //   majorGridLines: MajorGridLines(width: 0),
                  //   labelPlacement: LabelPlacement.onTicks,
                  //   plotOffset: 10,
                  // ),
                  primaryXAxis: const CategoryAxis(
                    majorGridLines: MajorGridLines(width: 0),
                    labelPlacement: LabelPlacement.onTicks,
                    labelStyle: TextStyle(fontSize: 10),
                  ),

                  primaryYAxis: NumericAxis(
                    labelFormat: isSoles ? 'S/{value}' : '\${value}',
                    axisLine: const AxisLine(width: 0),
                  ),
                  tooltipBehavior: TooltipBehavior(
                    enable: true,
                    duration: 3000,
                    header: "",
                  ),
                  series: <CartesianSeries<RentabilityGraphicEntity, String>>[
                    LineSeries<RentabilityGraphicEntity, String>(
                      color: const Color(primaryLight),
                      dataSource: chartData,
                      // xValueMapper: (RentabilityGraphicEntity rentability, _) => rentability.month.toUpperCase(),
                      xValueMapper: (RentabilityGraphicEntity rentability, _) =>
                          formatDate(rentability.date!),
                      yValueMapper: (RentabilityGraphicEntity rentability, _) =>
                          double.parse(rentability.amountPoint),
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
              ),
            ),
            if (rentabilityGraph.asData!.value.success == false)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: const Center(child: Text('')),
                ),
              ),
            if (chartData.isEmpty)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: const Center(
                    child: NonInvestmentContainer(),
                  ),
                ),
              ),
            if (chartData.isNotEmpty)
              const Positioned(
                right: 10,
                top: 10,
                child: TimeLineSelect(),
              ),
          ],
        );
      },
      error: (error, stackTrace) => const Center(child: Text('Error')),
      loading: () => const Center(child: CircularProgressIndicator()),
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
          color: isDarkMode
              ? const Color(backgroundSelectDark)
              : const Color(backgroundSelectLight),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              timePeriod.spanishValue,
              style: const TextStyle(fontSize: 11, fontFamily: "Poppins"),
            ),
            SizedBox(
              height: 26,
              width: 26,
              child: Center(
                child: Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: isDarkMode
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
