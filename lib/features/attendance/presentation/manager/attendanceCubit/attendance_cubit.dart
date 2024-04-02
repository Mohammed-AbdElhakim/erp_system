import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:erp_system/features/attendance/data/models/location_model.dart';
import 'package:erp_system/features/attendance/data/repositories/attendance_repo.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/valid_device_model.dart';

part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  AttendanceCubit(this.attendanceRepo) : super(AttendanceInitial());
  final AttendanceRepo attendanceRepo;
  Future<void> checkValidDevice() async {
    emit(AttendanceLoading());
    Either<Failure, ValidDeviceModel> result =
        await attendanceRepo.checkValidDevice();
    result.fold((failure) {
      emit(AttendanceFailure(failure.errorMassage));
    }, (validDeviceModel) {
      emit(ValidDeviceSuccess(validDeviceModel));
    });
  }

  Future<void> getAttendanceLocations() async {
    emit(AttendanceLoading());
    Either<Failure, LocationModel> result =
        await attendanceRepo.getAttendanceLocations();
    result.fold((failure) {
      emit(AttendanceFailure(failure.errorMassage));
    }, (locationModel) {
      emit(GetAttendanceLocationsSuccess(locationModel));
    });
  }

  Future<void> sendAttendance(
      {required String machineID, required String time}) async {
    emit(AttendanceLoading());
    Either<Failure, String> result = await attendanceRepo.sendAttendance(
      machineID: machineID,
      time: time,
    );
    result.fold((failure) {
      emit(AttendanceFailure(failure.errorMassage));
    }, (send) {
      emit(SendAttendanceSuccess());
    });
  }
}
