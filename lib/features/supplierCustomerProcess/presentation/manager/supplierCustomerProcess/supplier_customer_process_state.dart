part of 'supplier_customer_process_cubit.dart';

sealed class SupplierCustomerProcessState extends Equatable {
  const SupplierCustomerProcessState();
  @override
  List<Object> get props => [];
}

final class SupplierCustomerProcessInitial extends SupplierCustomerProcessState {}

final class SupplierCustomerProcessLoading extends SupplierCustomerProcessState {}

final class SupplierCustomerProcessFailure extends SupplierCustomerProcessState {
  final String errorMassage;

  const SupplierCustomerProcessFailure(this.errorMassage);
}

final class SupplierCustomerProcessSuccess extends SupplierCustomerProcessState {
  final dynamic dataModel;
  final int numberPage;
  final int dropdownValue;
  final int selectTap;

  const SupplierCustomerProcessSuccess({
    required this.dataModel,
    required this.numberPage,
    required this.dropdownValue,
    required this.selectTap,
  });
}
