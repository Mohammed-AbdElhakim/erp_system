import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:erp_system/features/cashier/data/repositories/cashier_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';

part 'add_edit_state.dart';

class AddEditCubit extends Cubit<AddEditState> {
  AddEditCubit(this.cashierRepo) : super(AddEditInitial());
  final CashierRepo cashierRepo;
  Future<void> add({
    required String controllerName,
    required Map<String, dynamic> body,
  }) async {
    emit(AddEditLoading());
    Either<Failure, String> result = await cashierRepo.add(
      body: body,
      controllerName: controllerName,
    );
    result.fold((failure) {
      emit(AddEditFailure(failure.errorMassage));
    }, (send) {
      emit(AddEditSuccess());
    });
  }
}
