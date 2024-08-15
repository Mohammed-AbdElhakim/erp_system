import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:erp_system/features/cashier/data/models/modality_model.dart';
import 'package:erp_system/features/cashier/data/models/pro_company_model.dart';
import 'package:erp_system/features/cashier/data/models/product_model.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/repositories/cashier_repo.dart';

part 'cashier_state.dart';

class CashierCubit extends Cubit<CashierState> {
  CashierCubit(this.cashierRepo) : super(CashierInitial());
  final CashierRepo cashierRepo;
  Future<void> getCashierData() async {
    emit(CashierLoading());
    getProCompany();
  }

  void getProCompany() async {
    Either<Failure, PRoCompanyModel> proCompanyModel =
        await cashierRepo.getProCompany();

    proCompanyModel.fold((failure) {
      emit(CashierFailure(failure.errorMassage));
    }, (proCompany) {
      getModality(
        proCompanyList: proCompany.proCompanyList!,
      );
    });
  }

  void getModality({
    required List<PRoCompanyItem> proCompanyList,
  }) async {
    Either<Failure, ModalityModel> modalityModel =
        await cashierRepo.getModality();

    modalityModel.fold((failure) {
      emit(CashierFailure(failure.errorMassage));
    }, (modality) {
      getProduct(
        proCompanyList: proCompanyList,
        modalityList: modality.modalityList!,
      );
    });
  }

  void getProduct({
    required List<PRoCompanyItem> proCompanyList,
    required List<ModalityItem> modalityList,
  }) async {
    Either<Failure, ProductModel> productModel = await cashierRepo.getProduct();

    productModel.fold((failure) {
      emit(CashierFailure(failure.errorMassage));
    }, (product) {
      emit(
        CashierSuccess(
          modalityList: modalityList,
          pRoCompanyList: proCompanyList,
          productList: product.productList!,
        ),
      );
    });
  }
}
