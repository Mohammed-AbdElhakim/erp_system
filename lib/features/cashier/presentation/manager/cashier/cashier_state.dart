part of 'cashier_cubit.dart';

sealed class CashierState extends Equatable {
  const CashierState();
  @override
  List<Object> get props => [];
}

final class CashierInitial extends CashierState {}

final class CashierLoading extends CashierState {}

final class CashierFailure extends CashierState {
  final String errorMassage;

  const CashierFailure(this.errorMassage);
}

final class CashierSuccess extends CashierState {
  final List<PRoCompanyItem> pRoCompanyList;
  final List<ModalityItem> modalityList;
  final List<ProductItem> productList;

  const CashierSuccess({
    required this.pRoCompanyList,
    required this.modalityList,
    required this.productList,
  });
}
