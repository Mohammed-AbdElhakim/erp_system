import 'package:dartz/dartz.dart';
import 'package:erp_system/features/dashboard/data/models/chart_model.dart';
import 'package:erp_system/features/dashboard/data/models/dashboard_model.dart';

import '../../../../core/errors/failures.dart';

abstract class ChartRepo {
  Future<Either<Failure, DashboardModel>> getChartMaster();
  Future<Either<Failure, ChartModel>> getChartData(
      {required String tableOrView});
}
