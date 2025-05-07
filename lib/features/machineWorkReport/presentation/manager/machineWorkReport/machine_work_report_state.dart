part of 'machine_work_report_cubit.dart';

sealed class MachineWorkReportState extends Equatable {
  const MachineWorkReportState();

  @override
  List<Object> get props => [];
}

final class MachineWorkReportInitial extends MachineWorkReportState {}

final class MachineWorkReportLoading extends MachineWorkReportState {}

final class MachineWorkReportFailure extends MachineWorkReportState {
  final String errorMassage;

  const MachineWorkReportFailure(this.errorMassage);
}

final class MachineWorkReportSuccess extends MachineWorkReportState {
  final MachineWorkReportModel machineWorkReportData;
  final int numberPage;
  final int dropdownValue;

  const MachineWorkReportSuccess({required this.machineWorkReportData, required this.numberPage, required this.dropdownValue});
}
