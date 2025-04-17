import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../errors/failures.dart';
import '../../repositories/general/General_repo.dart';

part 'get_data_global_state.dart';

class GetDataGlobalCubit extends Cubit<GetDataGlobalState> {
  GetDataGlobalCubit(this.generalRepo) : super(GetDataGlobalInitial());

  final GeneralRepo generalRepo;

  Future<void> getDataGlobal({required Map<String, dynamic> bodyRequest}) async {
    emit(GetDataGlobalLoading());
    Either<Failure, Map<String, dynamic>> result = await generalRepo.getDataGlobal(bodyRequest: bodyRequest);
    result.fold((failure) {
      emit(GetDataGlobalFailure(failure.errorMassage));
    }, (data) {
      emit(GetDataGlobalSuccess(data));
    });
  }
}
