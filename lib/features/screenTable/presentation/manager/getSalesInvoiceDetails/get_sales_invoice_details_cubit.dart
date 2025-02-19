import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:erp_system/features/screenTable/data/models/expenses_details_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/repositories/screen_repo.dart';

part 'get_sales_invoice_details_state.dart';

class GetSalesInvoiceDetailsCubit extends Cubit<GetSalesInvoiceDetailsState> {
  GetSalesInvoiceDetailsCubit(this.screenRepo)
      : super(GetSalesInvoiceDetailsInitial());
  final ScreenRepo screenRepo;
  Future<void> getSalesInvoiceDetails({
    required String invoiceID,
  }) async {
    emit(GetSalesInvoiceDetailsLoading());
    Either<Failure, ExpensesDetailsModel> result =
        await screenRepo.getSalesInvoiceDetails(invoiceID: invoiceID);
    result.fold((failure) {
      emit(GetSalesInvoiceDetailsFailure(failure.errorMassage));
    }, (data) {
      emit(GetSalesInvoiceDetailsSuccess(data));
    });
  }
}
