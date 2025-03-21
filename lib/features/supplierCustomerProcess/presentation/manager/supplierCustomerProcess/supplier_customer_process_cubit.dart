import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/supplier_customer_process_model0.dart';
import '../../../data/models/supplier_customer_process_model1.dart';
import '../../../data/models/supplier_customer_process_model2.dart';
import '../../../data/models/supplier_customer_process_model3.dart';
import '../../../data/models/supplier_customer_process_model4.dart';
import '../../../data/repositories/supplier_customer_process_repo.dart';

part 'supplier_customer_process_state.dart';

class SupplierCustomerProcessCubit extends Cubit<SupplierCustomerProcessState> {
  SupplierCustomerProcessCubit(this.supplierCustomerProcessRepo)
      : super(SupplierCustomerProcessInitial());
  final SupplierCustomerProcessRepo supplierCustomerProcessRepo;

  Future<void> getTableSupplierCustomerProcess({
    required Map<String, dynamic> objectData,
    required String link,
    required int numberOfPage,
    required int dropdownValueOfLimit,
    required int selectTab,
  }) async {
    emit(SupplierCustomerProcessLoading());
    Either<Failure, Map<String, dynamic>> result = await supplierCustomerProcessRepo
        .getTableSupplierCustomerProcess(objectData: objectData, link: link);
    result.fold((failure) {
      emit(SupplierCustomerProcessFailure(failure.errorMassage));
    }, (dataModel) {
      if (selectTab == 0) {
        SupplierCustomerProcessModel0 supplierCustomerProcessModel0 =
            SupplierCustomerProcessModel0.fromJson(dataModel);
        emit(SupplierCustomerProcessSuccess(
            dataModel: supplierCustomerProcessModel0,
            numberPage: numberOfPage,
            dropdownValue: dropdownValueOfLimit,
            selectTap: selectTab));
      } else if (selectTab == 1) {
        SupplierCustomerProcessModel1 supplierCustomerProcessModel1 =
            SupplierCustomerProcessModel1.fromJson(dataModel);
        emit(SupplierCustomerProcessSuccess(
            dataModel: supplierCustomerProcessModel1,
            numberPage: numberOfPage,
            dropdownValue: dropdownValueOfLimit,
            selectTap: selectTab));
      } else if (selectTab == 2) {
        SupplierCustomerProcessModel2 supplierCustomerProcessModel2 =
            SupplierCustomerProcessModel2.fromJson(dataModel);
        emit(SupplierCustomerProcessSuccess(
            dataModel: supplierCustomerProcessModel2,
            numberPage: numberOfPage,
            dropdownValue: dropdownValueOfLimit,
            selectTap: selectTab));
      } else if (selectTab == 3) {
        SupplierCustomerProcessModel3 supplierCustomerProcessModel3 =
            SupplierCustomerProcessModel3.fromJson(dataModel);
        emit(SupplierCustomerProcessSuccess(
            dataModel: supplierCustomerProcessModel3,
            numberPage: numberOfPage,
            dropdownValue: dropdownValueOfLimit,
            selectTap: selectTab));
      } else if (selectTab == 4) {
        SupplierCustomerProcessModel4 supplierCustomerProcessModel4 =
            SupplierCustomerProcessModel4.fromJson(dataModel);
        emit(SupplierCustomerProcessSuccess(
            dataModel: supplierCustomerProcessModel4,
            numberPage: numberOfPage,
            dropdownValue: dropdownValueOfLimit,
            selectTap: selectTab));
      }
    });
  }
}
