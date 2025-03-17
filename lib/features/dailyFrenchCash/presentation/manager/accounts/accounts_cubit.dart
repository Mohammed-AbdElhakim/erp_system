import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/accounts_model.dart';
import '../../../data/repositories/daily_french_cash_repo.dart';

part 'accounts_state.dart';

class AccountsCubit extends Cubit<AccountsState> {
  AccountsCubit(this.dailyFrenchCashRepo) : super(AccountsInitial());
  final DailyFrenchCashRepo dailyFrenchCashRepo;
  Future<void> getAccountsList() async {
    emit(AccountsLoading());
    Either<Failure, AccountsModel> result = await dailyFrenchCashRepo.getAccountsList();
    result.fold((failure) {
      emit(AccountsFailure(failure.errorMassage));
    }, (data) {
      emit(AccountsSuccess(data.accountsList!));
    });
  }
}
