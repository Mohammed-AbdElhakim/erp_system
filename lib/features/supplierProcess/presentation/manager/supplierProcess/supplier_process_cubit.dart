import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/supplier_process_model.dart';
import '../../../data/models/supplier_process_model1.dart';
import '../../../data/repositories/supplier_process_repo.dart';

part 'supplier_process_state.dart';

class SupplierProcessCubit extends Cubit<SupplierProcessState> {
  SupplierProcessCubit(this.supplierProcessRepo)
      : super(SupplierProcessInitial());
  final SupplierProcessRepo supplierProcessRepo;

  Future<void> getTableSupplierProcess({
    required Map<String, dynamic> objectData,
    required String link,
    required int numberOfPage,
    required int dropdownValueOfLimit,
    required int selectTab,
  }) async {
    emit(SupplierProcessLoading());
    Either<Failure, Map<String, dynamic>> result = await supplierProcessRepo
        .getTableSupplierProcess(objectData: objectData, link: link);
    result.fold((failure) async {
      emit(SupplierProcessFailure(failure.errorMassage));
    }, (accountProfModel) {
      if (selectTab == 0 || selectTab == 5) {
        SupplierProcessModel supplierProcessModel =
            SupplierProcessModel.fromJson(accountProfModel);
        emit(SupplierProcessSuccess(
            accountProfModel: supplierProcessModel,
            numberPage: numberOfPage,
            dropdownValue: dropdownValueOfLimit,
            selectTap: selectTab));
      } else if (selectTab == 1) {
        SupplierProcessModel1 supplierProcessModel1 =
            SupplierProcessModel1.fromJson(accountProfModel);
        emit(SupplierProcessSuccess(
            accountProfModel: supplierProcessModel1,
            numberPage: numberOfPage,
            dropdownValue: dropdownValueOfLimit,
            selectTap: selectTab));
      }
    });
  }
}
