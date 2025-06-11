import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/cost_item_account_report_model0.dart';
import '../../../data/models/cost_item_account_report_model1.dart';
import '../../../data/models/cost_item_account_report_model2.dart';
import '../../../data/models/cost_item_account_report_model3.dart';
import '../../../data/models/cost_item_account_report_model4.dart';
import '../../../data/repositories/cost_item_account_report_repo.dart';

part 'cost_item_account_report_state.dart';

class CostItemAccountReportCubit extends Cubit<CostItemAccountReportState> {
  CostItemAccountReportCubit(this.costItemAccountReportRepo) : super(CostItemAccountReportInitial());
  final CostItemAccountReportRepo costItemAccountReportRepo;

  Future<void> getTableCostItemAccountReport({
    required Map<String, dynamic> objectData,
    required String link,
    required int numberOfPage,
    required int dropdownValueOfLimit,
    required int selectTab,
  }) async {
    emit(CostItemAccountReportLoading());
    Either<Failure, Map<String, dynamic>> result =
        await costItemAccountReportRepo.getTableCostItemAccountReport(objectData: objectData, link: link);
    result.fold((failure) {
      emit(CostItemAccountReportFailure(failure.errorMassage));
    }, (costItemAccountReportModel) {
      if (selectTab == 0) {
        CostItemAccountReportModel0 costItemAccountReportModel0 =
            CostItemAccountReportModel0.fromJson(costItemAccountReportModel);
        emit(CostItemAccountReportSuccess(
            costItemAccountReportModel: costItemAccountReportModel0,
            numberPage: numberOfPage,
            dropdownValue: dropdownValueOfLimit,
            selectTap: selectTab));
      } else if (selectTab == 1) {
        CostItemAccountReportModel1 costItemAccountReportModel1 =
            CostItemAccountReportModel1.fromJson(costItemAccountReportModel);
        emit(CostItemAccountReportSuccess(
            costItemAccountReportModel: costItemAccountReportModel1,
            numberPage: numberOfPage,
            dropdownValue: dropdownValueOfLimit,
            selectTap: selectTab));
      } else if (selectTab == 2) {
        CostItemAccountReportModel2 costItemAccountReportModel2 =
            CostItemAccountReportModel2.fromJson(costItemAccountReportModel);
        emit(CostItemAccountReportSuccess(
            costItemAccountReportModel: costItemAccountReportModel2,
            numberPage: numberOfPage,
            dropdownValue: dropdownValueOfLimit,
            selectTap: selectTab));
      } else if (selectTab == 3) {
        CostItemAccountReportModel3 costItemAccountReportModel3 =
            CostItemAccountReportModel3.fromJson(costItemAccountReportModel);
        emit(CostItemAccountReportSuccess(
            costItemAccountReportModel: costItemAccountReportModel3,
            numberPage: numberOfPage,
            dropdownValue: dropdownValueOfLimit,
            selectTap: selectTab));
      } else if (selectTab == 4) {
        CostItemAccountReportModel4 costItemAccountReportModel4 =
            CostItemAccountReportModel4.fromJson(costItemAccountReportModel);
        emit(CostItemAccountReportSuccess(
            costItemAccountReportModel: costItemAccountReportModel4,
            numberPage: numberOfPage,
            dropdownValue: dropdownValueOfLimit,
            selectTap: selectTab));
      }
    });
  }
}
