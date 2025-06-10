part of 'trial_cost_cubit.dart';

sealed class TrialCostState extends Equatable {
  const TrialCostState();

  @override
  List<Object> get props => [];
}

final class TrialCostInitial extends TrialCostState {}

final class TrialCostLoading extends TrialCostState {}

final class TrialCostFailure extends TrialCostState {
  final String errorMassage;

  const TrialCostFailure(this.errorMassage);
}

final class TrialCostSuccess extends TrialCostState {
  final List<TrialCostItem> trialCostItemsList;

  const TrialCostSuccess(this.trialCostItemsList);
}
