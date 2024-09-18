import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/account_prof_model.dart';
import '../../../data/repositories/account_prof_repo.dart';

part 'account_prof_state.dart';

class AccountProfCubit extends Cubit<AccountProfState> {
  AccountProfCubit(this.accountProfRepo) : super(AccountProfInitial());
  final AccountProfRepo accountProfRepo;

  Future<void> getTableAccountProf({
    required Map<String, dynamic> objectData,
    required int numberOfPage,
    required int dropdownValueOfLimit,
  }) async {
    emit(AccountProfLoading());
    Either<Failure, AccountProfModel> result =
        await accountProfRepo.getTableAccountProf(objectData: objectData);
    result.fold((failure) {
      emit(AccountProfFailure(failure.errorMassage));
    }, (accountProfModel) {
      emit(AccountProfSuccess(
          accountProfModel: accountProfModel,
          numberPage: numberOfPage,
          dropdownValue: dropdownValueOfLimit));
    });
  }
}
