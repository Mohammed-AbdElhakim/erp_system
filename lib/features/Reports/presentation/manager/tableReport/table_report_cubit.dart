import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:erp_system/features/Reports/data/models/table_model.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/repositories/reports_repo.dart';

part 'table_report_state.dart';

class TableReportCubit extends Cubit<TableReportState> {
  TableReportCubit(this.reportsRepo) : super(TableReportInitial());
  final ReportsRepo reportsRepo;

  Future<void> getTableReport({
    required int reportId,
  }) async {
    emit(TableReportLoading());

    Either<Failure, TableModel> result =
        await reportsRepo.getTableReports(reportId: reportId);
    result.fold((failure) {
      emit(TableReportFailure(failure.errorMassage));
    }, (tableReport) {
      emit(TableReportSuccess(tableReport));
    });
  }
}
