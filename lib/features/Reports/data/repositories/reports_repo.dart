import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/report_model.dart';
import '../models/table_model.dart';

abstract class ReportsRepo {
  Future<Either<Failure, List<ReportModel>>> getReports(int pageId);
  Future<Either<Failure, TableModel>> getTableReports(int reportId);
}
