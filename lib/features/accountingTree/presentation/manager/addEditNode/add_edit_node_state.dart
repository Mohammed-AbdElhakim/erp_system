part of 'add_edit_node_cubit.dart';

sealed class AddEditNodeState extends Equatable {
  const AddEditNodeState();

  @override
  List<Object> get props => [];
}

final class AddEditNodeInitial extends AddEditNodeState {}

final class AddEditNodeLoading extends AddEditNodeState {}

final class NodeFailure extends AddEditNodeState {
  final String errorMassage;

  const NodeFailure(this.errorMassage);
}

final class AddNodeSuccess extends AddEditNodeState {
  final AccountTreeModel dataNodeAdd;

  const AddNodeSuccess(this.dataNodeAdd);
}

final class EditNodeSuccess extends AddEditNodeState {
  final AccountTreeModel dataNodeEdit;

  const EditNodeSuccess(this.dataNodeEdit);
}

final class DeleteNodeSuccess extends AddEditNodeState {
  const DeleteNodeSuccess();
}
