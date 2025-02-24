part of 'customer_account_cubit.dart';

sealed class CustomerAccountState extends Equatable {
  const CustomerAccountState();
  @override
  List<Object> get props => [];
}

final class CustomerAccountInitial extends CustomerAccountState {}

final class CustomerAccountLoading extends CustomerAccountState {}

final class CustomerAccountFailure extends CustomerAccountState {
  final String errorMassage;

  const CustomerAccountFailure(this.errorMassage);
}

final class CustomerAccountSuccess extends CustomerAccountState {
  final dynamic accountProfModel;
  final int numberPage;
  final int dropdownValue;
  final int selectTap;

  const CustomerAccountSuccess({
    required this.accountProfModel,
    required this.numberPage,
    required this.dropdownValue,
    required this.selectTap,
  });
}
