import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/report_model.dart';
import '../../../data/repositories/reports_repo.dart';

part 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  ReportsCubit(this.reportsRepo) : super(ReportsInitial());
  final ReportsRepo reportsRepo;

  Future<void> getAllDropdownList({
    required int pageId,
  }) async {
    emit(ReportsLoading());

    Either<Failure, List<ReportModel>> result =
        await reportsRepo.getReports(pageId);
    result.fold((failure) {
      emit(ReportsFailure(failure.errorMassage));
    }, (reports) {
      emit(ReportsSuccess(reports));
    });
  }
}
