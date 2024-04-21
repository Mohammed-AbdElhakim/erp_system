part of 'add_edit_cubit.dart';

sealed class AddEditState extends Equatable {
  const AddEditState();
  @override
  List<Object> get props => [];
}

final class AddEditInitial extends AddEditState {}

final class AddEditLoading extends AddEditState {}

final class AddEditFailure extends AddEditState {
  final String errorMassage;

  const AddEditFailure(this.errorMassage);
}

final class AddEditSuccess extends AddEditState {
  // final LoginModel loginModel;

  // const AddEditSuccess(this.loginModel);
}
