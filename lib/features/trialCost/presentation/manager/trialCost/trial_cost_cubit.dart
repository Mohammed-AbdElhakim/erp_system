import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/trial_cost_body_model.dart';
import '../../../data/models/trial_cost_model.dart';
import '../../../data/repositories/trial_cost_repo.dart';

part 'trial_cost_state.dart';

class TrialCostCubit extends Cubit<TrialCostState> {
  TrialCostCubit(this.trialCostRepo) : super(TrialCostInitial());
  final TrialCostRepo trialCostRepo;

  Future<void> getTrialCost({
    required TrialCostBodyModel trialCostBody,
  }) async {
    emit(TrialCostLoading());
    Either<Failure, TrialCostModel> result = await trialCostRepo.getTrialCost(trialCostBody: trialCostBody);
    result.fold((failure) {
      emit(TrialCostFailure(failure.errorMassage));
    }, (trialCost) {
      emit(TrialCostSuccess(trialCost.trialCostItemsList ?? []));
    });
  }
}
