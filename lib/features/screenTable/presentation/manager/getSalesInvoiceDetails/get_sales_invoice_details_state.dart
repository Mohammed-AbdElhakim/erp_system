part of 'get_sales_invoice_details_cubit.dart';

sealed class GetSalesInvoiceDetailsState extends Equatable {
  const GetSalesInvoiceDetailsState();
  @override
  List<Object> get props => [];
}

final class GetSalesInvoiceDetailsInitial extends GetSalesInvoiceDetailsState {}

final class GetSalesInvoiceDetailsLoading extends GetSalesInvoiceDetailsState {}

final class GetSalesInvoiceDetailsFailure extends GetSalesInvoiceDetailsState {
  final String errorMassage;

  const GetSalesInvoiceDetailsFailure(this.errorMassage);
}

final class GetSalesInvoiceDetailsSuccess extends GetSalesInvoiceDetailsState {
  final ExpensesDetailsModel expensesDetailsModel;

  const GetSalesInvoiceDetailsSuccess(this.expensesDetailsModel);
}
