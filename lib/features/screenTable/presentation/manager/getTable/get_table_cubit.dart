import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:erp_system/core/models/menu_model/pages.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../screenTable/data/models/column_data_model.dart';
import '../../../../screenTable/data/repositories/table_repo.dart';

part 'get_table_state.dart';

class GetTableCubit extends Cubit<GetTableState> {
  GetTableCubit(this.screenRepo) : super(GetScreenInitial());
  final TableRepo screenRepo;
  Future<void> getTable(Pages page) async {
    emit(GetScreenLoading());
    Either<Failure, ScreenModel> result = await screenRepo.getTable(page);
    result.fold((failure) {
      emit(GetScreenFailure(failure.errorMassage));
    }, (menuList) {
      emit(GetScreenSuccess(menuList));
    });
  }
}
