import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/models/menu_model/pages.dart';
import '../../../data/repositories/screen_repo.dart';
import '../../../data/models/screen_model.dart';

part 'get_file_excel_state.dart';

class GetFileExcelCubit extends Cubit<GetFileExcelState> {
  GetFileExcelCubit(this.screenRepo) : super(GetFileExcelInitial());
  final ScreenRepo screenRepo;
  Future<void> getFileExcel({
    required Pages pageData,
  }) async {
    emit(GetFileExcelLoading());
    Either<Failure, ScreenModel> result = await screenRepo.getTable(
        pageId: pageData.pageId,
        employee: false,
        isdesc: pageData.isDesc,
        limit: 0,
        offset: 0,
        orderby: pageData.orderBy,
        statment: '',
        selectcolumns: '',
        departmentName: pageData.departmentName,
        isDepartment:pageData.isDepartment,
        authorizationID: pageData.authorizationID,
        viewEmployeeColumn: pageData.viewEmployeeColumn,
    );
    result.fold((failure) {
      emit(GetFileExcelFailure(failure.errorMassage));
    }, (data) {
      emit(GetFileExcelSuccess(data));
    });
  }

}
