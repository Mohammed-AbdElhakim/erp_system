import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/dropdown_model/all_dropdown_model.dart';
import '../../../data/repositories/screen_repo.dart';

part 'get_all_dropdown_list_state.dart';

class GetAllDropdownListCubit extends Cubit<GetAllDropdownListState> {
  GetAllDropdownListCubit(this.screenRepo) : super(GetAllDropdownListInitial());
  final ScreenRepo screenRepo;
  Future<void> getAllDropdownList({
    required int pageId,
  }) async {
    emit(GetAllDropdownListLoading());

    Either<Failure, List<AllDropdownModel>> result =
        await screenRepo.getAllDropdownList(pageID: pageId);
    result.fold((failure) {
      emit(GetAllDropdownListFailure(failure.errorMassage));
    }, (allDropdownList) {
      emit(GetAllDropdownListSuccess(allDropdownList));
    });
  }
}
