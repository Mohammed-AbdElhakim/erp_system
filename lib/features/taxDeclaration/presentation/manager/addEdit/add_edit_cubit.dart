import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/repositories/tax_declaration_repo.dart';

part 'add_edit_state.dart';

class AddEditCubit extends Cubit<AddEditState> {
  AddEditCubit(this.taxDeclarationRepo) : super(AddEditInitial());
  final TaxDeclarationRepo taxDeclarationRepo;
  Future<void> add({
    required String controllerName,
    required Map<String, dynamic> body,
  }) async {
    emit(AddEditLoading());
    Either<Failure, String> result = await taxDeclarationRepo.add(
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
