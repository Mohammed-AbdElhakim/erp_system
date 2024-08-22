import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/item_list_setup_model.dart';
import '../../../data/repositories/cashier_repo.dart';

part 'get_list_setups_state.dart';

class GetListSetupsCubit extends Cubit<GetListSetupsState> {
  GetListSetupsCubit(this.cashierRepo) : super(GetListSetupsInitial());
  final CashierRepo cashierRepo;
  Future<void> getListSetups(String pageListName) async {
    emit(GetListSetupsLoading());
    Either<Failure, List<ItemListSetupModel>> result =
        await cashierRepo.getListSetups(pageListName: pageListName);
    result.fold((failure) {
      emit(GetListSetupsFailure(failure.errorMassage));
    }, (listSetupModel) {
      emit(GetListSetupsSuccess(listSetupModel));
    });
  }
}
