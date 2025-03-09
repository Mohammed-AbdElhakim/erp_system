part of 'inventory_product_cubit.dart';

sealed class InventoryProductState extends Equatable {
  const InventoryProductState();
  @override
  List<Object> get props => [];
}

final class InventoryProductInitial extends InventoryProductState {}

final class InventoryProductLoading extends InventoryProductState {}

final class InventoryProductFailure extends InventoryProductState {
  final String errorMassage;

  const InventoryProductFailure(this.errorMassage);
}

final class InventoryProductSuccess extends InventoryProductState {
  final List<InventoryProductModel> inventoryProductModel;

  const InventoryProductSuccess(this.inventoryProductModel);
}
