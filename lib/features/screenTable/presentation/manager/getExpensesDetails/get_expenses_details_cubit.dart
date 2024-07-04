import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:erp_system/features/screenTable/data/models/expenses_details_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/tap_model.dart';
import '../../../data/repositories/screen_repo.dart';

part 'get_expenses_details_state.dart';

class GetExpensesDetailsCubit extends Cubit<GetExpensesDetailsState> {
  GetExpensesDetailsCubit(this.screenRepo) : super(GetExpensesDetailsInitial());
  final ScreenRepo screenRepo;
  Future<void> getExpensesDetails({
    required ListTaps tapModel,
  }) async {
    emit(GetExpensesDetailsLoading());
    Either<Failure, ExpensesDetailsModel> result =
        await screenRepo.getExpensesDetails(tapModel: tapModel);
    result.fold((failure) {
      emit(GetExpensesDetailsFailure(failure.errorMassage));
    }, (data) {
      emit(GetExpensesDetailsSuccess(data));
    });
  }
}
