part of 'cost_item_account_report_cubit.dart';

sealed class CostItemAccountReportState extends Equatable {
  const CostItemAccountReportState();

  @override
  List<Object> get props => [];
}

final class CostItemAccountReportInitial extends CostItemAccountReportState {}

final class CostItemAccountReportLoading extends CostItemAccountReportState {}

final class CostItemAccountReportFailure extends CostItemAccountReportState {
  final String errorMassage;

  const CostItemAccountReportFailure(this.errorMassage);
}

final class CostItemAccountReportSuccess extends CostItemAccountReportState {
  final dynamic costItemAccountReportModel;
  final int numberPage;
  final int dropdownValue;
  final int selectTap;

  const CostItemAccountReportSuccess({
    required this.costItemAccountReportModel,
    required this.numberPage,
    required this.dropdownValue,
    required this.selectTap,
  });
}
