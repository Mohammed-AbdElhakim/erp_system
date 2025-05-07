import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/machine_work_report_model.dart';

abstract class MachineWorkReportRepo {
  Future<Either<Failure, MachineWorkReportModel>> getMachineWorkReport({
    required Map<String, dynamic> bodyRequest,
  });
}
