import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/supplier_process_model0.dart';
import '../../../data/models/supplier_process_model1.dart';
import '../../../data/models/supplier_process_model2.dart';
import '../../../data/models/supplier_process_model3.dart';
import '../../../data/models/supplier_process_model4.dart';
import '../../../data/models/supplier_process_model5.dart';
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
      if (selectTab == 0) {
        SupplierProcessModel0 supplierProcessModel0 =
            SupplierProcessModel0.fromJson(accountProfModel);
        emit(SupplierProcessSuccess(
            accountProfModel: supplierProcessModel0,
            numberPage: numberOfPage,
            dropdownValue: dropdownValueOfLimit,
            selectTap: selectTab));
      }
      if (selectTab == 1) {
        SupplierProcessModel1 supplierProcessModel1 =
            SupplierProcessModel1.fromJson(accountProfModel);
        emit(SupplierProcessSuccess(
            accountProfModel: supplierProcessModel1,
            numberPage: numberOfPage,
            dropdownValue: dropdownValueOfLimit,
            selectTap: selectTab));
      }
      if (selectTab == 2) {
        SupplierProcessModel2 supplierProcessModel2 =
            SupplierProcessModel2.fromJson(accountProfModel);
        emit(SupplierProcessSuccess(
            accountProfModel: supplierProcessModel2,
            numberPage: numberOfPage,
            dropdownValue: dropdownValueOfLimit,
            selectTap: selectTab));
      } else if (selectTab == 3) {
        SupplierProcessModel3 supplierProcessModel3 =
            SupplierProcessModel3.fromJson(accountProfModel);
        emit(SupplierProcessSuccess(
            accountProfModel: supplierProcessModel3,
            numberPage: numberOfPage,
            dropdownValue: dropdownValueOfLimit,
            selectTap: selectTab));
      } else if (selectTab == 4) {
        SupplierProcessModel4 supplierProcessModel4 =
            SupplierProcessModel4.fromJson(accountProfModel);
        emit(SupplierProcessSuccess(
            accountProfModel: supplierProcessModel4,
            numberPage: numberOfPage,
            dropdownValue: dropdownValueOfLimit,
            selectTap: selectTab));
      }
      if (selectTab == 5) {
        SupplierProcessModel5 supplierProcessModel5 =
            SupplierProcessModel5.fromJson(accountProfModel);
        emit(SupplierProcessSuccess(
            accountProfModel: supplierProcessModel5,
            numberPage: numberOfPage,
            dropdownValue: dropdownValueOfLimit,
            selectTap: selectTab));
      }
    });
  }
}
