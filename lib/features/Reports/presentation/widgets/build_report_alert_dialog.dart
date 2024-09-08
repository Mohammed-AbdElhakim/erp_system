import 'package:erp_system/features/Reports/presentation/views/reports_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/custom_error_massage.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../data/models/all_dropdown_model.dart';
import '../../data/models/screen_model.dart';
import '../../data/models/table_model.dart';
import '../../data/repositories/reports_repo_impl.dart';
import '../manager/getTable/get_table_cubit.dart';
import 'custom_table_general.dart';
import 'pagination_widget_alert.dart';

class BuildReportAlertDialog extends StatefulWidget {
  const BuildReportAlertDialog({
    super.key,
    required this.tailCondition,
    required this.tableModel,
    required this.pageData,
  });

  final String tailCondition;
  final TableModel tableModel;
  final Pages pageData;

  @override
  State<BuildReportAlertDialog> createState() => _BuildReportAlertDialogState();
}

class _BuildReportAlertDialogState extends State<BuildReportAlertDialog> {
  String? lang;
  List<dynamic> rowData = [];
  List<String> listCategory = [];
  List<AllDropdownModel> myAllDropdownModelList = [];
  bool isSearch = false;
  late String orderBy;
  late bool isDesc;
  late int numberPage;
  late int dropdownValue;
  late int allPages;
  List<int> listNumberItemInList = [10, 25, 50, 100];
  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    numberPage = 1;
    isDesc = widget.pageData.isDesc;
    orderBy = widget.pageData.orderBy;
    dropdownValue = listNumberItemInList[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetTableCubit(
        getIt.get<ReportsRepoImpl>(),
      )..getTable(
          pageId: widget.tableModel.atrribut!.pageId!,
          employee: false,
          isdesc: widget.pageData.isDesc,
          limit: 10,
          offset: 0,
          orderby: widget.pageData.orderBy,
          statment: widget.tailCondition,
          // statment: "",
          selectcolumns: "",
          isDepartment: widget.pageData.isDepartment,
          departmentName: widget.pageData.departmentName,
          authorizationID: widget.pageData.authorizationID,
          viewEmployeeColumn: widget.pageData.viewEmployeeColumn,
          tailcondition: widget.tailCondition,
          numberOfPage: 1,
          dropdownValueOfLimit: 10),
      child: BlocBuilder<GetTableCubit, GetTableState>(
        builder: (context, state) {
          if (state is GetTableSuccess) {
            List<ColumnList> listColumns = state.screenModel.columnList!;

            listColumns.sort((a, b) => a.sort!.compareTo(b.sort!));

            int? numberOfRecords = state.screenModel.numberOfRecords;
            List<dynamic>? listData = state.screenModel.dataList;
            List<dynamic>? listSum = state.screenModel.summedColumns;
            List<String> listHeader = [];
            List<dynamic> listKey = [];
            List<ColumnList> listColumn = [];
            List<String> listHeaderInTable = [];
            List<dynamic> listKeyInTable = [];
            List<ColumnList> listColumnInTable = [];
            List<String> category = [];
            for (var item in listColumns) {
              if (item.visible == true) {
                listHeaderInTable.add(lang == AppStrings.enLangKey
                    ? item.enColumnLabel!
                    : item.arColumnLabel!);
                listKeyInTable.add(item.columnName);
                listColumnInTable.add(item);
              }
              listHeader.add(lang == AppStrings.enLangKey
                  ? item.enColumnLabel!
                  : item.arColumnLabel!);
              listKey.add(item.columnName);
              listColumn.add(item);
              category.add(item.categoryName!);
            }
            numberPage = state.numberPage;
            dropdownValue = state.dropdownValue;
            allPages = (numberOfRecords! % dropdownValue) == 0
                ? (numberOfRecords ~/ dropdownValue)
                : (numberOfRecords ~/ dropdownValue) + 1;
            return CustomTableGeneral(
              pageData: widget.pageData,
              listHeader: listHeaderInTable,
              listKey: listKeyInTable,
              listData: listData!,
              listColumn: listColumnInTable,
              listSum: listSum,
              allDropdownModelList: ReportsView.myAllDropdownModelList,
              paginationWidget: PaginationWidgetAlert(
                allPages: allPages,
                dropdownValue: dropdownValue,
                listNumberItemInList: listNumberItemInList,
                myPage: numberPage,
                numberOfRecords: numberOfRecords,
                onChangeLimit: (limit) {
                  setState(() {
                    dropdownValue = limit;
                    numberPage = 1;
                    allPages = (numberOfRecords % dropdownValue) == 0
                        ? (numberOfRecords ~/ dropdownValue)
                        : (numberOfRecords ~/ dropdownValue) + 1;
                  });

                  BlocProvider.of<GetTableCubit>(context).getTable(
                      pageId: widget.pageData.pageId,
                      employee: false,
                      isdesc: widget.pageData.isDesc,
                      limit: dropdownValue,
                      offset: (numberPage * dropdownValue) - dropdownValue,
                      orderby: widget.pageData.orderBy,
                      statment: '',
                      selectcolumns: '',
                      numberOfPage: numberPage,
                      dropdownValueOfLimit: dropdownValue,
                      departmentName: widget.pageData.departmentName,
                      isDepartment: widget.pageData.isDepartment,
                      authorizationID: widget.pageData.authorizationID,
                      viewEmployeeColumn: widget.pageData.viewEmployeeColumn,
                      tailcondition: widget.tailCondition);
                },
                onTapMin: () {
                  setState(() {
                    numberPage--;
                  });

                  BlocProvider.of<GetTableCubit>(context).getTable(
                      pageId: widget.pageData.pageId,
                      employee: false,
                      isdesc: widget.pageData.isDesc,
                      limit: dropdownValue,
                      offset: (numberPage * dropdownValue) - dropdownValue,
                      orderby: widget.pageData.orderBy,
                      statment: '',
                      selectcolumns: '',
                      departmentName: widget.pageData.departmentName,
                      isDepartment: widget.pageData.isDepartment,
                      authorizationID: widget.pageData.authorizationID,
                      viewEmployeeColumn: widget.pageData.viewEmployeeColumn,
                      numberOfPage: numberPage,
                      dropdownValueOfLimit: dropdownValue,
                      tailcondition: widget.tailCondition);
                },
                onTapAdd: () {
                  setState(() {
                    numberPage++;
                  });

                  BlocProvider.of<GetTableCubit>(context).getTable(
                      pageId: widget.pageData.pageId,
                      employee: false,
                      isdesc: widget.pageData.isDesc,
                      limit: dropdownValue,
                      offset: (numberPage * dropdownValue) - dropdownValue,
                      orderby: widget.pageData.orderBy,
                      statment: '',
                      selectcolumns: '',
                      departmentName: widget.pageData.departmentName,
                      isDepartment: widget.pageData.isDepartment,
                      authorizationID: widget.pageData.authorizationID,
                      viewEmployeeColumn: widget.pageData.viewEmployeeColumn,
                      numberOfPage: numberPage,
                      dropdownValueOfLimit: dropdownValue,
                      tailcondition: widget.tailCondition);
                },
              ),
              onTapHeader: (String titleHeader) {
                setState(() {
                  orderBy = titleHeader;
                  isDesc = !isDesc;
                });

                BlocProvider.of<GetTableCubit>(context).getTable(
                    pageId: widget.pageData.pageId,
                    employee: false,
                    isdesc: isDesc,
                    limit: dropdownValue,
                    offset: (numberPage * dropdownValue) - dropdownValue,
                    orderby: orderBy,
                    statment: '',
                    selectcolumns: '',
                    departmentName: widget.pageData.departmentName,
                    isDepartment: widget.pageData.isDepartment,
                    authorizationID: widget.pageData.authorizationID,
                    viewEmployeeColumn: widget.pageData.viewEmployeeColumn,
                    numberOfPage: numberPage,
                    dropdownValueOfLimit: dropdownValue,
                    tailcondition: widget.tailCondition);
              },
              onTapRow: (rowData) {
                rowData = rowData;
              },
            );
          } else if (state is GetTableFailure) {
            return CustomErrorMassage(errorMassage: state.errorMassage);
          } else {
            return const CustomLoadingWidget();
          }
        },
      ),
    );
  }
}
