import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/product_card_model.dart';
import '../../../data/repositories/product_card_repo.dart';

part 'product_card_state.dart';

class ProductCardCubit extends Cubit<ProductCardState> {
  ProductCardCubit(this.productCardRepo) : super(ProductCardInitial());
  final ProductCardRepo productCardRepo;

  Future<void> getTableProductCard({
    required Map<String, dynamic> objectData,
    required int numberOfPage,
    required int dropdownValueOfLimit,
  }) async {
    emit(ProductCardLoading());
    Either<Failure, ProductCardModel> result =
        await productCardRepo.getTableProductCard(objectData: objectData);
    result.fold((failure) {
      emit(ProductCardFailure(failure.errorMassage));
    }, (accountProfModel) {
      emit(ProductCardSuccess(
          productCardModel: accountProfModel,
          numberPage: numberOfPage,
          dropdownValue: dropdownValueOfLimit));
    });
  }
}
