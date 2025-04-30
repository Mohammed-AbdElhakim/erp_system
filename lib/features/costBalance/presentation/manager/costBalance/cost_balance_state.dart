part of 'cost_balance_cubit.dart';

sealed class CostBalanceState extends Equatable {
  const CostBalanceState();

  @override
  List<Object> get props => [];
}

final class CostBalanceInitial extends CostBalanceState {}

final class CostBalanceLoading extends CostBalanceState {}

final class CostBalanceFailure extends CostBalanceState {
  final String errorMassage;

  const CostBalanceFailure(this.errorMassage);
}

final class CostBalanceSuccess extends CostBalanceState {
  final List<CostBalanceModel> inventoryProductModel;

  const CostBalanceSuccess(this.inventoryProductModel);
}
