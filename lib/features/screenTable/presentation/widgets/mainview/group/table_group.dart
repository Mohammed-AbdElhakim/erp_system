import 'package:erp_system/features/screenTable/presentation/widgets/mainview/group/custom_table_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

import '../../../../../../core/models/menu_model/pages.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../../../../../../core/widgets/custom_error_massage.dart';
import '../../../../../../core/widgets/custom_loading_widget.dart';
import '../../../../data/models/dropdown_model/all_dropdown_model.dart';
import '../../../../data/models/screen_model.dart';
import '../../../manager/getAllDropdownList/get_all_dropdown_list_cubit.dart';
import '../../../manager/getTable/get_table_cubit.dart';
import '../../../views/screen_table.dart';
import '../build_alert_search.dart';
import '../pagination_widget.dart';

class TableGroup extends StatefulWidget {
  const TableGroup({super.key, required this.pageData});

  final Pages pageData;
  // static List<int> rowData = [];
  // static List<Map<String, dynamic>> rowData = [];

  // static List<String> listCategory = [];
  // static List<AllDropdownModel> myAllDropdownModelList = [];
  //
  // static bool isSearch = false;
  // static late String orderBy;
  // static late bool isDesc;
  // static late int numberPage;
  // static late int dropdownValue;

  @override
  State<TableGroup> createState() => _TableGroupState();
}

class _TableGroupState extends State<TableGroup> {
  String? lang;
  LinkedScrollControllerGroup controllerGroup = LinkedScrollControllerGroup();
  ScrollController? headerScrollController;
  ScrollController? dataScrollController;

  late int allPages;
  List<int> listNumberItemInList = [10, 25, 50, 100];

  @override
  void initState() {
    super.initState();
    headerScrollController = controllerGroup.addAndGet();
    dataScrollController = controllerGroup.addAndGet();
    ScreenTable.numberPage = 1;
    ScreenTable.isDesc = widget.pageData.isDesc;
    ScreenTable.orderBy = widget.pageData.orderBy;
    ScreenTable.dropdownValue = listNumberItemInList[0];
    BuildAlertSearch.statement = '';
  }

  @override
  void dispose() {
    ScreenTable.rowData = [];
    ScreenTable.listCategory = [];
    ScreenTable.myAllDropdownModelList = [];
    ScreenTable.isSearch == false;
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllDropdownListCubit, GetAllDropdownListState>(
      builder: (context, state) {
        if (state is GetAllDropdownListSuccess) {
          List<AllDropdownModel> allDropdownModelList =
              state.allDropdownModelList;
          ScreenTable.myAllDropdownModelList = allDropdownModelList;
          return BlocBuilder<GetTableCubit, GetTableState>(
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
                List<String> categoryList = category.toSet().toList();
                ScreenTable.listCategory = categoryList;
                ScreenTable.numberPage = state.numberPage;
                ScreenTable.dropdownValue = state.dropdownValue;
                allPages = (numberOfRecords! % ScreenTable.dropdownValue) == 0
                    ? (numberOfRecords ~/ ScreenTable.dropdownValue)
                    : (numberOfRecords ~/ ScreenTable.dropdownValue) + 1;
                return CustomTableGroup(
                  pageData: widget.pageData,
                  listHeader: listHeaderInTable,
                  listKey: listKeyInTable,
                  listData: listData!,
                  listColumn: listColumnInTable,
                  listSum: listSum,
                  allDropdownModelList: allDropdownModelList,
                  paginationWidget: PaginationWidget(
                    allPages: allPages,
                    dropdownValue: ScreenTable.dropdownValue,
                    listNumberItemInList: listNumberItemInList,
                    myPage: ScreenTable.numberPage,
                    numberOfRecords: numberOfRecords,
                    onChangeLimit: (limit) {
                      setState(() {
                        ScreenTable.dropdownValue = limit;
                        ScreenTable.numberPage = 1;
                        allPages =
                            (numberOfRecords % ScreenTable.dropdownValue) == 0
                                ? (numberOfRecords ~/ ScreenTable.dropdownValue)
                                : (numberOfRecords ~/
                                        ScreenTable.dropdownValue) +
                                    1;
                      });

                      BlocProvider.of<GetTableCubit>(context).getTable(
                        pageId: widget.pageData.pageId,
                        employee: false,
                        isdesc: widget.pageData.isDesc,
                        limit: ScreenTable.dropdownValue,
                        offset: (ScreenTable.numberPage *
                                ScreenTable.dropdownValue) -
                            ScreenTable.dropdownValue,
                        orderby: widget.pageData.orderBy,
                        statment: ScreenTable.isSearch == true
                            ? BuildAlertSearch.statement
                            : '',
                        selectcolumns: '',
                        numberOfPage: ScreenTable.numberPage,
                        dropdownValueOfLimit: ScreenTable.dropdownValue,
                        departmentName: widget.pageData.departmentName,
                        isDepartment: widget.pageData.isDepartment,
                        authorizationID: widget.pageData.authorizationID,
                        viewEmployeeColumn: widget.pageData.viewEmployeeColumn,
                      );
                    },
                    onTapMin: () {
                      setState(() {
                        ScreenTable.numberPage--;
                      });

                      BlocProvider.of<GetTableCubit>(context).getTable(
                        pageId: widget.pageData.pageId,
                        employee: false,
                        isdesc: widget.pageData.isDesc,
                        limit: ScreenTable.dropdownValue,
                        offset: (ScreenTable.numberPage *
                                ScreenTable.dropdownValue) -
                            ScreenTable.dropdownValue,
                        orderby: widget.pageData.orderBy,
                        statment: ScreenTable.isSearch == true
                            ? BuildAlertSearch.statement
                            : '',
                        selectcolumns: '',
                        departmentName: widget.pageData.departmentName,
                        isDepartment: widget.pageData.isDepartment,
                        authorizationID: widget.pageData.authorizationID,
                        viewEmployeeColumn: widget.pageData.viewEmployeeColumn,
                        numberOfPage: ScreenTable.numberPage,
                        dropdownValueOfLimit: ScreenTable.dropdownValue,
                      );
                    },
                    onTapAdd: () {
                      setState(() {
                        ScreenTable.numberPage++;
                      });

                      BlocProvider.of<GetTableCubit>(context).getTable(
                        pageId: widget.pageData.pageId,
                        employee: false,
                        isdesc: widget.pageData.isDesc,
                        limit: ScreenTable.dropdownValue,
                        offset: (ScreenTable.numberPage *
                                ScreenTable.dropdownValue) -
                            ScreenTable.dropdownValue,
                        orderby: widget.pageData.orderBy,
                        statment: ScreenTable.isSearch == true
                            ? BuildAlertSearch.statement
                            : '',
                        selectcolumns: '',
                        departmentName: widget.pageData.departmentName,
                        isDepartment: widget.pageData.isDepartment,
                        authorizationID: widget.pageData.authorizationID,
                        viewEmployeeColumn: widget.pageData.viewEmployeeColumn,
                        numberOfPage: ScreenTable.numberPage,
                        dropdownValueOfLimit: ScreenTable.dropdownValue,
                      );
                    },
                  ),
                  onTapHeader: (String titleHeader) {
                    setState(() {
                      ScreenTable.orderBy = titleHeader;
                      ScreenTable.isDesc = !ScreenTable.isDesc;
                    });

                    BlocProvider.of<GetTableCubit>(context).getTable(
                      pageId: widget.pageData.pageId,
                      employee: false,
                      isdesc: ScreenTable.isDesc,
                      limit: ScreenTable.dropdownValue,
                      offset:
                          (ScreenTable.numberPage * ScreenTable.dropdownValue) -
                              ScreenTable.dropdownValue,
                      orderby: ScreenTable.orderBy,
                      statment: ScreenTable.isSearch == true
                          ? BuildAlertSearch.statement
                          : '',
                      selectcolumns: '',
                      departmentName: widget.pageData.departmentName,
                      isDepartment: widget.pageData.isDepartment,
                      authorizationID: widget.pageData.authorizationID,
                      viewEmployeeColumn: widget.pageData.viewEmployeeColumn,
                      numberOfPage: ScreenTable.numberPage,
                      dropdownValueOfLimit: ScreenTable.dropdownValue,
                    );
                  },
                  onTapRow: (rowData) {
                    ScreenTable.rowData = rowData;
                  },
                );
              } else if (state is GetTableFailure) {
                return CustomErrorMassage(errorMassage: state.errorMassage);
              } else {
                return const CustomLoadingWidget();
              }
            },
          );
        } else if (state is GetAllDropdownListFailure) {
          return CustomErrorMassage(errorMassage: state.errorMassage);
        } else {
          return const CustomLoadingWidget();
        }
      },
    );
  }
}
