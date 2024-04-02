import 'package:dartz/dartz.dart';
import 'package:erp_system/core/errors/failures.dart';
import 'package:erp_system/features/attendance/data/models/location_model.dart';
import 'package:erp_system/features/attendance/data/models/valid_device_model.dart';

import 'attendance_repo.dart';

class AttendanceRepoImpl implements AttendanceRepo {
  @override
  Future<Either<Failure, ValidDeviceModel>> checkValidDevice(
      {required String deviceKey}) {
    // TODO: implement checkValidDevice
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, LocationModel>> getAttendanceLocations() {
    // TODO: implement getAttendanceLocations
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> sendAttendance(
      {required String machineID, required String time}) {
    // TODO: implement sendAttendance
    throw UnimplementedError();
  }
}
