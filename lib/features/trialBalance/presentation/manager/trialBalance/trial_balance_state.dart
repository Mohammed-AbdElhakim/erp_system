part of 'trial_balance_cubit.dart';

sealed class TrialBalanceState extends Equatable {
  const TrialBalanceState();
}

final class TrialBalanceInitial extends TrialBalanceState {
  @override
  List<Object> get props => [];
}
