import 'package:erp_system/features/screenTable/presentation/manager/getPermissions/get_permissions_cubit.dart';
import 'package:erp_system/features/screenTable/presentation/widgets/screen_table_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../core/helper/AlertDialog/custom_alert_dialog.dart';
import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/permission_model.dart';
import '../../data/models/screen_model.dart';
import '../manager/delete/delete_cubit.dart';
import '../manager/getTable/get_table_cubit.dart';
import 'build_alert_add.dart';
import 'build_alert_edit.dart';
import 'build_alert_search.dart';

class CustomFloatingActionButton extends StatefulWidget {
  const CustomFloatingActionButton({super.key, required this.pageData});
  final Pages pageData;

  @override
  State<CustomFloatingActionButton> createState() =>
      _CustomFloatingActionButtonState();
}

class _CustomFloatingActionButtonState
    extends State<CustomFloatingActionButton> {
  String? lang;

  List<Map<String, dynamic>> listData = [];
  List<ColumnList> columnList = [];
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
            listData.clear();
            columnList.clear();
            listData.addAll(state.screenModel.dataList!);
            columnList.addAll(state.screenModel.columnList!);
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
        isCloseButton: false,
        content: BuildAlertSearch(
          columnList: columnList,
          pageData: widget.pageData,
          oldStatement: BuildAlertSearch.statement,
        ),
      );
    } else if (icon == Icons.refresh) {
      ScreenTableBody.isSearch = false;
      BuildAlertSearch.statement = '';
      BlocProvider.of<GetTableCubit>(context).getTable(
          pageId: widget.pageData.pageId.toString(),
          employee: false,
          isdesc: widget.pageData.isDesc,
          limit: 10,
          offset: 0,
          orderby: widget.pageData.orderBy,
          statment: '',
          selectcolumns: '',
          departmentName: widget.pageData.departmentName,
          isDepartment: widget.pageData.isDepartment,
          authorizationID: widget.pageData.authorizationID,
          viewEmployeeColumn: widget.pageData.viewEmployeeColumn,
          dropdownValueOfLimit: 10,
          numberOfPage: 1);
    } else if (icon == Icons.delete) {
      if (ScreenTableBody.rowData.isNotEmpty) {
        List<String> listId = [];
        for (var item in ScreenTableBody.rowData) {
          listId.add(item[widget.pageData.primary].toString());
        }
        CustomAlertDialog.alertDelete(
          context: context,
          contentButton: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocConsumer<DeleteCubit, DeleteState>(
                  listener: (context, state) {
                    if (state is DeleteSuccess) {
                      BlocProvider.of<GetTableCubit>(context).getTable(
                          pageId: widget.pageData.pageId.toString(),
                          employee: false,
                          isdesc: widget.pageData.isDesc,
                          limit: 10,
                          offset: 0,
                          orderby: widget.pageData.orderBy,
                          statment: '',
                          selectcolumns: '',
                          departmentName: widget.pageData.departmentName,
                          isDepartment: widget.pageData.isDepartment,
                          authorizationID: widget.pageData.authorizationID,
                          viewEmployeeColumn:
                              widget.pageData.viewEmployeeColumn,
                          numberOfPage: 1,
                          dropdownValueOfLimit: 10);

                      Navigator.pop(context);
                    } else if (state is DeleteFailure) {
                      CustomAlertDialog.alertWithButton(
                          context: context,
                          type: AlertType.error,
                          title: S.of(context).error,
                          textButton: S.of(context).ok,
                          desc: state.errorMassage,
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          });
                    }
                  },
                  builder: (context, state) {
                    if (state is DeleteLoading) {
                      return const CustomLoadingWidget();
                    } else {
                      return CustomButton(
                        text: S.of(context).btn_delete,
                        width: 80,
                        onTap: () {
                          BlocProvider.of<DeleteCubit>(context).deleteItems(
                              controllerName: widget.pageData.controllerName,
                              listId: listId);
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      } else {
        CustomAlertDialog.alertWithButton(
            context: context,
            type: AlertType.error,
            title: S.of(context).error,
            desc: S.of(context).massage_choose_delete);
      }
    } else if (icon == Icons.edit_note) {
      if (ScreenTableBody.rowData.isNotEmpty) {
        if (ScreenTableBody.rowData.length > 1) {
          CustomAlertDialog.alertWithButton(
              context: context,
              type: AlertType.error,
              title: S.of(context).error,
              desc: S.of(context).massage_no_edit);
        } else if (ScreenTableBody.rowData.length == 1) {
          CustomAlertDialog.alertWithCustomContent(
            context: context,
            title: S.of(context).btn_edit,
            isOverlayTapDismiss: false,
            isCloseButton: false,
            content: BuildAlertEdit(
              columnList: columnList,
              pageData: widget.pageData,
            ),
          );
        }
      } else {
        CustomAlertDialog.alertWithButton(
            context: context,
            type: AlertType.error,
            title: S.of(context).error,
            desc: S.of(context).massage_choose_edit);
      }
    } else if (icon == Icons.add) {
      CustomAlertDialog.alertWithCustomContent(
        context: context,
        title: S.of(context).btn_add,
        isOverlayTapDismiss: false,
        isCloseButton: false,
        content: BuildAlertAdd(
          columnList: columnList,
          pageData: widget.pageData,
        ),
      );
    }
  }
}
