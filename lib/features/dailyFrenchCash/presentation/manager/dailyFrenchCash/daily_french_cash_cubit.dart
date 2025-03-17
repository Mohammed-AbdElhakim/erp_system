import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/body_request_daily_french_cash.dart';
import '../../../data/models/daily_french_cash_model.dart';
import '../../../data/repositories/daily_french_cash_repo.dart';

part 'daily_french_cash_state.dart';

class DailyFrenchCashCubit extends Cubit<DailyFrenchCashState> {
  DailyFrenchCashCubit(this.dailyFrenchCashRepo) : super(DailyFrenchCashInitial());
  final DailyFrenchCashRepo dailyFrenchCashRepo;
  Future<void> getDailyFrenchCash(
      {required BodyRequestDailyFrenchCash bodyRequestDailyFrenchCash}) async {
    emit(DailyFrenchCashLoading());
    Either<Failure, DailyFrenchCashModel> result = await dailyFrenchCashRepo
        .getDailyFrenchCash(bodyRequestDailyFrenchCash: bodyRequestDailyFrenchCash);
    result.fold((failure) {
      emit(DailyFrenchCashFailure(failure.errorMassage));
    }, (data) {
      emit(DailyFrenchCashSuccess(data));
    });
  }
}
