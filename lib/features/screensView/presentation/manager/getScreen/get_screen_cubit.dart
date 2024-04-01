import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:erp_system/core/models/menu_model/pages.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/column_data_model.dart';
import '../../../data/repositories/screen_repo.dart';

part 'get_screen_state.dart';

class GetScreenCubit extends Cubit<GetScreenState> {
  GetScreenCubit(this.screenRepo) : super(GetScreenInitial());
  final ScreenRepo screenRepo;
  Future<void> getScreen(Pages page) async {
    emit(GetScreenLoading());
    Either<Failure, ScreenModel> result = await screenRepo.getScreen(page);
    result.fold((failure) {
      emit(GetScreenFailure(failure.errorMassage));
    }, (menuList) {
      emit(GetScreenSuccess(menuList));
    });
  }
}
