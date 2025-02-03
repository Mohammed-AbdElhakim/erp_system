import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/store_show_model.dart';
import '../../../data/repositories/store_show_repo.dart';

part 'store_show_state.dart';

class StoreShowCubit extends Cubit<StoreShowState> {
  StoreShowCubit(this.storeShowRepo) : super(StoreShowInitial());
  final StoreShowRepo storeShowRepo;

  Future<void> getTableStoreShow({
    required Map<String, dynamic> objectData,
    required int numberOfPage,
    required int dropdownValueOfLimit,
  }) async {
    emit(StoreShowLoading());
    Either<Failure, StoreShowModel> result =
        await storeShowRepo.getTableStoreShow(objectData: objectData);
    result.fold((failure) {
      emit(StoreShowFailure(failure.errorMassage));
    }, (accountProfModel) {
      emit(StoreShowSuccess(
          storeShowModel: accountProfModel,
          numberPage: numberOfPage,
          dropdownValue: dropdownValueOfLimit));
    });
  }
}
