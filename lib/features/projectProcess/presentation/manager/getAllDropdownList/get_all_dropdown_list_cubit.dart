import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/all_dropdown_model.dart';
import '../../../data/repositories/project_process_repo.dart';

part 'get_all_dropdown_list_state.dart';

class GetAllDropdownListCubit extends Cubit<GetAllDropdownListState> {
  GetAllDropdownListCubit(this.projectProcessRepo)
      : super(GetAllDropdownListInitial());
  final ProjectProcessRepo projectProcessRepo;
  Future<void> getAllDropdownList({
    required int pageId,
  }) async {
    emit(GetAllDropdownListLoading());

    Either<Failure, List<AllDropdownModel>> result =
        await projectProcessRepo.getAllDropdownList(pageID: pageId);
    result.fold((failure) {
      emit(GetAllDropdownListFailure(failure.errorMassage));
    }, (allDropdownList) {
      emit(GetAllDropdownListSuccess(allDropdownList));
    });
  }
}
