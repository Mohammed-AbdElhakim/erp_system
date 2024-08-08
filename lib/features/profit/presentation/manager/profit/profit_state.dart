part of 'profit_cubit.dart';

sealed class ProfitState extends Equatable {
  const ProfitState();
  @override
  List<Object> get props => [];
}

final class ProfitInitial extends ProfitState {}

final class ProfitLoading extends ProfitState {}

final class ProfitFailure extends ProfitState {
  final String errorMassage;

  const ProfitFailure(this.errorMassage);
}

final class ProfitSuccess extends ProfitState {
  final List<ProfitModel> profitModel;

  const ProfitSuccess(this.profitModel);
}
