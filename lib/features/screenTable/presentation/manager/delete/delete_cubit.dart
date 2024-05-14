import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/repositories/screen_repo.dart';

part 'delete_state.dart';

class DeleteCubit extends Cubit<DeleteState> {
  DeleteCubit(this.screenRepo) : super(DeleteInitial());
  final ScreenRepo screenRepo;

  Future<void> deleteItems({
    required String controllerName,
    required List<String> listId,
  }) async {
    emit(DeleteLoading());
    Either<Failure, String> result = await screenRepo.deleteItem(
        controllerName: controllerName, listId: listId);
    result.fold((failure) {
      emit(DeleteFailure(failure.errorMassage));
    }, (value) {
      emit(DeleteSuccess());
    });
  }
}
