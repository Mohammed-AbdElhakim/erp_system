part of 'confirm_attendance_cubit.dart';

sealed class ConfirmAttendanceState extends Equatable {
  const ConfirmAttendanceState();
  @override
  List<Object> get props => [];
}

final class ConfirmAttendanceInitial extends ConfirmAttendanceState {}
final class ConfirmAttendanceLoading extends ConfirmAttendanceState {}
final class ConfirmAttendanceFailure extends ConfirmAttendanceState {
  final String errorMassage;

  const ConfirmAttendanceFailure(this.errorMassage);
}
final class ConfirmAttendanceSuccess extends ConfirmAttendanceState {


  const ConfirmAttendanceSuccess();
}
