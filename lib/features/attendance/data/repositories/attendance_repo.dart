import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/location_model.dart';
import '../models/valid_device_model.dart';

abstract class AttendanceRepo {
  Future<Either<Failure, ValidDeviceModel>> checkValidDevice();
  Future<Either<Failure, LocationModel>> getAttendanceLocations();
  Future<Either<Failure, String>> sendAttendance(
      {required String machineID,
      required String time,
      required String checkType});
}
