part of 'reports_cubit.dart';

sealed class ReportsState extends Equatable {
  const ReportsState();
  @override
  List<Object> get props => [];
}

final class ReportsInitial extends ReportsState {}

final class ReportsLoading extends ReportsState {}

final class ReportsFailure extends ReportsState {
  final String errorMassage;

  const ReportsFailure(this.errorMassage);
}

final class ReportsSuccess extends ReportsState {
  final List<ReportModel> reportsList;

  const ReportsSuccess(this.reportsList);
}
