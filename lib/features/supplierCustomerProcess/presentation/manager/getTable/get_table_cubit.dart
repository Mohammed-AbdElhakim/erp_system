import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/screen_model.dart';
import '../../../data/repositories/supplier_customer_process_repo.dart';

part 'get_table_state.dart';

class GetTableCubit extends Cubit<GetTableState> {
  GetTableCubit(this.supplierCustomerProcessRepo) : super(GetTableInitial());
  final SupplierCustomerProcessRepo supplierCustomerProcessRepo;

  Future<void> getTable({
    required int pageId,
    required bool employee,
    required bool isdesc,
    required int limit,
    required int offset,
    required String orderby,
    required String statment,
    required String selectcolumns,
    required bool isDepartment,
    required String departmentName,
    required int authorizationID,
    required String viewEmployeeColumn,
    required int numberOfPage,
    required int dropdownValueOfLimit,
  }) async {
    emit(GetTableLoading());
    Either<Failure, ScreenModel> result = await supplierCustomerProcessRepo.getTable(
      pageId: pageId,
      employee: employee,
      isdesc: isdesc,
      limit: limit,
      offset: offset,
      orderby: orderby,
      statment: statment,
      selectcolumns: selectcolumns,
      isDepartment: isDepartment,
      departmentName: departmentName,
      authorizationID: authorizationID,
      viewEmployeeColumn: viewEmployeeColumn,
    );
    result.fold((failure) {
      emit(GetTableFailure(failure.errorMassage));
    }, (menuList) {
      emit(GetTableSuccess(menuList, numberOfPage, dropdownValueOfLimit));
    });
  }
}
