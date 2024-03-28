import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:erp_system/features/home/data/models/menu_model.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/repositories/menu/menu_repo.dart';

part 'get_menu_state.dart';

class GetMenuCubit extends Cubit<GetMenuState> {
  GetMenuCubit(this.menuRepo) : super(GetMenuInitial());

  final MenuRepo menuRepo;
  Future<void> getMenu() async {
    emit(GetMenuLoading());
    Either<Failure, List<MenuModel>> result = await menuRepo.getMenu();
    result.fold((failure) {
      emit(GetMenuFailure(failure.errorMassage));
    }, (menuList) {
      emit(GetMenuSuccess(menuList));
    });
  }
}
