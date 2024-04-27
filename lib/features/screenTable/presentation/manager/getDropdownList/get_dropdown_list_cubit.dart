import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/dropdown_model/dropdown_model.dart';
import '../../../data/repositories/screen_repo.dart';

part 'get_dropdown_list_state.dart';

class GetDropdownListCubit extends Cubit<GetDropdownListState> {
  GetDropdownListCubit(this.screenRepo) : super(GetDropdownListInitial());
  final ScreenRepo screenRepo;
  Future<void> getDropdownList({
    required String droModel,
    required String droValue,
    required String droText,
    required String droCondition,
    required String droCompany,
  }) async {
    emit(GetDropdownListLoading());

    Either<Failure, DropdownModel> result = await screenRepo.getDropdownList(
        droModel: droModel,
        droValue: droValue,
        droText: droText,
        droCondition: droCondition,
        droCompany: droCompany);
    result.fold((failure) {
      emit(GetDropdownListFailure(failure.errorMassage));
    }, (dropdownList) {
      emit(GetDropdownListSuccess(dropdownList));
    });
  }
}
