part of 'get_account_tree_cubit.dart';

sealed class GetAccountTreeState extends Equatable {
  const GetAccountTreeState();

  @override
  List<Object> get props => [];
}

final class GetAccountTreeInitial extends GetAccountTreeState {}

final class GetAccountTreeLoading extends GetAccountTreeState {}

final class GetAccountTreeFailure extends GetAccountTreeState {
  final String errorMassage;

  const GetAccountTreeFailure(this.errorMassage);
}

final class GetAccountTreeSuccess extends GetAccountTreeState {
  final TreeNode<AccountTreeModel> accountTree;

  const GetAccountTreeSuccess(this.accountTree);

  @override
  List<Object> get props => [accountTree];
}
