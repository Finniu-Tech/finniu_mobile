import 'package:flutter/material.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

/// Local imports

/// Renders the defaul spline chart sample.
class SplineDefault extends StatefulWidget {
  /// Creates the defaul spline chart Series.
  const SplineDefault();

  @override
  _SplineDefaultState createState() => _SplineDefaultState();
}

/// State class of the default spline chart.
class _SplineDefaultState extends State<SplineDefault> {
  _SplineDefaultState();

  @override
  void initState() {
    chartData = <ChartSampleData>[
      ChartSampleData(
        x: 'Enero',
        y: 43,
      ),
      ChartSampleData(
        x: 'Febrero',
        y: 45,
        secondSeriesYValue: 37,
        thirdSeriesYValue: 45,
      ),
      ChartSampleData(
        x: 'Marzo',
        y: 50,
        secondSeriesYValue: 39,
        thirdSeriesYValue: 48,
      ),
      ChartSampleData(
        x: 'Abril',
        y: 55,
        secondSeriesYValue: 43,
        thirdSeriesYValue: 52,
      ),
      ChartSampleData(
        x: 'Mayo',
        y: 63,
        secondSeriesYValue: 48,
        thirdSeriesYValue: 57,
      ),
      ChartSampleData(
        x: 'Junio',
        y: 68,
        secondSeriesYValue: 54,
        thirdSeriesYValue: 61,
      ),
      ChartSampleData(
        x: 'Julio',
        y: 72,
        secondSeriesYValue: 57,
        thirdSeriesYValue: 66,
      ),
      ChartSampleData(
        x: 'Agosto',
        y: 70,
        secondSeriesYValue: 57,
        thirdSeriesYValue: 66,
      ),
      ChartSampleData(
        x: 'Septiembre',
        y: 66,
        secondSeriesYValue: 54,
        thirdSeriesYValue: 63,
      ),
      ChartSampleData(
        x: 'Octubre',
        y: 57,
        secondSeriesYValue: 48,
        thirdSeriesYValue: 55,
      ),
      ChartSampleData(
        x: 'Noviembre',
        y: 50,
        secondSeriesYValue: 43,
        thirdSeriesYValue: 50,
      ),
      ChartSampleData(
        x: 'Diciembre',
        y: 45,
        secondSeriesYValue: 37,
        thirdSeriesYValue: 45,
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildDefaultSplineChart();
  }

  List<ChartSampleData>? chartData;

  /// Returns the defaul spline chart.
  SfCartesianChart _buildDefaultSplineChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: const ChartTitle(
        text: 'Spline Chart',
      ),
      legend: const Legend(isVisible: true),
      primaryXAxis: const CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
        labelPlacement: LabelPlacement.onTicks,
      ),
      primaryYAxis: const NumericAxis(
        minimum: 30,
        maximum: 80,
        axisLine: AxisLine(width: 0),
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        labelFormat: '\${value}K',
        majorTickLines: MajorTickLines(size: 0),
      ),
      series: _getDefaultSplineSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  /// Returns the list of chart series which need to render on the spline chart.
  List<SplineSeries<ChartSampleData, String>> _getDefaultSplineSeries() {
    return <SplineSeries<ChartSampleData, String>>[
      SplineSeries<ChartSampleData, String>(
        dataSource: chartData,
        xValueMapper: (ChartSampleData sales, _) =>
            sales.x.substring(0, 3) as String,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
      ),
    ];
  }

  @override
  void dispose() {
    chartData!.clear();
    super.dispose();
  }
}

class ChartSampleData {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleData({
    this.x,
    this.y,
    this.xValue,
    this.yValue,
    this.secondSeriesYValue,
    this.thirdSeriesYValue,
    this.pointColor,
    this.size,
    this.text,
    this.open,
    this.close,
    this.low,
    this.high,
    this.volume,
  });

  /// Holds x value of the datapoint
  final dynamic x;

  /// Holds y value of the datapoint
  final num? y;

  /// Holds x value of the datapoint
  final dynamic xValue;

  /// Holds y value of the datapoint
  final num? yValue;

  /// Holds y value of the datapoint(for 2nd series)
  final num? secondSeriesYValue;

  /// Holds y value of the datapoint(for 3nd series)
  final num? thirdSeriesYValue;

  /// Holds point color of the datapoint
  final Color? pointColor;

  /// Holds size of the datapoint
  final num? size;

  /// Holds datalabel/text value mapper of the datapoint
  final String? text;

  /// Holds open value of the datapoint
  final num? open;

  /// Holds close value of the datapoint
  final num? close;

  /// Holds low value of the datapoint
  final num? low;

  /// Holds high value of the datapoint
  final num? high;

  /// Holds open value of the datapoint
  final num? volume;
}
