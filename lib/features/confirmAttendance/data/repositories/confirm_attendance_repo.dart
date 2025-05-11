import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/confirm_attendance_model.dart';

abstract class ConfirmAttendanceRepo {
  Future<Either<Failure, List<ConfirmAttendanceModel>>> getDataConfirmAttendanceList({
    required Map<String, dynamic> bodyRequest,
  });

  Future<Either<Failure, String>> confirmAttendance({
    required List<Map<String, dynamic>> bodyRequest,
  });
}
