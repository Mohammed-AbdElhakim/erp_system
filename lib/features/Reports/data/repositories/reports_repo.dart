import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/all_dropdown_model.dart';
import '../models/report_model.dart';
import '../models/table_model.dart';

abstract class ReportsRepo {
  Future<Either<Failure, List<ReportModel>>> getReports({required int pageId});
  Future<Either<Failure, TableModel>> getTableReports({required int reportId});
  Future<Either<Failure, List<AllDropdownModel>>> getAllDropdownList({
    required int pageID,
  });
}
