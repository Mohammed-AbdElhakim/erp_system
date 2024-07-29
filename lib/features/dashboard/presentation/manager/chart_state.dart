part of 'chart_cubit.dart';

sealed class ChartState extends Equatable {
  const ChartState();
  @override
  List<Object> get props => [];
}

final class ChartInitial extends ChartState {}

final class ChartLoading extends ChartState {}

final class ChartFailure extends ChartState {
  final String errorMassage;

  const ChartFailure(this.errorMassage);
}

final class ChartSuccess extends ChartState {}
