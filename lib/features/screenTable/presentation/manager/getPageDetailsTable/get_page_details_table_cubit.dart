import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:erp_system/features/screenTable/data/models/tap_model.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/screen_model.dart';
import '../../../data/repositories/screen_repo.dart';

part 'get_page_details_table_state.dart';

class GetPageDetailsTableCubit extends Cubit<GetPageDetailsTableState> {
  GetPageDetailsTableCubit(this.screenRepo)
      : super(GetPageDetailsTableInitial());
  final ScreenRepo screenRepo;
  Future<void> getPageDetailsTable({
    required ListTaps tapData,
    required int numberOfPage,
    required int dropdownValueOfLimit,
  }) async {
    emit(GetPageDetailsTableLoading());
    Either<Failure, ScreenModel> result = await screenRepo.getPageDetailsTable(
      tapData: tapData,
    );
    result.fold((failure) {
      emit(GetPageDetailsTableFailure(failure.errorMassage));
    }, (tableData) {
      emit(GetPageDetailsTableSuccess(
          tableData, numberOfPage, dropdownValueOfLimit));
    });
  }
}
