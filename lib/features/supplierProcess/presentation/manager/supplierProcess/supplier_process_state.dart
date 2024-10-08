part of 'supplier_process_cubit.dart';

sealed class SupplierProcessState extends Equatable {
  const SupplierProcessState();
  @override
  List<Object> get props => [];
}

final class SupplierProcessInitial extends SupplierProcessState {}

final class SupplierProcessLoading extends SupplierProcessState {}

final class SupplierProcessFailure extends SupplierProcessState {
  final String errorMassage;

  const SupplierProcessFailure(this.errorMassage);
}

final class SupplierProcessSuccess extends SupplierProcessState {
  final dynamic accountProfModel;
  final int numberPage;
  final int dropdownValue;
  final int selectTap;

  const SupplierProcessSuccess({
    required this.accountProfModel,
    required this.numberPage,
    required this.dropdownValue,
    required this.selectTap,
  });
}
