import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:erp_system/features/cashier/data/repositories/cashier_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';

part 'add_edit_product_state.dart';

class AddEditProductCubit extends Cubit<AddEditProductState> {
  AddEditProductCubit(this.cashierRepo) : super(AddEditProductInitial());
  final CashierRepo cashierRepo;
  Future<void> add(
      {required List<Map<String, dynamic>> tableList,
      required Map<String, dynamic> singleObject,
      required String controllerName}) async {
    emit(AddEditProductLoading());
    Either<Failure, String> result = await cashierRepo.addProduct(
        body: {"array": tableList, "singleObject": singleObject},
        controllerName: controllerName);
    result.fold((failure) {
      emit(AddEditProductFailure(failure.errorMassage));
    }, (send) {
      emit(AddEditProductSuccess());
    });
  }
}
