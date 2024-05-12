import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/dropdown_model/dropdown_model.dart';
import '../../../data/repositories/screen_repo.dart';

part 'get_all_dropdown_list_state.dart';

class GetAllDropdownListCubit extends Cubit<GetAllDropdownListState> {
  GetAllDropdownListCubit(this.screenRepo) : super(GetAllDropdownListInitial());
  final ScreenRepo screenRepo;
  Future<void> getAllDropdownList({
    required String droModel,
    required String droValue,
    required String droText,
    required String droCondition,
    required String droCompany,
  }) async {
    emit(GetAllDropdownListLoading());

    Either<Failure, DropdownModel> result = await screenRepo.getDropdownList(
        droModel: droModel,
        droValue: droValue,
        droText: droText,
        droCondition: droCondition,
        droCompany: droCompany);
    result.fold((failure) {
      emit(GetAllDropdownListFailure(failure.errorMassage));
    }, (dropdownList) {
      emit(GetAllDropdownListSuccess(dropdownList));
    });
  }
}
