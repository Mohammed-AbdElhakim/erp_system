part of 'attendance_cubit.dart';

sealed class AttendanceState extends Equatable {
  const AttendanceState();
  @override
  List<Object> get props => [];
}

final class AttendanceInitial extends AttendanceState {}

final class AttendanceLoading extends AttendanceState {}

final class AttendanceFailure extends AttendanceState {
  final String errorMassage;

  const AttendanceFailure(this.errorMassage);
}

final class ValidDeviceSuccess extends AttendanceState {
  final ValidDeviceModel validDeviceModel;

  const ValidDeviceSuccess(this.validDeviceModel);
}

final class GetAttendanceLocationsSuccess extends AttendanceState {
  final LocationModel locationModel;

  const GetAttendanceLocationsSuccess(this.locationModel);
}

final class SendAttendanceSuccess extends AttendanceState {}
