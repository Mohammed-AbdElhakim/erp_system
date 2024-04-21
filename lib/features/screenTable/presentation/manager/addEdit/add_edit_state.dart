part of 'add_edit_cubit.dart';

sealed class AddEditState extends Equatable {
  const AddEditState();
}

final class AddEditInitial extends AddEditState {
  @override
  List<Object> get props => [];
}
