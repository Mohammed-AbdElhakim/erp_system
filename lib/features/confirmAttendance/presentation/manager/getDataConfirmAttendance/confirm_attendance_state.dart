part of 'confirm_attendance_cubit.dart';

sealed class GetDataConfirmAttendanceState extends Equatable {
  const GetDataConfirmAttendanceState();

  @override
  List<Object> get props => [];
}

final class GetDataConfirmAttendanceInitial extends GetDataConfirmAttendanceState {}

final class GetDataConfirmAttendanceLoading extends GetDataConfirmAttendanceState {}

final class GetDataConfirmAttendanceFailure extends GetDataConfirmAttendanceState {
  final String errorMassage;

  const GetDataConfirmAttendanceFailure(this.errorMassage);
}

final class GetDataConfirmAttendanceSuccess extends GetDataConfirmAttendanceState {
  final List<ConfirmAttendanceModel> listDataConfirmAttendance;

  const GetDataConfirmAttendanceSuccess(this.listDataConfirmAttendance);
}
