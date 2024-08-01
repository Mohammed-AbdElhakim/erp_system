import 'package:flutter/material.dart';

import '../../data/models/chart_data_model.dart';
import 'area_chart.dart';
import 'bar_chart.dart';
import 'column_chart.dart';
import 'doughnut_chart.dart';
import 'line_chart.dart';
import 'pie_chart.dart';
import 'radial_bar_chart.dart';

class Chart extends StatefulWidget {
  const Chart({super.key, required this.chartDataModel});
  final ChartDataModel chartDataModel;

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  ChartType chartType = ChartType.column;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Card(
        color: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Row(
                  children: [
                    Text(widget.chartDataModel.chartMasterData.arName!),
                    const Spacer(),
                    PopupMenuButton(
                      onSelected: (value) {
                        setState(() {
                          chartType = value;
                        });
                      },
                      itemBuilder: (BuildContext context) => listMenu,
                    ),
                  ],
                ),
              ),
              if (chartType == ChartType.column)
                ColumnChart(chartDataModel: widget.chartDataModel),
              if (chartType == ChartType.bar)
                BarChart(chartDataModel: widget.chartDataModel),
              if (chartType == ChartType.area)
                AreaChart(chartDataModel: widget.chartDataModel),
              if (chartType == ChartType.line)
                LineChart(chartDataModel: widget.chartDataModel),
              if (chartType == ChartType.pie)
                PieChart(chartDataModel: widget.chartDataModel),
              if (chartType == ChartType.doughnut)
                DoughnutChart(chartDataModel: widget.chartDataModel),
              if (chartType == ChartType.radialBar)
                RadialBarChart(chartDataModel: widget.chartDataModel),
            ],
          ),
        ),
      ),
    );
  }

  List<PopupMenuEntry<ChartType>> listMenu = const [
    PopupMenuItem(
      value: ChartType.column,
      child: Text("Column"),
    ),
    PopupMenuItem(
      value: ChartType.bar,
      child: Text("Bar"),
    ),
    PopupMenuItem(
      value: ChartType.area,
      child: Text("Area"),
    ),
    PopupMenuItem(
      value: ChartType.line,
      child: Text("Line"),
    ),
    PopupMenuItem(
      value: ChartType.pie,
      child: Text("Pie"),
    ),
    PopupMenuItem(
      value: ChartType.doughnut,
      child: Text("Doughnut"),
    ),
    PopupMenuItem(
      value: ChartType.radialBar,
      child: Text("Radial bar"),
    ),
  ];
}

enum ChartType { column, bar, area, line, pie, doughnut, radialBar }
