part of 'general_balance_cubit.dart';

sealed class GeneralBalanceState extends Equatable {
  const GeneralBalanceState();
  @override
  List<Object> get props => [];
}

final class GeneralBalanceInitial extends GeneralBalanceState {}

final class GeneralBalanceLoading extends GeneralBalanceState {}

final class GeneralBalanceFailure extends GeneralBalanceState {
  final String errorMassage;

  const GeneralBalanceFailure(this.errorMassage);
}

final class GeneralBalanceSuccess extends GeneralBalanceState {
  final List<GeneralBalanceModel> generalBalanceModel;

  const GeneralBalanceSuccess(this.generalBalanceModel);
}
