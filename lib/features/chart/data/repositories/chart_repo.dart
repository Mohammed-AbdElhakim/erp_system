import 'package:dartz/dartz.dart';
import 'package:erp_system/features/chart/data/models/chart_page_model.dart';

import '../../../../core/errors/failures.dart';
import '../models/chart_master_model.dart';
import '../models/chart_model.dart';

abstract class ChartRepo {
  Future<Either<Failure, ChartPageModel>> getChartPage();
  Future<Either<Failure, ChartMasterModel>> getChartMaster();
  Future<Either<Failure, ChartModel>> getChartData(
      {required String tableOrView});
}
