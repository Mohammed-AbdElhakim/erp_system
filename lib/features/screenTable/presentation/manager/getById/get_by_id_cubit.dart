import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/repositories/screen_repo.dart';

part 'get_by_id_state.dart';

class GetByIdCubit extends Cubit<GetByIdState> {
  GetByIdCubit(this.screenRepo) : super(GetByIdInitial());
  final ScreenRepo screenRepo;
  Future<void> getById({
    required String id,
    required String controllerName,
  }) async {
    emit(GetByIdLoading());
    Either<Failure, Map<String, dynamic>> result =
        await screenRepo.getById(controllerName, id);
    result.fold((failure) {
      emit(GetByIdFailure(failure.errorMassage));
    }, (valueGetById) {
      emit(GetByIdSuccess(valueGetById));
    });
  }
}
