import 'package:erp_system/features/screenTable/presentation/widgets/custom_table_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_error_massage.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../data/models/dropdown_model/all_dropdown_model.dart';
import '../../data/models/screen_model.dart';
import '../manager/getAllDropdownList/get_all_dropdown_list_cubit.dart';
import '../manager/getTable/get_table_cubit.dart';
import 'build_alert_search.dart';
import 'pagination_widget.dart';

class TableGroup extends StatefulWidget {
  const TableGroup({super.key, required this.pageData});

  final Pages pageData;
  static List<Map<String, dynamic>> rowData = [];
  static List<String> listCategory = [];
  static List<AllDropdownModel> myAllDropdownModelList = [];

  static bool isSearch = false;
  static late String orderBy;
  static late bool isDesc;
  static late int numberPage;
  static late int dropdownValue;

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
    TableGroup.numberPage = 1;
    TableGroup.isDesc = widget.pageData.isDesc;
    TableGroup.orderBy = widget.pageData.orderBy;
    TableGroup.dropdownValue = listNumberItemInList[0];
    BuildAlertSearch.statement = '';
  }

  @override
  void dispose() {
    TableGroup.rowData = [];
    TableGroup.listCategory = [];
    TableGroup.myAllDropdownModelList = [];
    TableGroup.isSearch == false;
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
          TableGroup.myAllDropdownModelList = allDropdownModelList;
          return BlocBuilder<GetTableCubit, GetTableState>(
            builder: (context, state) {
              if (state is GetTableSuccess) {
                int? numberOfRecords = state.screenModel.numberOfRecords;
                List<dynamic>? listData = state.screenModel.dataList;
                List<dynamic>? listSum = state.screenModel.summedColumns;
                List<String> listHeader = [];
                List<dynamic> listKey = [];
                List<ColumnList> listColumn = [];
                List<String> category = [];
                for (var item in state.screenModel.columnList!) {
                  listHeader.add(lang == AppStrings.enLangKey
                      ? item.enColumnLabel!
                      : item.arColumnLabel!);
                  listKey.add(item.columnName);
                  listColumn.add(item);
                  category.add(item.categoryName!);
                }
                List<String> categoryList = category.toSet().toList();
                TableGroup.listCategory = categoryList;
                TableGroup.numberPage = state.numberPage;
                TableGroup.dropdownValue = state.dropdownValue;
                allPages = (numberOfRecords! % TableGroup.dropdownValue) == 0
                    ? (numberOfRecords ~/ TableGroup.dropdownValue)
                    : (numberOfRecords ~/ TableGroup.dropdownValue) + 1;
                return CustomTableGroup(
                  pageData: widget.pageData,
                  listHeader: listHeader,
                  listKey: listKey,
                  listData: listData!,
                  listColumn: listColumn,
                  listSum: listSum,
                  allDropdownModelList: allDropdownModelList,
                  paginationWidget: PaginationWidget(
                    allPages: allPages,
                    dropdownValue: TableGroup.dropdownValue,
                    listNumberItemInList: listNumberItemInList,
                    myPage: TableGroup.numberPage,
                    numberOfRecords: numberOfRecords,
                    onChangeLimit: (limit) {
                      setState(() {
                        TableGroup.dropdownValue = limit;
                        TableGroup.numberPage = 1;
                        allPages = (numberOfRecords %
                                    TableGroup.dropdownValue) ==
                                0
                            ? (numberOfRecords ~/ TableGroup.dropdownValue)
                            : (numberOfRecords ~/ TableGroup.dropdownValue) + 1;
                      });

                      BlocProvider.of<GetTableCubit>(context).getTable(
                        pageId: widget.pageData.pageId,
                        employee: false,
                        isdesc: widget.pageData.isDesc,
                        limit: TableGroup.dropdownValue,
                        offset:
                            (TableGroup.numberPage * TableGroup.dropdownValue) -
                                TableGroup.dropdownValue,
                        orderby: widget.pageData.orderBy,
                        statment: TableGroup.isSearch == true
                            ? BuildAlertSearch.statement
                            : '',
                        selectcolumns: '',
                        numberOfPage: TableGroup.numberPage,
                        dropdownValueOfLimit: TableGroup.dropdownValue,
                        departmentName: widget.pageData.departmentName,
                        isDepartment: widget.pageData.isDepartment,
                        authorizationID: widget.pageData.authorizationID,
                        viewEmployeeColumn: widget.pageData.viewEmployeeColumn,
                      );
                    },
                    onTapMin: () {
                      setState(() {
                        TableGroup.numberPage--;
                      });

                      BlocProvider.of<GetTableCubit>(context).getTable(
                        pageId: widget.pageData.pageId,
                        employee: false,
                        isdesc: widget.pageData.isDesc,
                        limit: TableGroup.dropdownValue,
                        offset:
                            (TableGroup.numberPage * TableGroup.dropdownValue) -
                                TableGroup.dropdownValue,
                        orderby: widget.pageData.orderBy,
                        statment: TableGroup.isSearch == true
                            ? BuildAlertSearch.statement
                            : '',
                        selectcolumns: '',
                        departmentName: widget.pageData.departmentName,
                        isDepartment: widget.pageData.isDepartment,
                        authorizationID: widget.pageData.authorizationID,
                        viewEmployeeColumn: widget.pageData.viewEmployeeColumn,
                        numberOfPage: TableGroup.numberPage,
                        dropdownValueOfLimit: TableGroup.dropdownValue,
                      );
                    },
                    onTapAdd: () {
                      setState(() {
                        TableGroup.numberPage++;
                      });

                      BlocProvider.of<GetTableCubit>(context).getTable(
                        pageId: widget.pageData.pageId,
                        employee: false,
                        isdesc: widget.pageData.isDesc,
                        limit: TableGroup.dropdownValue,
                        offset:
                            (TableGroup.numberPage * TableGroup.dropdownValue) -
                                TableGroup.dropdownValue,
                        orderby: widget.pageData.orderBy,
                        statment: TableGroup.isSearch == true
                            ? BuildAlertSearch.statement
                            : '',
                        selectcolumns: '',
                        departmentName: widget.pageData.departmentName,
                        isDepartment: widget.pageData.isDepartment,
                        authorizationID: widget.pageData.authorizationID,
                        viewEmployeeColumn: widget.pageData.viewEmployeeColumn,
                        numberOfPage: TableGroup.numberPage,
                        dropdownValueOfLimit: TableGroup.dropdownValue,
                      );
                    },
                  ),
                  onTapHeader: (String titleHeader) {
                    setState(() {
                      TableGroup.orderBy = titleHeader;
                      TableGroup.isDesc = !TableGroup.isDesc;
                    });

                    BlocProvider.of<GetTableCubit>(context).getTable(
                      pageId: widget.pageData.pageId,
                      employee: false,
                      isdesc: TableGroup.isDesc,
                      limit: TableGroup.dropdownValue,
                      offset:
                          (TableGroup.numberPage * TableGroup.dropdownValue) -
                              TableGroup.dropdownValue,
                      orderby: TableGroup.orderBy,
                      statment: TableGroup.isSearch == true
                          ? BuildAlertSearch.statement
                          : '',
                      selectcolumns: '',
                      departmentName: widget.pageData.departmentName,
                      isDepartment: widget.pageData.isDepartment,
                      authorizationID: widget.pageData.authorizationID,
                      viewEmployeeColumn: widget.pageData.viewEmployeeColumn,
                      numberOfPage: TableGroup.numberPage,
                      dropdownValueOfLimit: TableGroup.dropdownValue,
                    );
                  },
                  onTapRow: (rowData) {
                    TableGroup.rowData = rowData;
                    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@2");
                    print(TableGroup.rowData);
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
