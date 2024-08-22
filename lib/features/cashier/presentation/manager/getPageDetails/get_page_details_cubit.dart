import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:erp_system/features/cashier/data/repositories/cashier_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/tap_model.dart';

part 'get_page_details_state.dart';

class GetPageDetailsCubit extends Cubit<GetPageDetailsState> {
  GetPageDetailsCubit(this.cashierRepo) : super(GetPageDetailsInitial());
  final CashierRepo cashierRepo;
  Future<void> getPageDetails(int pageId) async {
    emit(GetPageDetailsLoading());
    Either<Failure, TapModel> result =
        await cashierRepo.getPageDetails(pageID: pageId);
    result.fold((failure) {
      emit(GetPageDetailsFailure(failure.errorMassage));
    }, (tapDetails) {
      emit(GetPageDetailsSuccess(tapDetails));
    });
  }
}
