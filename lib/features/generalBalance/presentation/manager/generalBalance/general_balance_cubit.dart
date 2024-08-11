import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/general_balance_body_model.dart';
import '../../../data/models/general_balance_model.dart';
import '../../../data/repositories/general_balance_repo.dart';

part 'general_balance_state.dart';

class GeneralBalanceCubit extends Cubit<GeneralBalanceState> {
  GeneralBalanceCubit(this.generalBalanceRepo) : super(GeneralBalanceInitial());
  final GeneralBalanceRepo generalBalanceRepo;

  Future<void> getGeneralBalance({
    required GeneralBalanceBodyModel generalBalanceBodyModel,
  }) async {
    emit(GeneralBalanceLoading());
    Either<Failure, List<GeneralBalanceModel>> result = await generalBalanceRepo
        .getGeneralBalance(generalBalanceBodyModel: generalBalanceBodyModel);
    result.fold((failure) {
      emit(GeneralBalanceFailure(failure.errorMassage));
    }, (generalBalance) {
      emit(GeneralBalanceSuccess(generalBalance));
    });
  }
}
