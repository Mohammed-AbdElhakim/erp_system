import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../screenTable/data/models/screen_model.dart';
import '../../../data/repositories/screen_repo.dart';

part 'get_table_state.dart';

class GetTableCubit extends Cubit<GetTableState> {
  GetTableCubit(this.screenRepo) : super(GetTableInitial());
  final ScreenRepo screenRepo;

  Future<void> getTable({
    required String pageId,
    required bool employee,
    required bool isdesc,
    required int limit,
    required int offset,
    required String orderby,
    required String statment,
    required String selectcolumns,
    required int numberOfPage,
    required int dropdownValueOfLimit,
  }) async {
    emit(GetTableLoading());
    Either<Failure, ScreenModel> result = await screenRepo.getTable(
      pageId: pageId,
      employee: employee,
      isdesc: isdesc,
      limit: limit,
      offset: offset,
      orderby: orderby,
      statment: statment,
      selectcolumns: selectcolumns,
    );
    result.fold((failure) {
      emit(GetTableFailure(failure.errorMassage));
    }, (menuList) {
      emit(GetTableSuccess(menuList, numberOfPage, dropdownValueOfLimit));
    });
  }
}
