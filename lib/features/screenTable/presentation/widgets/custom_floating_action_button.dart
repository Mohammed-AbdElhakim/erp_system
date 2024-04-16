import 'package:erp_system/core/widgets/custom_button.dart';
import 'package:erp_system/features/screenTable/presentation/manager/getPermissions/get_permissions_cubit.dart';
import 'package:erp_system/features/screenTable/presentation/widgets/dropdown_widget.dart';
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
import 'check_box_widget.dart';
import 'color_picker_widget.dart';
import 'date_widget.dart';
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

  List<Map<String, dynamic>> listData = [];
  List<ColumnList> listHeader = [];
  List<dynamic> listKey = [];

  List<IconData> iconList = [
    Icons.search,
    Icons.refresh,
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
        content: buildAlertWithCustomContent(type: 'search'),
      );
    } else if (icon == Icons.refresh) {
      // print("refresh");
    } else if (icon == Icons.delete) {
      // print("delete");
    } else if (icon == Icons.edit_note) {
      CustomAlertDialog.alertWithCustomContent(
        context: context,
        title: S.of(context).btn_edit,
        isOverlayTapDismiss: false,
        content: buildAlertWithCustomContent(type: 'edit'),
      );
    } else if (icon == Icons.add) {
      CustomAlertDialog.alertWithCustomContent(
        context: context,
        title: S.of(context).btn_add,
        isOverlayTapDismiss: false,
        content: buildAlertWithCustomContent(type: 'add'),
      );
    }
  }

  buildAlertWithCustomContent({required String type}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (type == 'search')
          ...getMyWidgetInAlertWithCustomContentToSearch(listHeader),
        if (type != 'search')
          ...getMyWidgetInAlertWithCustomContentToAddAndEdit(listHeader),
        Padding(
          padding: const EdgeInsets.only(top: 45),
          child: Center(
            child: CustomButton(
              text: type == 'search'
                  ? S.of(context).btn_search
                  : type == 'add'
                      ? S.of(context).btn_add
                      : S.of(context).btn_edit,
              width: 80,
            ),
          ),
        )
      ],
    );
  }

  List<Widget> getMyWidgetInAlertWithCustomContentToSearch(
      List<ColumnList> listHeader) {
    List<Widget> listWidgets = [];

    for (var item in listHeader) {
      String title = lang == AppStrings.arLangKey
          ? item.arColumnLabel!
          : item.enColumnLabel!;
      if (item.insertType == "text" && item.visible == true) {
        listWidgets.add(
          TextWidget(
            title: title,
            typeInput: 'text',
          ),
        );
      }
      if (item.insertType == "number" && item.visible == true) {
        listWidgets.add(
          TextWidget(
            title: title,
            typeInput: 'number',
          ),
        );
      }
      if (item.insertType == "color" && item.visible == true) {
        listWidgets.add(ColorPickerWidget(
          title: title,
        ));
      }
      if (item.insertType == "date" && item.visible == true) {
        listWidgets.add(DateWidget(
          title: title,
        ));
      }
      if (item.insertType == "dropdown" && item.visible == true) {
        listWidgets.add(DropdownWidget(title: title));
      }
      if (item.insertType == "checkbox" && item.visible == true) {
        listWidgets.add(CheckBoxWidget(title: title));
      }
    }
    return listWidgets;
  }

  List<Widget> getMyWidgetInAlertWithCustomContentToAddAndEdit(
      List<ColumnList> listHeader) {
    List<Widget> listWidgets = [];

    for (var item in listHeader) {
      String title = lang == AppStrings.arLangKey
          ? item.arColumnLabel!
          : item.enColumnLabel!;
      if (item.insertType == "text" && item.insertVisable == true) {
        listWidgets.add(
          TextWidget(
            title: title,
            typeInput: 'text',
          ),
        );
      }
      if (item.insertType == "number" && item.insertVisable == true) {
        listWidgets.add(
          TextWidget(
            title: title,
            typeInput: 'number',
          ),
        );
      }
      if (item.insertType == "color" && item.insertVisable == true) {
        listWidgets.add(ColorPickerWidget(
          title: title,
        ));
      }
      if (item.insertType == "date" && item.insertVisable == true) {
        listWidgets.add(DateWidget(
          title: title,
        ));
      }
      if (item.insertType == "dropdown" && item.insertVisable == true) {
        listWidgets.add(DropdownWidget(title: title));
      }
      if (item.insertType == "checkbox" && item.insertVisable == true) {
        listWidgets.add(CheckBoxWidget(title: title));
      }
    }
    return listWidgets;
  }
}
