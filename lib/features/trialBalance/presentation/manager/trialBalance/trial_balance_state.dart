part of 'trial_balance_cubit.dart';

sealed class TrialBalanceState extends Equatable {
  const TrialBalanceState();
  @override
  List<Object> get props => [];
}

final class TrialBalanceInitial extends TrialBalanceState {}

final class TrialBalanceLoading extends TrialBalanceState {}

final class TrialBalanceFailure extends TrialBalanceState {
  final String errorMassage;

  const TrialBalanceFailure(this.errorMassage);
}

final class TrialBalanceSuccess extends TrialBalanceState {
  final TrialBalanceModel trialBalanceModel;

  const TrialBalanceSuccess(this.trialBalanceModel);
}
