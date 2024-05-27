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
import 'custom_table.dart';
import 'pagination_widget.dart';

class ScreenTableBody extends StatefulWidget {
  const ScreenTableBody({super.key, required this.pageData});

  final Pages pageData;
  static List<Map<String, dynamic>> rowData = [];
  static List<String> listCategory = [];

  static bool isSearch = false;
  static late String orderBy;
  static late bool isDesc;
  static late int numberPage;
  static late int dropdownValue;

  @override
  State<ScreenTableBody> createState() => _ScreenTableBodyState();
}

class _ScreenTableBodyState extends State<ScreenTableBody> {
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
    ScreenTableBody.numberPage = 1;
    ScreenTableBody.isDesc = widget.pageData.isDesc;
    ScreenTableBody.orderBy = widget.pageData.orderBy;
    ScreenTableBody.dropdownValue = listNumberItemInList[0];
    BuildAlertSearch.statement = '';
  }

  @override
  void dispose() {
    ScreenTableBody.rowData = [];
    ScreenTableBody.listCategory = [];
    ScreenTableBody.isSearch == false;
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
                ScreenTableBody.listCategory = categoryList;
                ScreenTableBody.numberPage = state.numberPage;
                ScreenTableBody.dropdownValue = state.dropdownValue;
                allPages = (numberOfRecords! % ScreenTableBody.dropdownValue) ==
                        0
                    ? (numberOfRecords ~/ ScreenTableBody.dropdownValue)
                    : (numberOfRecords ~/ ScreenTableBody.dropdownValue) + 1;
                return CustomTable(
                  pageData: widget.pageData,
                  listHeader: listHeader,
                  listKey: listKey,
                  listData: listData!,
                  listColumn: listColumn,
                  listSum: listSum,
                  allDropdownModelList: allDropdownModelList,
                  paginationWidget: PaginationWidget(
                    allPages: allPages,
                    dropdownValue: ScreenTableBody.dropdownValue,
                    listNumberItemInList: listNumberItemInList,
                    myPage: ScreenTableBody.numberPage,
                    numberOfRecords: numberOfRecords,
                    onChangeLimit: (limit) {
                      setState(() {
                        ScreenTableBody.dropdownValue = limit;
                        ScreenTableBody.numberPage = 1;
                        allPages = (numberOfRecords %
                                    ScreenTableBody.dropdownValue) ==
                                0
                            ? (numberOfRecords ~/ ScreenTableBody.dropdownValue)
                            : (numberOfRecords ~/
                                    ScreenTableBody.dropdownValue) +
                                1;
                      });

                      BlocProvider.of<GetTableCubit>(context).getTable(
                        pageId: widget.pageData.pageId,
                        employee: false,
                        isdesc: widget.pageData.isDesc,
                        limit: ScreenTableBody.dropdownValue,
                        offset: (ScreenTableBody.numberPage *
                                ScreenTableBody.dropdownValue) -
                            ScreenTableBody.dropdownValue,
                        orderby: widget.pageData.orderBy,
                        statment: ScreenTableBody.isSearch == true
                            ? BuildAlertSearch.statement
                            : '',
                        selectcolumns: '',
                        numberOfPage: ScreenTableBody.numberPage,
                        dropdownValueOfLimit: ScreenTableBody.dropdownValue,
                        departmentName: widget.pageData.departmentName,
                        isDepartment: widget.pageData.isDepartment,
                        authorizationID: widget.pageData.authorizationID,
                        viewEmployeeColumn: widget.pageData.viewEmployeeColumn,
                      );
                    },
                    onTapMin: () {
                      setState(() {
                        ScreenTableBody.numberPage--;
                      });

                      BlocProvider.of<GetTableCubit>(context).getTable(
                        pageId: widget.pageData.pageId,
                        employee: false,
                        isdesc: widget.pageData.isDesc,
                        limit: ScreenTableBody.dropdownValue,
                        offset: (ScreenTableBody.numberPage *
                                ScreenTableBody.dropdownValue) -
                            ScreenTableBody.dropdownValue,
                        orderby: widget.pageData.orderBy,
                        statment: ScreenTableBody.isSearch == true
                            ? BuildAlertSearch.statement
                            : '',
                        selectcolumns: '',
                        departmentName: widget.pageData.departmentName,
                        isDepartment: widget.pageData.isDepartment,
                        authorizationID: widget.pageData.authorizationID,
                        viewEmployeeColumn: widget.pageData.viewEmployeeColumn,
                        numberOfPage: ScreenTableBody.numberPage,
                        dropdownValueOfLimit: ScreenTableBody.dropdownValue,
                      );
                    },
                    onTapAdd: () {
                      setState(() {
                        ScreenTableBody.numberPage++;
                      });

                      BlocProvider.of<GetTableCubit>(context).getTable(
                        pageId: widget.pageData.pageId,
                        employee: false,
                        isdesc: widget.pageData.isDesc,
                        limit: ScreenTableBody.dropdownValue,
                        offset: (ScreenTableBody.numberPage *
                                ScreenTableBody.dropdownValue) -
                            ScreenTableBody.dropdownValue,
                        orderby: widget.pageData.orderBy,
                        statment: ScreenTableBody.isSearch == true
                            ? BuildAlertSearch.statement
                            : '',
                        selectcolumns: '',
                        departmentName: widget.pageData.departmentName,
                        isDepartment: widget.pageData.isDepartment,
                        authorizationID: widget.pageData.authorizationID,
                        viewEmployeeColumn: widget.pageData.viewEmployeeColumn,
                        numberOfPage: ScreenTableBody.numberPage,
                        dropdownValueOfLimit: ScreenTableBody.dropdownValue,
                      );
                    },
                  ),
                  onTapHeader: (String titleHeader) {
                    setState(() {
                      ScreenTableBody.orderBy = titleHeader;
                      ScreenTableBody.isDesc = !ScreenTableBody.isDesc;
                    });

                    BlocProvider.of<GetTableCubit>(context).getTable(
                      pageId: widget.pageData.pageId,
                      employee: false,
                      isdesc: ScreenTableBody.isDesc,
                      limit: ScreenTableBody.dropdownValue,
                      offset: (ScreenTableBody.numberPage *
                              ScreenTableBody.dropdownValue) -
                          ScreenTableBody.dropdownValue,
                      orderby: ScreenTableBody.orderBy,
                      statment: ScreenTableBody.isSearch == true
                          ? BuildAlertSearch.statement
                          : '',
                      selectcolumns: '',
                      departmentName: widget.pageData.departmentName,
                      isDepartment: widget.pageData.isDepartment,
                      authorizationID: widget.pageData.authorizationID,
                      viewEmployeeColumn: widget.pageData.viewEmployeeColumn,
                      numberOfPage: ScreenTableBody.numberPage,
                      dropdownValueOfLimit: ScreenTableBody.dropdownValue,
                    );
                  },
                  onTapRow: (rowData) {
                    ScreenTableBody.rowData = rowData;
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
