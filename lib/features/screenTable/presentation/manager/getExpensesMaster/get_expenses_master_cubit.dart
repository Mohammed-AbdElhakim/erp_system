import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/repositories/screen_repo.dart';

part 'get_expenses_master_state.dart';

class GetExpensesMasterCubit extends Cubit<GetExpensesMasterState> {
  GetExpensesMasterCubit(this.screenRepo) : super(GetExpensesMasterInitial());
  final ScreenRepo screenRepo;
  Future<void> getExpensesMaster(
      {required String id, required String controllerName}) async {
    emit(GetExpensesMasterLoading());
    Either<Failure, Map<String, dynamic>> result = await screenRepo
        .getExpensesMaster(id: id, controllerName: controllerName);
    result.fold((failure) {
      emit(GetExpensesMasterFailure(failure.errorMassage));
    }, (data) {
      emit(GetExpensesMasterSuccess(data));
    });
  }
}
