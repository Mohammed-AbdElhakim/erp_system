part of 'add_edit_product_cubit.dart';

sealed class AddEditProductState extends Equatable {
  const AddEditProductState();
  @override
  List<Object> get props => [];
}

final class AddEditProductInitial extends AddEditProductState {}

final class AddEditProductLoading extends AddEditProductState {}

final class AddEditProductFailure extends AddEditProductState {
  final String errorMassage;

  const AddEditProductFailure(this.errorMassage);
}

final class AddEditProductSuccess extends AddEditProductState {}
