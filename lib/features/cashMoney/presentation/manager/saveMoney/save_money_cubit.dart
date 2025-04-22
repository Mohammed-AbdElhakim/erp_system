import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/repositories/cashMoney/cash_money_repo.dart';

part 'save_money_state.dart';

class SaveMoneyCubit extends Cubit<SaveMoneyState> {
  SaveMoneyCubit(this.cashMoneyRepo) : super(SaveMoneyInitial());
  final CashMoneyRepo cashMoneyRepo;

  Future<void> saveMoney({
    required Map<String, dynamic> bodyRequest,
  }) async {
    emit(SaveMoneyLoading());
    Either<Failure, String> result = await cashMoneyRepo.saveMoney(bodyRequest: bodyRequest);
    result.fold((failure) {
      emit(SaveMoneyFailure(failure.errorMassage));
    }, (data) {
      emit(const SaveMoneySuccess());
    });
  }
}
