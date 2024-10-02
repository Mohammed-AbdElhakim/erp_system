import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/supplier_process_model.dart';
import '../../../data/repositories/supplier_process_repo.dart';

part 'supplier_process_state.dart';

class SupplierProcessCubit extends Cubit<SupplierProcessState> {
  SupplierProcessCubit(this.supplierProcessRepo)
      : super(SupplierProcessInitial());
  final SupplierProcessRepo supplierProcessRepo;

  Future<void> getTableSupplierProcess({
    required Map<String, dynamic> objectData,
    required int numberOfPage,
    required int dropdownValueOfLimit,
    required int selectTab,
  }) async {
    emit(SupplierProcessLoading());
    Either<Failure, SupplierProcessModel> result = await supplierProcessRepo
        .getTableSupplierProcess(objectData: objectData);
    result.fold((failure) async {
      emit(SupplierProcessFailure(failure.errorMassage));
    }, (accountProfModel) {
      emit(SupplierProcessSuccess(
          accountProfModel: accountProfModel,
          numberPage: numberOfPage,
          dropdownValue: dropdownValueOfLimit,
          selectTap: selectTab));
    });
  }
}
