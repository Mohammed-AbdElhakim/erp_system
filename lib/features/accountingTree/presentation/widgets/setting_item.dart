import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../core/helper/AlertDialog/custom_alert_dialog.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/account_view_model.dart';
import '../manager/addEditNode/add_edit_node_cubit.dart';
import 'custom_show_widget.dart';

class SettingItem extends StatefulWidget {
  const SettingItem({
    super.key,
    required this.item,
    required this.cubit,
    required this.node,
  });

  final AccountTreeModel item;
  final AddEditNodeCubit cubit;
  final TreeNode<AccountTreeModel> node;

  @override
  State<SettingItem> createState() => _SettingItemState();
}

class _SettingItemState extends State<SettingItem> {
  final GlobalKey _menuKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        _showDetails(context);
      },
      onTap: () {
        _showPopupMenu();
      },
      child: PopupMenuButton<String>(
        key: _menuKey,
        icon: const Icon(
          Icons.settings,
          color: Colors.blue,
        ),
        onSelected: (String value) {
          switch (value) {
            case "add":
              _showAdd(context);
              setState(() {});
              break;
            case "edit":
              _showEdit(context);
              setState(() {});
              break;
            case "delete":
              _deleteItem(context);
              break;
            case "show":
              _showDetails(context);
              break;
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: 'add',
            child: popupMenuItemChild(context, S.of(context).btn_add, Icons.add, Colors.blue),
          ),
          PopupMenuItem<String>(
            value: 'edit',
            child: popupMenuItemChild(context, S.of(context).btn_edit, Icons.edit, Colors.green),
          ),
          PopupMenuItem<String>(
            value: 'delete',
            child: popupMenuItemChild(context, S.of(context).btn_delete, Icons.delete, Colors.red),
          ),
          PopupMenuItem<String>(
            value: 'show',
            child: popupMenuItemChild(context, S.of(context).btn_show, Icons.visibility, Colors.blue),
          ),
        ],
      ),
    );
  }

  Widget popupMenuItemChild(BuildContext context, String title, IconData icon, Color iconColor) => Row(
        children: [
          Icon(
            icon,
            color: iconColor,
          ),
          const SizedBox(width: 16),
          Text(title),
        ],
      );

  void _showPopupMenu() {
    final dynamic popupMenuState = _menuKey.currentState;
    popupMenuState.showButtonMenu();
  }

  void _deleteItem(BuildContext context) {
    CustomAlertDialog.alertWithCustomButtons(
      context: context,
      type: AlertType.warning,
      title: S.of(context).massage_delete2,
      buttons: [
        DialogButton(
          onPressed: () {
            widget.cubit.delete(id: widget.item.acId!);
            Navigator.pop(context);
          },
          // gradient: gradientButton,
          width: 120,
          color: AppColors.red,
          child: Text(
            S.of(context).btn_delete,
            style: const TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
        DialogButton(
          onPressed: () {
            Navigator.pop(context);
          },
          width: 120,
          color: AppColors.grey,
          child: Text(
            S.of(context).cancel,
            style: const TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  void _showDetails(BuildContext context) {
    CustomAlertDialog.alertWithCustomContent(
      context: context,
      content: BlocProvider.value(
        value: widget.cubit,
        child: CustomShowWidget(
          item: widget.item,
          type: "show",
        ),
      ),
    );
  }

  void _showEdit(BuildContext context) {
    CustomAlertDialog.alertWithCustomContent(
      context: context,
      content: BlocProvider.value(
        value: widget.cubit,
        child: CustomShowWidget(
          item: widget.item,
          type: "edit",
          data: (newItem) {
            widget.cubit.edit(newData: newItem);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void _showAdd(BuildContext context) {
    CustomAlertDialog.alertWithCustomContent(
      context: context,
      content: BlocProvider.value(
        value: widget.cubit,
        child: CustomShowWidget(
          item: widget.item,
          type: "add",
          data: (newItem) {
            widget.cubit.add(newData: newItem);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
