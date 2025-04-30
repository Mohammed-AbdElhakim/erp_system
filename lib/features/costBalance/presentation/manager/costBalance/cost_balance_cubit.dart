import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/cost_balance_model.dart';
import '../../../data/repositories/cost_balance_repo.dart';

part 'cost_balance_state.dart';

class CostBalanceCubit extends Cubit<CostBalanceState> {
  CostBalanceCubit(this.inventoryProductRepo) : super(CostBalanceInitial());
  final CostBalanceRepo inventoryProductRepo;

  Future<void> getCostBalance({
    required Map<String, dynamic> bodyRequest,
  }) async {
    emit(CostBalanceLoading());
    Either<Failure, List<CostBalanceModel>> result = await inventoryProductRepo.getCostBalance(bodyRequest: bodyRequest);
    result.fold((failure) {
      emit(CostBalanceFailure(failure.errorMassage));
    }, (inventoryProduct) {
      emit(CostBalanceSuccess(inventoryProduct));
    });
  }
}
