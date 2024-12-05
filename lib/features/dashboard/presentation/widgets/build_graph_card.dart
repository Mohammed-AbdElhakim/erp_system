import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BuildGraphCard extends StatelessWidget {
  const BuildGraphCard(
      {super.key, required this.graphName, required this.graphValues});
  final String graphName;
  final Map<String, dynamic> graphValues;
  static const List<Color> colorPalette = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.yellow,
    Colors.pink,
    Colors.brown,
    Colors.cyan,
    Colors.indigo,
  ];

  @override
  Widget build(BuildContext context) {
    double containerWidth = graphValues.length * 40;
    return Container(
      width: containerWidth,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade300,
                offset: const Offset(1, 1),
                blurRadius: 1,
                spreadRadius: 1),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            graphName,
            style: TextStyle(color: Colors.blue),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  // maxY: 100,
                  // barTouchData: BarTouchData(enabled: true),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${value.toInt()}',
                            style: const TextStyle(
                                color: Colors.blue, fontSize: 10),
                          );
                        },
                        reservedSize: 50,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          List<String> bottomTitlesList =
                              graphValues.keys.toList();
                          return getBottomTitlesLabel(
                              value.toInt(), bottomTitlesList);
                        },
                        reservedSize: 80,
                      ),
                    ),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: List.generate(
                    graphValues.values.toList().length,
                    (index) => BarChartGroupData(x: index, barRods: [
                      BarChartRodData(
                          toY: graphValues.values.toList()[index],
                          color: colorPalette[index % colorPalette.length],
                          width: 8),
                    ], showingTooltipIndicators: [
                      0
                    ]),
                  ),
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: (touchedSpot) => Colors.grey.shade200,
                      tooltipPadding: EdgeInsets.zero,
                      tooltipMargin: 15,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          rod.toY.toStringAsFixed(2),
                          const TextStyle(color: Colors.blue, fontSize: 12),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getBottomTitlesLabel(int value, List<String> bottomTitles) {
    if (value >= 0 && value < bottomTitles.length) {
      return RotatedBox(
        quarterTurns: 3,
        child: Text(
          bottomTitles[value],
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.blue, fontSize: 10),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
