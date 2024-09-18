part of 'account_prof_cubit.dart';

sealed class AccountProfState extends Equatable {
  const AccountProfState();
  @override
  List<Object> get props => [];
}

final class AccountProfInitial extends AccountProfState {}

final class AccountProfLoading extends AccountProfState {}

final class AccountProfFailure extends AccountProfState {
  final String errorMassage;

  const AccountProfFailure(this.errorMassage);
}

final class AccountProfSuccess extends AccountProfState {
  final AccountProfModel accountProfModel;
  final int numberPage;
  final int dropdownValue;

  const AccountProfSuccess(
      {required this.accountProfModel,
      required this.numberPage,
      required this.dropdownValue});
}
