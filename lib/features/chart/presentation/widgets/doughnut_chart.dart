import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../data/models/chart_data_model.dart';

class DoughnutChart extends StatefulWidget {
  const DoughnutChart({super.key, required this.chartDataModel});
  final ChartDataModel chartDataModel;

  @override
  State<DoughnutChart> createState() => _DoughnutChartState();
}

class _DoughnutChartState extends State<DoughnutChart> {
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
    return SfCircularChart(
      tooltipBehavior: _tooltip,
      legend: Legend(
        isVisible: true,
        overflowMode: LegendItemOverflowMode.wrap,
        shouldAlwaysShowScrollbar: true,
        padding: 0,
      ),
      series: <CircularSeries>[
        DoughnutSeries<XY, String>(
          dataSource: data,
          pointColorMapper: (XY dat, _) => getMyColor(data.indexOf(dat)),
          xValueMapper: (XY data, _) => data.x,
          yValueMapper: (XY data, _) => data.y,
          dataLabelSettings: DataLabelSettings(isVisible: true),
          enableTooltip: true,
        )
      ],
    );
  }

  getMyColor(int indexOf) {
    switch (indexOf) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.grey;
      case 2:
        return Colors.cyan;
      case 3:
        return Colors.cyanAccent;
      case 4:
        return Colors.purple;
      case 5:
        return Colors.yellow;
      case 6:
        return Colors.blueAccent;
      case 7:
        return Colors.red;
      case 8:
        return Colors.pinkAccent;
      case 9:
        return Colors.amber;
      case 10:
        return Colors.brown;
      case 11:
        return Colors.deepOrange;
      case 12:
        return Colors.orange;
      case 13:
        return Colors.lime;
      case 14:
        return Colors.blue;
    }
  }
}
