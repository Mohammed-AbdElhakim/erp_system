import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/models/menu_model/menu_model.dart';
import '../../repositories/menu/menu_repo.dart';

part 'get_menu_state.dart';

class GetMenuCubit extends Cubit<GetMenuState> {
  GetMenuCubit(this.menuRepo) : super(GetMenuInitial());

  final MenuRepo menuRepo;
  Future<void> getMenu() async {
    emit(GetMenuLoading());
    Either<Failure, MenuModel> result = await menuRepo.getMenu();
    result.fold((failure) {
      emit(GetMenuFailure(failure.errorMassage));
    }, (menuList) {
      emit(GetMenuSuccess(menuList));
    });
  }
}
