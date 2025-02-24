import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/header_model.dart';
import '../../../data/repositories/customer_account_repo.dart';

part 'get_header_table_state.dart';

class GetHeaderTableCubit extends Cubit<GetHeaderTableState> {
  GetHeaderTableCubit(this.customerAccountRepo)
      : super(GetHeaderTableInitial());
  final CustomerAccountRepo customerAccountRepo;

  Future<void> getHeaderTable({
    required String listName,
  }) async {
    emit(GetHeaderTableLoading());
    Either<Failure, List<HeaderModel>> result =
        await customerAccountRepo.getHeaderTable(
      listName: listName,
    );
    result.fold((failure) {
      emit(GetHeaderTableFailure(failure.errorMassage));
    }, (headerList) {
      emit(GetHeaderTableSuccess(headerList));
    });
  }
}
