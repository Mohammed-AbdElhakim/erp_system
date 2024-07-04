import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/repositories/screen_repo.dart';

part 'add_edit_expenses_state.dart';

class AddEditExpensesCubit extends Cubit<AddEditExpensesState> {
  AddEditExpensesCubit(this.screenRepo) : super(AddEditExpensesInitial());
  final ScreenRepo screenRepo;
  Future<void> add({
    required List<Map<String, dynamic>> tableList,
    required Map<String, dynamic> singleObject,
  }) async {
    emit(AddEditExpensesLoading());
    Either<Failure, String> result = await screenRepo.addExpenses(
      body: {"array": tableList, "singleObject": singleObject},
    );
    result.fold((failure) {
      emit(AddEditExpensesFailure(failure.errorMassage));
    }, (send) {
      emit(AddEditExpensesSuccess());
    });
  }

  Future<void> edit({
    required List<Map<String, dynamic>> tableList,
    required Map<String, dynamic> singleObject,
  }) async {
    emit(AddEditExpensesLoading());
    Either<Failure, String> result = await screenRepo.editExpenses(
      body: {"array": tableList, "singleObject": singleObject},
    );
    result.fold((failure) {
      emit(AddEditExpensesFailure(failure.errorMassage));
    }, (send) {
      emit(AddEditExpensesSuccess());
    });
  }
}
