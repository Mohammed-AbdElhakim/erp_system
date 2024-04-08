import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/models/menu_model/pages.dart';
import '../../../../screenTable/data/models/column_data_model.dart';
import '../../../data/repositories/screen_repo.dart';

part 'get_table_state.dart';

class GetTableCubit extends Cubit<GetTableState> {
  GetTableCubit(this.screenRepo) : super(GetTableInitial());
  final ScreenRepo screenRepo;
  Future<void> getTable(Pages page) async {
    emit(GetTableLoading());
    Either<Failure, ScreenModel> result = await screenRepo.getTable(page);
    result.fold((failure) {
      emit(GetTableFailure(failure.errorMassage));
    }, (menuList) {
      emit(GetTableSuccess(menuList));
    });
  }
}
