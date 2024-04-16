import 'package:erp_system/features/screenTable/presentation/manager/getPermissions/get_permissions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../../../core/helper/AlertDialog/custom_alert_dialog.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/permission_model.dart';
import '../../data/models/screen_model.dart';
import '../manager/getTable/get_table_cubit.dart';
import 'color_picker_widget.dart';
import 'text_widget.dart';

class CustomFloatingActionButton extends StatefulWidget {
  const CustomFloatingActionButton({super.key});

  @override
  State<CustomFloatingActionButton> createState() =>
      _CustomFloatingActionButtonState();
}

class _CustomFloatingActionButtonState
    extends State<CustomFloatingActionButton> {
  String? lang;

  bool delete = false;
  bool edit = false;
  bool add = false;
  bool search = false;

  List<Map<String, dynamic>> listData = [];
  List<ColumnList> listHeader = [];
  List<dynamic> listKey = [];

  List<IconData> iconList = [
    // Icons.search,
    // Icons.search,
    // Icons.search,
    // Icons.search,
    // Icons.search,
  ];

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetPermissionsCubit, GetPermissionsState>(
      listener: (context, state) {
        if (state is GetPermissionSuccess) {
          PermissionModel permissionModel = state.permissionModel;
          if (permissionModel.showSearch == true) {
            setState(() {
              iconList.add(Icons.search);
            });
          }
          if (permissionModel.showRefersh == true) {
            setState(() {
              iconList.add(Icons.refresh);
            });
          }
          if (permissionModel.showDelete == true) {
            setState(() {
              iconList.add(Icons.delete);
            });
          }

          if (permissionModel.showEdit == true) {
            setState(() {
              iconList.add(Icons.edit_note);
            });
          }
          if (permissionModel.showNew == true) {
            setState(() {
              iconList.add(Icons.add);
            });
          }
        }
      },
      child: BlocListener<GetTableCubit, GetTableState>(
        listener: (context, state) {
          if (state is GetTableSuccess) {
            listData.addAll(state.screenModel.dataList!);
            listHeader.addAll(state.screenModel.columnList!);
            for (var item in state.screenModel.columnList!) {
              listKey.add(item.columnName);
            }
          }
        },
        child: SpeedDial(
          backgroundColor: AppColors.blueLight,
          overlayOpacity: 0.5,
          activeIcon: Icons.close,
          iconTheme: IconThemeData(color: AppColors.white),
          buttonSize: const Size(58, 58),
          curve: Curves.easeIn,
          children: List.generate(
            iconList.length,
            (index) => SpeedDialChild(
                elevation: 0,
                backgroundColor: getColor(iconList[index]),
                shape: const CircleBorder(),
                child: Icon(
                  iconList[index],
                  color: AppColors.white,
                ),
                onTap: () {
                  tapIcon(iconList[index]);
                }),
          ),
          child: Icon(
            Icons.settings,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  getColor(IconData icon) {
    if (icon == Icons.search) {
      return AppColors.blue;
    } else if (icon == Icons.refresh) {
      return AppColors.orange;
    } else if (icon == Icons.delete) {
      return AppColors.red;
    } else if (icon == Icons.edit_note) {
      return AppColors.blueGreyDark;
    } else if (icon == Icons.add) {
      return AppColors.blueLight;
    }
  }

  void tapIcon(IconData icon) {
    if (icon == Icons.search) {
      CustomAlertDialog.alertWithCustomContent(
          context: context,
          title: S.of(context).btn_search,
          isOverlayTapDismiss: false,
          content: buildAlertWithCustomContent(),
          textButton: S.of(context).btn_search,
          onPressed: () {});
    } else if (icon == Icons.refresh) {
      // print("refresh");
    } else if (icon == Icons.delete) {
      // print("delete");
    } else if (icon == Icons.edit_note) {
      CustomAlertDialog.alertWithCustomContent(
          context: context,
          title: S.of(context).btn_edit,
          isOverlayTapDismiss: false,
          content: buildAlertWithCustomContent(),
          textButton: S.of(context).btn_edit,
          onPressed: () {});
    } else if (icon == Icons.add) {
      CustomAlertDialog.alertWithCustomContent(
          context: context,
          title: S.of(context).btn_add,
          isOverlayTapDismiss: false,
          content: buildAlertWithCustomContent(),
          textButton: S.of(context).btn_add,
          onPressed: () {});
    }
  }

  buildAlertWithCustomContent() {
    return Column(
      children: getMyWidgetInAlertWithCustomContent(listHeader),
    );
  }

  List<Widget> getMyWidgetInAlertWithCustomContent(
      List<ColumnList> listHeader) {
    List<Widget> listWidgets = [];

    for (var item in listHeader) {
      if (item.insertType == "text") {
        listWidgets.add(
          TextWidget(
            title: lang == AppStrings.arLangKey
                ? item.arColumnLabel!
                : item.enColumnLabel!,
            typeInput: 'text',
          ),
        );
      }
      if (item.insertType == "number") {
        listWidgets.add(
          TextWidget(
            title: lang == AppStrings.arLangKey
                ? item.arColumnLabel!
                : item.enColumnLabel!,
            typeInput: 'number',
          ),
        );
      }
      if (item.insertType == "color") {
        listWidgets.add(ColorPickerWidget(
          title: lang == AppStrings.arLangKey
              ? item.arColumnLabel!
              : item.enColumnLabel!,
        ));
      }
    }
    return listWidgets;
  }
}
