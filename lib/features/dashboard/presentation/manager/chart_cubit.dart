import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:erp_system/features/dashboard/data/models/dashboard_model.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/chart_model.dart';
import '../../data/repositories/chart_repo.dart';

part 'chart_state.dart';

class ChartCubit extends Cubit<ChartState> {
  ChartCubit(this.chartRepo) : super(ChartInitial());
  final ChartRepo chartRepo;
  Future<void> getDashboard() async {
    emit(ChartLoading());
    Either<Failure, DashboardModel> result = await chartRepo.getChartMaster();
    result.fold((failure) {
      emit(ChartFailure(failure.errorMassage));
    }, (send) {
      emit(ChartSuccess());
    });
  }

  Future<void> getChartData({
    required String tableOrView,
  }) async {
    emit(ChartLoading());
    Either<Failure, ChartModel> result =
        await chartRepo.getChartData(tableOrView: tableOrView);
    result.fold((failure) {
      emit(ChartFailure(failure.errorMassage));
    }, (send) {
      emit(ChartSuccess());
    });
  }
}
