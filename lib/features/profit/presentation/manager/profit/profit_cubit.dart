import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/profit_body_model.dart';
import '../../../data/models/profit_model.dart';
import '../../../data/repositories/profit_repo.dart';

part 'profit_state.dart';

class ProfitCubit extends Cubit<ProfitState> {
  ProfitCubit(this.profitRepo) : super(ProfitInitial());
  final ProfitRepo profitRepo;

  Future<void> getProfit({
    required ProfitBodyModel profitBodyModel,
  }) async {
    emit(ProfitLoading());
    Either<Failure, List<ProfitModel>> result =
        await profitRepo.getProfit(profitBodyModel: profitBodyModel);
    result.fold((failure) {
      emit(ProfitFailure(failure.errorMassage));
    }, (profit) {
      emit(ProfitSuccess(profit));
    });
  }
}
