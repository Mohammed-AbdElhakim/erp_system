part of 'profit_cubit.dart';

sealed class ProfitState extends Equatable {
  const ProfitState();
}

final class ProfitInitial extends ProfitState {
  @override
  List<Object> get props => [];
}
