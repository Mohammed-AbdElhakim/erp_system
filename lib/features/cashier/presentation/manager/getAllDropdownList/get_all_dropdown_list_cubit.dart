import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:erp_system/features/cashier/data/repositories/cashier_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/all_dropdown_model.dart';

part 'get_all_dropdown_list_state.dart';

class GetAllDropdownListCubit extends Cubit<GetAllDropdownListState> {
  GetAllDropdownListCubit(this.cashierRepo)
      : super(GetAllDropdownListInitial());
  final CashierRepo cashierRepo;
  Future<void> getAllDropdownList({
    required int pageId,
  }) async {
    emit(GetAllDropdownListLoading());

    Either<Failure, List<AllDropdownModel>> result =
        await cashierRepo.getAllDropdownList(pageID: pageId);
    result.fold((failure) {
      emit(GetAllDropdownListFailure(failure.errorMassage));
    }, (allDropdownList) {
      emit(GetAllDropdownListSuccess(allDropdownList));
    });
  }
}
