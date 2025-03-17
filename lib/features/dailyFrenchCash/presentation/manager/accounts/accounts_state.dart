part of 'accounts_cubit.dart';

sealed class AccountsState extends Equatable {
  const AccountsState();
  @override
  List<Object> get props => [];
}

final class AccountsInitial extends AccountsState {}

final class AccountsLoading extends AccountsState {}

final class AccountsFailure extends AccountsState {
  final String errorMassage;

  const AccountsFailure(this.errorMassage);
}

final class AccountsSuccess extends AccountsState {
  final List<AccountsList> accountsList;

  const AccountsSuccess(this.accountsList);
}
