import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:erp_system/features/trialBalance/data/models/trial_balance_body_model.dart';
import 'package:erp_system/features/trialBalance/data/models/trial_balance_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/repositories/trial_balance_repo.dart';

part 'trial_balance_state.dart';

class TrialBalanceCubit extends Cubit<TrialBalanceState> {
  TrialBalanceCubit(this.trialBalanceRepo) : super(TrialBalanceInitial());
  final TrialBalanceRepo trialBalanceRepo;

  Future<void> getTrialBalance({
    required TrialBalanceBodyModel trialBalanceBody,
  }) async {
    emit(TrialBalanceLoading());
    Either<Failure, List<TrialBalanceModel>> result = await trialBalanceRepo
        .getTrialBalance(trialBalanceBody: trialBalanceBody);
    result.fold((failure) {
      emit(TrialBalanceFailure(failure.errorMassage));
    }, (trialBalance) {
      emit(TrialBalanceSuccess(trialBalance));
    });
  }
}
