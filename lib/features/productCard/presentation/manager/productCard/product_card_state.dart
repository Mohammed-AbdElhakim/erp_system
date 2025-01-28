part of 'product_card_cubit.dart';

sealed class ProductCardState extends Equatable {
  const ProductCardState();
  @override
  List<Object> get props => [];
}

final class ProductCardInitial extends ProductCardState {}

final class ProductCardLoading extends ProductCardState {}

final class ProductCardFailure extends ProductCardState {
  final String errorMassage;

  const ProductCardFailure(this.errorMassage);
}

final class ProductCardSuccess extends ProductCardState {
  final ProductCardModel productCardModel;
  final int numberPage;
  final int dropdownValue;

  const ProductCardSuccess(
      {required this.productCardModel,
      required this.numberPage,
      required this.dropdownValue});
}
