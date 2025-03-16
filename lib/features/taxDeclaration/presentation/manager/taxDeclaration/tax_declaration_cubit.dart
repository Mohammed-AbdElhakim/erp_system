import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/tax_declaration_model0.dart';
import '../../../data/models/tax_declaration_model1.dart';
import '../../../data/models/tax_declaration_model2.dart';
import '../../../data/models/tax_declaration_model3.dart';
import '../../../data/repositories/tax_declaration_repo.dart';

part 'tax_declaration_state.dart';

class TaxDeclarationCubit extends Cubit<TaxDeclarationState> {
  TaxDeclarationCubit(this.taxDeclarationRepo) : super(TaxDeclarationInitial());
  final TaxDeclarationRepo taxDeclarationRepo;

  Future<void> getTableTaxDeclaration({
    required Map<String, dynamic> objectData,
    required String link,
    required int numberOfPage,
    required int dropdownValueOfLimit,
    required int selectTab,
  }) async {
    emit(TaxDeclarationLoading());
    Either<Failure, Map<String, dynamic>> result = await taxDeclarationRepo
        .getTableTaxDeclaration(objectData: objectData, link: link);
    result.fold((failure) {
      emit(TaxDeclarationFailure(failure.errorMassage));
    }, (dataModel) {
      if (selectTab == 0) {
        TaxDeclarationModel0 taxDeclarationModel0 =
            TaxDeclarationModel0.fromJson(dataModel);
        emit(TaxDeclarationSuccess(
            taxDeclarationModel: taxDeclarationModel0,
            numberPage: numberOfPage,
            dropdownValue: dropdownValueOfLimit,
            selectTap: selectTab));
      } else if (selectTab == 1) {
        TaxDeclarationModel1 taxDeclarationModel1 =
            TaxDeclarationModel1.fromJson(dataModel);
        emit(TaxDeclarationSuccess(
            taxDeclarationModel: taxDeclarationModel1,
            numberPage: numberOfPage,
            dropdownValue: dropdownValueOfLimit,
            selectTap: selectTab));
      } else if (selectTab == 2) {
        TaxDeclarationModel2 taxDeclarationModel2 =
            TaxDeclarationModel2.fromJson(dataModel);
        emit(TaxDeclarationSuccess(
            taxDeclarationModel: taxDeclarationModel2,
            numberPage: numberOfPage,
            dropdownValue: dropdownValueOfLimit,
            selectTap: selectTab));
      } else if (selectTab == 3) {
        TaxDeclarationModel3 taxDeclarationModel3 =
            TaxDeclarationModel3.fromJson(dataModel);
        emit(TaxDeclarationSuccess(
            taxDeclarationModel: taxDeclarationModel3,
            numberPage: numberOfPage,
            dropdownValue: dropdownValueOfLimit,
            selectTap: selectTab));
      }
    });
  }
}
