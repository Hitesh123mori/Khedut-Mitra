import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/chart_data.dart';

class LineChartWidget extends StatelessWidget {

  final List<ChartData> data;
  final Color lineColor;
  final Color markerColor;
  final Color backgroundColor;
  final Color gridLineColor;
  final double lineWidth;
  final String xAxisTitle;
  final String yAxisTitle;

  LineChartWidget({
    required this.data,
    this.lineColor = Colors.blueAccent,
    this.markerColor = Colors.red,
    this.backgroundColor = Colors.white,
    this.gridLineColor = Colors.grey,
    this.lineWidth = 2.0,
    this.xAxisTitle = 'X Axis',
    this.yAxisTitle = 'Y Axis',
  });

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      backgroundColor: backgroundColor,
      primaryXAxis: NumericAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        title: AxisTitle(text: xAxisTitle),
        majorGridLines: MajorGridLines(color: gridLineColor),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(text: yAxisTitle),
        majorGridLines: MajorGridLines(color: gridLineColor),
      ),
      series: <LineSeries<ChartData, double>>[
        LineSeries<ChartData, double>(
          dataSource: data,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          color: lineColor,
          width: lineWidth,
          markerSettings: MarkerSettings(
            isVisible: true,
            color: markerColor,
            shape: DataMarkerType.circle,
          ),
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            textStyle: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}

class LineChartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Enhanced Line Chart Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(

            child: LineChartWidget(
              data: getChartData(),
              lineColor: Colors.green,
              markerColor: Colors.blue,
              backgroundColor: Colors.lightBlue.shade50,
              gridLineColor: Colors.lightGreen,
              lineWidth: 3.0,
              xAxisTitle: 'Time (s)',
              yAxisTitle: 'Value',
            ),
          ),
        ),
      ),
    );
  }

  List<ChartData> getChartData() {
    return [
      ChartData(0, 3),
      ChartData(1, 2),
      ChartData(2, 5),
      ChartData(3, 2.5),
      ChartData(4, 4),
      ChartData(5, 3),
      ChartData(6, 4),
    ];
  }
}

void main() => runApp(LineChartApp());
