import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:erp_system/core/repositories/general/general_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../errors/failures.dart';

part 'list_setup_state.dart';

class ListSetupCubit extends Cubit<ListSetupState> {
  ListSetupCubit(this.generalRepo) : super(ListSetupInitial());
  final GeneralRepo generalRepo;

  Future<void> getListSetup({
    required String listName,
    required String link,
  }) async {
    emit(ListSetupLoading());
    Either<Failure, List<dynamic>> result = await generalRepo.getListSetup(link: link, listName: listName);
    result.fold((failure) {
      emit(ListSetupFailure(failure.errorMassage));
    }, (data) {
      emit(ListSetupSuccess(data));
    });
  }
}
