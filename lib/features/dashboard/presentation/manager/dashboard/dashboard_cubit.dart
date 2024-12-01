
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/dashboard_model.dart';
import '../../../data/repositories/dashboard_repo.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit(this.dashboardRepo) : super(DashboardInitial());

  final DashboardRepo dashboardRepo;

  Future<void> getDashboard() async {
    emit(DashboardLoading());
    Either<Failure, DashboardModel> result = await dashboardRepo
        .getDashboard();
    result.fold((failure) {
      emit(DashboardFailure(failure.errorMassage));
    }, (data) {
      emit(DashboardSuccess(data));
    });
  }
}
