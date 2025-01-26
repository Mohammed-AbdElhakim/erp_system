import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:erp_system/features/supplierProcess/data/models/header_model.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/repositories/supplier_process_repo.dart';

part 'get_header_table_state.dart';

class GetHeaderTableCubit extends Cubit<GetHeaderTableState> {
  GetHeaderTableCubit(this.accountProfRepo) : super(GetHeaderTableInitial());
  final SupplierProcessRepo accountProfRepo;

  Future<void> getHeaderTable({
    required String listName,
  }) async {
    emit(GetHeaderTableLoading());
    Either<Failure, List<HeaderModel>> result =
        await accountProfRepo.getHeaderTable(
      listName: listName,
    );
    result.fold((failure) {
      emit(GetHeaderTableFailure(failure.errorMassage));
    }, (headerList) {
      emit(GetHeaderTableSuccess(headerList));
    });
  }
}
