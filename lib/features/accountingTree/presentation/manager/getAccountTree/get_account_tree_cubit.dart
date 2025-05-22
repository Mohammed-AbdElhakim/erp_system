import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/account_view_model.dart';
import '../../../data/repositories/account_tree_repo.dart';

part 'get_account_tree_state.dart';

class GetAccountTreeCubit extends Cubit<GetAccountTreeState> {
  GetAccountTreeCubit(this.accountTreeRepo) : super(GetAccountTreeInitial());
  final AccountTreeRepo accountTreeRepo;
  TreeNode<AccountTreeModel>? currentTree;

  Future<void> getAllAccountTree() async {
    emit(GetAccountTreeLoading());

    Either<Failure, List<AccountTreeModel>> result = await accountTreeRepo.getAllAccountTree();
    result.fold((failure) {
      emit(GetAccountTreeFailure(failure.errorMassage));
    }, (data) {
      final tree = buildTree(data);
      currentTree = tree;
      emit(GetAccountTreeSuccess(tree));
    });
  }

  TreeNode<AccountTreeModel> buildTree(List<AccountTreeModel> accounts) {
    final Map<int, TreeNode<AccountTreeModel>> nodeMap = {};
    final TreeNode<AccountTreeModel> root = TreeNode.root();

    // أولاً: أنشئ كل العقد
    for (var account in accounts) {
      nodeMap[account.acId!] = TreeNode<AccountTreeModel>(
        key: account.acId.toString(),
        data: account,
      );
    }

    // ثانياً: اربط كل عقدة بأبوها
    for (var account in accounts) {
      final node = nodeMap[account.acId!];
      final parentId = account.acParent;
      if (parentId != null && nodeMap.containsKey(parentId)) {
        nodeMap[parentId]!.add(node!);
      } else {
        // لو مفيش أب (يعني عنصر جذري)
        root.add(node!);
      }
    }

    return root;
  }
}
