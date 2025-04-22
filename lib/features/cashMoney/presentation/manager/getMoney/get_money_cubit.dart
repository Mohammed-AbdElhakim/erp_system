import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/repositories/cashMoney/cash_money_repo.dart';

part 'get_money_state.dart';

class GetMoneyCubit extends Cubit<GetMoneyState> {
  GetMoneyCubit(this.cashMoneyRepo) : super(GetMoneyInitial());
  final CashMoneyRepo cashMoneyRepo;

  Future<void> getMoney({
    required int accountId,
  }) async {
    emit(GetMoneyLoading());
    Either<Failure, double> result = await cashMoneyRepo.getMoney(accountId: accountId);
    result.fold((failure) {
      emit(GetMoneyFailure(failure.errorMassage));
    }, (data) {
      emit(GetMoneySuccess(data));
    });
  }
}
