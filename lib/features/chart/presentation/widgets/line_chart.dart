import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../data/models/chart_data_model.dart';

class LineChart extends StatefulWidget {
  const LineChart({super.key, required this.chartDataModel});
  final ChartDataModel chartDataModel;

  @override
  State<LineChart> createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {
  late List<XY> data;
  late TooltipBehavior _tooltip;
  @override
  void initState() {
    data = widget.chartDataModel.dataList;
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: const CategoryAxis(
        labelRotation: -50,
        edgeLabelPlacement: EdgeLabelPlacement.shift,
      ),
      primaryYAxis: NumericAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift,
      ),
      tooltipBehavior: _tooltip,
      legend: Legend(
        isVisible: true,
        overflowMode: LegendItemOverflowMode.wrap,
        shouldAlwaysShowScrollbar: true,
        padding: 0,
      ),
      series: <CartesianSeries<XY, String>>[
        LineSeries<XY, String>(
          dataSource: data,
          xValueMapper: (XY data, _) => data.x,
          yValueMapper: (XY data, _) => data.y,
          name: widget.chartDataModel.chartMasterData.arName,
          color: const Color.fromRGBO(255, 193, 206, 1.0),
          dataLabelSettings: DataLabelSettings(isVisible: true),
          enableTooltip: true,
        ),
      ],
    );
  }
}
