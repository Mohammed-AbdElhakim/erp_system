import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../core/helper/AlertDialog/custom_alert_dialog.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/account_view_model.dart';
import 'package:animated_tree_view/animated_tree_view.dart';

import '../manager/addEditNode/add_edit_node_cubit.dart';
import '../manager/getAccountTree/get_account_tree_cubit.dart';
import 'setting_item.dart';

const expandChildrenOnReady = false;

class AccountingTreeViewBody extends StatefulWidget {
  const AccountingTreeViewBody({super.key, required this.tree});

  final TreeNode<AccountTreeModel> tree;

  @override
  State<AccountingTreeViewBody> createState() => _AccountingTreeViewBodyState();
}

class _AccountingTreeViewBodyState extends State<AccountingTreeViewBody> {
  TreeViewController<AccountTreeModel, TreeNode<AccountTreeModel>>? _controller;
  late final TreeNode<AccountTreeModel> newRoot;

  @override
  void initState() {
    super.initState();

    newRoot = TreeNode<AccountTreeModel>.root()..addAll(widget.tree.children.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: newRoot.expansionNotifier,
        builder: (context, isExpanded, _) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // FloatingActionButton.small(
              //   heroTag: 'AddTag',
              //   backgroundColor: Colors.blue,
              //   onPressed: () {
              //     CustomAlertDialog.alertWithCustomContent(
              //       context: context,
              //       content: CustomShowWidget(
              //         type: "add",
              //         data: (newItem) {
              //           BlocProvider.of<AddEditNodeCubit>(context).add(newData: newItem);
              //           Navigator.pop(context);
              //         },
              //       ),
              //     );
              //   },
              //   child: const Icon(Icons.add),
              // ),
              // const SizedBox(
              //   height: 8,
              // ),
              FloatingActionButton.small(
                heroTag: 'RefreshTag',
                backgroundColor: Colors.orange,
                onPressed: () {
                  BlocProvider.of<GetAccountTreeCubit>(context).getAllAccountTree();
                },
                // label: Text(isTreeExpanded(newRoot) ? "Collapse All" : "Expand All"),
                child: const Icon(Icons.refresh),
              ),
              const SizedBox(
                height: 8,
              ),
              FloatingActionButton.small(
                heroTag: 'CollapseExpandTag',
                backgroundColor: Colors.blue,
                onPressed: () {
                  if (isTreeExpanded(newRoot)) {
                    collapseAfterLevel<AccountTreeModel>(newRoot, 1, _controller!);
                  } else {
                    _controller?.expandAllChildren(newRoot);
                  }
                  setState(() {});
                },
                // label: Text(isTreeExpanded(newRoot) ? "Collapse All" : "Expand All"),
                child: Icon(isTreeExpanded(newRoot) ? Icons.unfold_less : Icons.unfold_more),
              ),
            ],
          );
        },
      ),
      body: TreeView.simple(
        tree: newRoot,
        showRootNode: false,
        expansionIndicatorBuilder: (context, node) => NoExpansionIndicator(
          tree: newRoot,
        ),
        indentation: const Indentation(style: IndentStyle.roundJoint),
        onTreeReady: (controller) {
          _controller = controller;
          if (expandChildrenOnReady) controller.expandAllChildren(newRoot);
        },
        builder: (context, node) => ListTile(
          trailing: Padding(
            padding: EdgeInsetsDirectional.only(end: node.level * 0),
            child: BlocConsumer<AddEditNodeCubit, AddEditNodeState>(
              listener: (context, state) {
                if (state is NodeFailure) {
                  CustomAlertDialog.alertWithButton(
                    context: context,
                    type: AlertType.error,
                    title: S.of(context).error,
                    desc: state.errorMassage,
                  );
                } else if (state is AddNodeSuccess) {
                  setState(() {
                    final newNode = TreeNode<AccountTreeModel>(data: state.dataNodeAdd);
                    node.add(newNode);
                  });
                } else if (state is EditNodeSuccess) {
                  setState(() {
                    node.data = state.dataNodeEdit;
                  });
                } else if (state is DeleteNodeSuccess) {
                  setState(() {
                    node.delete();
                  });
                }
              },
              builder: (context, state) {
                if (state is AddEditNodeLoading) {
                  return const Padding(
                    padding: EdgeInsetsDirectional.only(end: 12),
                    child: SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        )),
                  );
                } else {
                  return SettingItem(
                    item: node.data!,
                    cubit: BlocProvider.of<AddEditNodeCubit>(context),
                    node: node,
                  );
                }
              },
            ),
          ),
          leading: node.isLeaf
              ? null
              : node.isExpanded
                  ? const Icon(
                      Icons.folder_open,
                      color: Colors.blue,
                    )
                  : const Icon(
                      Icons.folder,
                      color: Colors.blue,
                    ),
          title: Text(node.data?.acName ?? ""),
        ),
      ),
    );
  }

  void collapseAfterLevel<T>(
    TreeNode<T> node,
    int maxLevel,
    TreeViewController<T, TreeNode<T>> controller, [
    int currentLevel = 0,
  ]) {
    if (currentLevel >= maxLevel) {
      controller.collapseNode(node);
    } else {
      // تأكد هنا أننا نتعامل مع TreeNode<T> وليس Node
      for (final child in node.children.values) {
        if (child is TreeNode<T>) {
          collapseAfterLevel(child, maxLevel, controller, currentLevel + 1);
        }
      }
    }
  }

  bool isTreeExpanded(TreeNode node) {
    for (final child in node.children.values) {
      if (child is TreeNode && !child.isExpanded) {
        return false;
      }
    }
    return true;
  }
}
