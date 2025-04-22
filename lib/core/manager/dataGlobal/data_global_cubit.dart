import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:erp_system/core/repositories/general/general_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../errors/failures.dart';

part 'data_global_state.dart';

class DataGlobalCubit extends Cubit<DataGlobalState> {
  DataGlobalCubit(this.generalRepo) : super(DataGlobalInitial());
  final GeneralRepo generalRepo;

  Future<void> getDataGlobal({
    required Map<String, dynamic> bodyRequest,
    required String link,
  }) async {
    emit(DataGlobalLoading());
    Either<Failure, Map<String, dynamic>> result = await generalRepo.getDataGlobal(link: link, bodyRequest: bodyRequest);
    result.fold((failure) {
      emit(DataGlobalFailure(failure.errorMassage));
    }, (data) {
      emit(DataGlobalSuccess(data));
    });
  }
}
