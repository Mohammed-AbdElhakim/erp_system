import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../data/models/xy.dart';

class BarChart extends StatefulWidget {
  const BarChart({super.key, required this.dataList, required this.title});
  final List<XY> dataList;
  final String title;

  @override
  State<BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  late TooltipBehavior _tooltip;
  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: const CategoryAxis(
        labelRotation: 0,
        edgeLabelPlacement: EdgeLabelPlacement.shift,
      ),
      primaryYAxis: const NumericAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift,
      ),
      tooltipBehavior: _tooltip,
      legend: const Legend(
        isVisible: true,
        overflowMode: LegendItemOverflowMode.wrap,
        shouldAlwaysShowScrollbar: true,
        padding: 0,
      ),
      series: <CartesianSeries<XY, String>>[
        BarSeries<XY, String>(
          dataSource: widget.dataList,
          xValueMapper: (XY data, _) => data.x,
          yValueMapper: (XY data, _) => data.y,
          name: widget.title,
          color: const Color.fromRGBO(255, 193, 206, 1.0),
          dataLabelSettings: const DataLabelSettings(isVisible: true),
          enableTooltip: true,
        ),
      ],
    );
  }
}
