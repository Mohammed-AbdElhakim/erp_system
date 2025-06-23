import 'package:erp_system/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../core/helper/AlertDialog/custom_alert_dialog.dart';
import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/passData/add_pass_data_model.dart';
import '../../data/models/permission_model.dart';
import '../../data/models/screen_model.dart';
import '../manager/delete/delete_cubit.dart';
import '../manager/getPermissions/get_permissions_cubit.dart';
import '../manager/getTable/get_table_cubit.dart';
import '../views/screen_table.dart';
import 'build_alert_search.dart';
import 'file_excel.dart';
import 'file_pdf.dart';
import 'print_row.dart';
import 'tableSrcPageDetails/build_alert_add.dart';
import 'tableSrcPageDetails/build_alert_edit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomFloatingActionButton extends StatefulWidget {
  const CustomFloatingActionButton({super.key, required this.pageData});

  final Pages pageData;

  @override
  State<CustomFloatingActionButton> createState() => _CustomFloatingActionButtonState();
}

class _CustomFloatingActionButtonState extends State<CustomFloatingActionButton> {
  String? lang;
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  bool shouldReopenDial = true;
  List<Map<String, dynamic>> listData = [];
  List<ColumnList> columnList = [];
  List<dynamic> listKey = [];

  List<IconData> iconList = [
    Icons.search,
    Icons.refresh,
    Icons.print,
  ];
  List<IconData> printIconList = [
    Icons.print,
    FontAwesomeIcons.fileExcel,
    FontAwesomeIcons.filePdf,
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
              if (item.insertType == "dropdown") {
                listKey.add(item.searchName);
              } else {
                listKey.add(item.columnName);
              }
            }
          }
        },
        child: SpeedDial(
          backgroundColor: AppColors.blueLight,
          overlayOpacity: 0.5,
          openCloseDial: isDialOpen,
          closeManually: true,
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
                  isDialOpen.value = false;
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
    } else if (icon == FontAwesomeIcons.fileExcel) {
      return AppColors.blueLight;
    } else if (icon == FontAwesomeIcons.filePdf) {
      return AppColors.red;
    } else if (icon == Icons.print) {
      return AppColors.green;
    }
  }

  void tapIcon(IconData icon) {
    if (icon == Icons.search) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Center(
            child: Text(
              S.of(context).btn_search,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.blueLight),
            ),
          ),
          content: BuildAlertSearch(
            columnList: columnList,
            pageData: widget.pageData,
            oldStatement: BuildAlertSearch.statement,
          ),
        ),
      );
    } else if (icon == Icons.refresh) {
      BlocProvider.of<GetTableCubit>(context).getTable(
          pageId: widget.pageData.pageId,
          employee: false,
          isdesc: ScreenTable.isDesc,
          limit: ScreenTable.dropdownValue,
          offset: 0,
          orderby: ScreenTable.orderBy,
          statment: ScreenTable.isSearch == true ? BuildAlertSearch.statement : '',
          selectcolumns: '',
          departmentName: widget.pageData.departmentName,
          isDepartment: widget.pageData.isDepartment,
          authorizationID: widget.pageData.authorizationID,
          viewEmployeeColumn: widget.pageData.viewEmployeeColumn,
          dropdownValueOfLimit: ScreenTable.dropdownValue,
          numberOfPage: ScreenTable.numberPage);
    } else if (icon == Icons.delete) {
      List<dynamic> myRowData = ScreenTable.rowData;
      if (myRowData.isNotEmpty) {
        List<String> listId = [];
        for (var item in myRowData) {
          listId.add(item.toString());
          // if (widget.pageData.tableSrc == AppStrings.tableGroup) {
          //   listId.add(item.toString());
          // } else {
          //   String primary = "";
          //   for (var i in columnList) {
          //     if (i.columnName == widget.pageData.primary) {
          //       primary = (lang == AppStrings.enLangKey
          //           ? i.enColumnLabel
          //           : i.arColumnLabel)!;
          //     }
          //   }
          //   listId.add(item[primary].toString());
          //   // listId.add(item[widget.pageData.primary].toString());
          // }
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
                          pageId: widget.pageData.pageId,
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
                          numberOfPage: 1,
                          dropdownValueOfLimit: 10);

                      ScreenTable.rowData.clear();

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
                          BlocProvider.of<DeleteCubit>(context)
                              .deleteItems(controllerName: widget.pageData.controllerName, listId: listId);
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
            context: context, type: AlertType.error, title: S.of(context).error, desc: S.of(context).massage_choose_delete);
      }
    } else if (icon == Icons.edit_note) {
      List<dynamic> myRowData = ScreenTable.rowData;
      if (myRowData.isNotEmpty) {
        if (myRowData.length > 1) {
          CustomAlertDialog.alertWithButton(
              context: context, type: AlertType.error, title: S.of(context).error, desc: S.of(context).massage_no_edit);
        } else if (myRowData.length == 1) {
          if (widget.pageData.editSrc == "") {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                title: Center(
                  child: Text(
                    S.of(context).btn_edit,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.blueLight),
                  ),
                ),
                content: BuildAlertEdit(
                  columnList: columnList,
                  pageData: widget.pageData,
                ),
              ),
            );
          } else {
            GoRouter.of(context)
                .push(AppRouter.kEditView,
                    extra: AddPassDataModel(
                      pageData: widget.pageData,
                      columnList: columnList,
                      listKey: listKey,
                    ))
                .then((value) {
              BlocProvider.of<GetTableCubit>(context).getTable(
                  pageId: widget.pageData.pageId,
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
                  numberOfPage: 1,
                  dropdownValueOfLimit: 10);
              if (widget.pageData.tableSrc == AppStrings.tableGroup) {
                ScreenTable.rowData.clear();
              }
            });
          }
        }
      } else {
        CustomAlertDialog.alertWithButton(
            context: context, type: AlertType.error, title: S.of(context).error, desc: S.of(context).massage_choose_edit);
      }
    } else if (icon == Icons.add) {
      if (widget.pageData.editSrc == "") {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: Center(
              child: Text(
                S.of(context).btn_add,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.blueLight),
              ),
            ),
            content: BuildAlertAdd(
              columnList: columnList,
              pageData: widget.pageData,
            ),
          ),
        );
      } else {
        GoRouter.of(context)
            .push(AppRouter.kAddView,
                extra: AddPassDataModel(
                  pageData: widget.pageData,
                  columnList: columnList,
                  listKey: listKey,
                ))
            .then(
          (value) {
            BlocProvider.of<GetTableCubit>(context).getTable(
                pageId: widget.pageData.pageId,
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
                numberOfPage: 1,
                dropdownValueOfLimit: 10);
          },
        );
      }
    } else if (icon == Icons.print) {
      showBottomSheet(context);
    }
  }

  void showBottomSheet(BuildContext context) async {
    shouldReopenDial = true;
    isDialOpen.value = false;

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.blue.shade100,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              printIconList.length,
              (index) {
                return Padding(
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 15),
                  child: InkWell(
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 26,
                      child: CircleAvatar(
                        backgroundColor: getColor(printIconList[index]),
                        radius: 25,
                        child: Icon(
                          printIconList[index],
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                    onTap: () {
                      shouldReopenDial = false;
                      isDialOpen.value = false;
                      Navigator.pop(context);
                      tapIconsInPrint(printIconList[index]);
                    },
                  ),
                );
              },
            ),
          ),
        );
      },
    );
    if (shouldReopenDial) {
      isDialOpen.value = true;
    }
  }

  void tapIconsInPrint(IconData icon) {
    if (icon == FontAwesomeIcons.fileExcel) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          content: FileExcel(
            pageData: widget.pageData,
            lang: lang!,
          ),
        ),
      );
    } else if (icon == FontAwesomeIcons.filePdf) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          content: FilePdf(
            pageData: widget.pageData,
            lang: lang!,
          ),
        ),
      );
    } else if (icon == Icons.print) {
      List<dynamic> myRowData = ScreenTable.rowData;
      if (myRowData.isNotEmpty) {
        if (myRowData.length > 1) {
          CustomAlertDialog.alertWithButton(
              context: context, type: AlertType.error, title: S.of(context).error, desc: S.of(context).massage_no_print);
        } else if (myRowData.length == 1) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              content: PrintRow(
                pageData: widget.pageData,
                lang: lang!,
                id: int.parse(ScreenTable.rowData[0].toString()),
              ),
            ),
          );
        }
      } else {
        CustomAlertDialog.alertWithButton(
            context: context, type: AlertType.error, title: S.of(context).error, desc: S.of(context).massage_choose_print);
      }
    }
  }
}
