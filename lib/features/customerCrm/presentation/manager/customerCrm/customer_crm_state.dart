part of 'customer_crm_cubit.dart';

sealed class CustomerCrmState extends Equatable {
  const CustomerCrmState();

  @override
  List<Object> get props => [];
}

final class CustomerCrmInitial extends CustomerCrmState {}

final class CustomerCrmLoading extends CustomerCrmState {}

final class CustomerCrmFailure extends CustomerCrmState {
  final String errorMassage;

  const CustomerCrmFailure(this.errorMassage);
}

final class CustomerCrmSuccess extends CustomerCrmState {
  final dynamic accountProfModel;
  final int numberPage;
  final int dropdownValue;
  final int selectTap;

  const CustomerCrmSuccess({
    required this.accountProfModel,
    required this.numberPage,
    required this.dropdownValue,
    required this.selectTap,
  });
}
