import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:erp_system/features/screenTable/data/models/item_list_setup_model.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/repositories/screen_repo.dart';

part 'get_list_setups_state.dart';

class GetListSetupsCubit extends Cubit<GetListSetupsState> {
  GetListSetupsCubit(this.screenRepo) : super(GetListSetupsInitial());
  final ScreenRepo screenRepo;
  Future<void> getListSetups(String pageListName) async {
    emit(GetListSetupsLoading());
    Either<Failure, List<ItemListSetupModel>> result =
        await screenRepo.getListSetups(pageListName: pageListName);
    result.fold((failure) {
      emit(GetListSetupsFailure(failure.errorMassage));
    }, (listSetupModel) {
      emit(GetListSetupsSuccess(listSetupModel));
    });
  }
}
