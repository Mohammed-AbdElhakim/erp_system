part of 'table_report_cubit.dart';

sealed class TableReportState extends Equatable {
  const TableReportState();
  @override
  List<Object> get props => [];
}

final class TableReportInitial extends TableReportState {}

final class TableReportLoading extends TableReportState {}

final class TableReportFailure extends TableReportState {
  final String errorMassage;

  const TableReportFailure(this.errorMassage);
}

final class TableReportSuccess extends TableReportState {
  final TableModel tableModel;

  const TableReportSuccess(this.tableModel);
}
