import 'chart_master_model.dart';

class ChartDataModel {
  final ChartMasterData chartMasterData;
  final List<XY> dataList;

  ChartDataModel({required this.chartMasterData, required this.dataList});
}

class XY {
  final String x;
  final double y;

  XY({required this.x, required this.y});
}
