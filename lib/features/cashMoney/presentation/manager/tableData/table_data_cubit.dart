import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:erp_system/features/cashMoney/data/repositories/cashMoney/cash_money_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/table_data_model.dart';

part 'table_data_state.dart';

class GetTableDataCubit extends Cubit<GetTableDataState> {
  GetTableDataCubit(this.cashMoneyRepo) : super(GetTableDataInitial());
  final CashMoneyRepo cashMoneyRepo;

  Future<void> getGetTableData({
    required Map<String, dynamic> bodyRequest,
    required int numberOfPage,
    required int dropdownValueOfLimit,
  }) async {
    emit(GetTableDataLoading());
    Either<Failure, TableDataModel> result = await cashMoneyRepo.getTableData(bodyRequest: bodyRequest);
    result.fold((failure) {
      emit(GetTableDataFailure(failure.errorMassage));
    }, (data) {
      emit(GetTableDataSuccess(data: data, numberPage: numberOfPage, dropdownValue: dropdownValueOfLimit));
    });
  }
}
