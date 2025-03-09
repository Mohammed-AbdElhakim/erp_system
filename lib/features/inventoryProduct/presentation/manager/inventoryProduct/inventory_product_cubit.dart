import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/inventory_product_body_model.dart';
import '../../../data/models/inventory_product_model.dart';
import '../../../data/repositories/inventory_product_repo.dart';

part 'inventory_product_state.dart';

class InventoryProductCubit extends Cubit<InventoryProductState> {
  InventoryProductCubit(this.inventoryProductRepo) : super(InventoryProductInitial());
  final InventoryProductRepo inventoryProductRepo;

  Future<void> getInventoryProduct({
    required InventoryProductBodyModel inventoryProductBody,
  }) async {
    emit(InventoryProductLoading());
    Either<Failure, List<InventoryProductModel>> result =
        await inventoryProductRepo.getInventoryProduct(inventoryProductBody: inventoryProductBody);
    result.fold((failure) {
      emit(InventoryProductFailure(failure.errorMassage));
    }, (inventoryProduct) {
      emit(InventoryProductSuccess(inventoryProduct));
    });
  }
}
