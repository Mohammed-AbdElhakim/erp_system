part of 'chart_page_cubit.dart';

sealed class ChartPageState extends Equatable {
  const ChartPageState();
  @override
  List<Object> get props => [];
}

final class ChartPageInitial extends ChartPageState {}

final class ChartPageLoading extends ChartPageState {}

final class ChartPageFailure extends ChartPageState {
  final String errorMassage;

  const ChartPageFailure(this.errorMassage);
}

final class ChartPageSuccess extends ChartPageState {
  final List<ChartDataModel> chartInPage;

  const ChartPageSuccess(this.chartInPage);
}
