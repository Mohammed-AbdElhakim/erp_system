import 'package:erp_system/features/screenTable/data/models/screen_model.dart';
import 'package:erp_system/features/screenTable/presentation/widgets/build_alert_search.dart';
import 'package:erp_system/features/screenTable/presentation/widgets/pagination_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_error_massage.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../manager/getTable/get_table_cubit.dart';
import 'custom_table.dart';

class ScreenTableBody extends StatefulWidget {
  const ScreenTableBody({super.key, required this.pageData});

  final Pages pageData;
  static Map<String, dynamic> rowData = {};
  static List<String> listCategory = [];
  // static Map<String, List<ListDropdownModel>> myDropdownLists = {};
  static bool isSearch = false;

  @override
  State<ScreenTableBody> createState() => _ScreenTableBodyState();
}

class _ScreenTableBodyState extends State<ScreenTableBody> {
  String? lang;
  LinkedScrollControllerGroup controllerGroup = LinkedScrollControllerGroup();
  ScrollController? headerScrollController;
  ScrollController? dataScrollController;

  late int allPages;
  late int numberPage;
  late int dropdownValue;
  List<int> listNumberItemInList = [10, 25, 50, 100];
  String orderBy = '';
  bool isDesc = false;

  @override
  void initState() {
    super.initState();
    headerScrollController = controllerGroup.addAndGet();
    dataScrollController = controllerGroup.addAndGet();
    numberPage = 1;
    dropdownValue = listNumberItemInList[0];
    BuildAlertSearch.statement = '';
  }

  @override
  void dispose() {
    ScreenTableBody.rowData = {};
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
          numberPage = state.numberPage;
          dropdownValue = state.dropdownValue;
          allPages = (numberOfRecords! % dropdownValue) == 0
              ? (numberOfRecords ~/ dropdownValue)
              : (numberOfRecords ~/ dropdownValue) + 1;
          return CustomTable(
            listHeader: listHeader,
            listKey: listKey,
            listData: listData!,
            listColumn: listColumn,
            listSum: listSum,
            paginationWidget: PaginationWidget(
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
                  pageId: widget.pageData.pageId.toString(),
                  employee: false,
                  isdesc: widget.pageData.isDesc,
                  limit: dropdownValue,
                  offset: (numberPage * dropdownValue) - dropdownValue,
                  orderby: widget.pageData.orderBy,
                  statment: ScreenTableBody.isSearch == true
                      ? BuildAlertSearch.statement
                      : '',
                  selectcolumns: '',
                  numberOfPage: numberPage,
                  dropdownValueOfLimit: dropdownValue,
                  departmentName: widget.pageData.departmentName,
                  isDepartment: widget.pageData.isDepartment,
                  authorizationID: widget.pageData.authorizationID,
                  viewEmployeeColumn: widget.pageData.viewEmployeeColumn,
                );
              },
              onTapMin: () {
                setState(() {
                  numberPage--;
                });

                BlocProvider.of<GetTableCubit>(context).getTable(
                  pageId: widget.pageData.pageId.toString(),
                  employee: false,
                  isdesc: widget.pageData.isDesc,
                  limit: dropdownValue,
                  offset: (numberPage * dropdownValue) - dropdownValue,
                  orderby: widget.pageData.orderBy,
                  statment: ScreenTableBody.isSearch == true
                      ? BuildAlertSearch.statement
                      : '',
                  selectcolumns: '',
                  departmentName: widget.pageData.departmentName,
                  isDepartment: widget.pageData.isDepartment,
                  authorizationID: widget.pageData.authorizationID,
                  viewEmployeeColumn: widget.pageData.viewEmployeeColumn,
                  numberOfPage: numberPage,
                  dropdownValueOfLimit: dropdownValue,
                );
              },
              onTapAdd: () {
                setState(() {
                  numberPage++;
                });

                BlocProvider.of<GetTableCubit>(context).getTable(
                  pageId: widget.pageData.pageId.toString(),
                  employee: false,
                  isdesc: widget.pageData.isDesc,
                  limit: dropdownValue,
                  offset: (numberPage * dropdownValue) - dropdownValue,
                  orderby: widget.pageData.orderBy,
                  statment: ScreenTableBody.isSearch == true
                      ? BuildAlertSearch.statement
                      : '',
                  selectcolumns: '',
                  departmentName: widget.pageData.departmentName,
                  isDepartment: widget.pageData.isDepartment,
                  authorizationID: widget.pageData.authorizationID,
                  viewEmployeeColumn: widget.pageData.viewEmployeeColumn,
                  numberOfPage: numberPage,
                  dropdownValueOfLimit: dropdownValue,
                );
              },
            ),
            onTapHeader: (String titleHeader) {
              setState(() {
                orderBy = titleHeader;
                isDesc = !isDesc;
              });

              BlocProvider.of<GetTableCubit>(context).getTable(
                pageId: widget.pageData.pageId.toString(),
                employee: false,
                isdesc: isDesc,
                limit: dropdownValue,
                offset: (numberPage * dropdownValue) - dropdownValue,
                orderby: orderBy,
                statment: ScreenTableBody.isSearch == true
                    ? BuildAlertSearch.statement
                    : '',
                selectcolumns: '',
                departmentName: widget.pageData.departmentName,
                isDepartment: widget.pageData.isDepartment,
                authorizationID: widget.pageData.authorizationID,
                viewEmployeeColumn: widget.pageData.viewEmployeeColumn,
                numberOfPage: numberPage,
                dropdownValueOfLimit: dropdownValue,
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
  }

  // void getData(BuildContext context) {
  //   BlocProvider.of<GetTableCubit>(context).getTable(
  //     pageId: widget.pageData.pageId.toString(),
  //     employee: false,
  //     isdesc: isDesc,
  //     limit: dropdownValue,
  //     offset: (numberPage * dropdownValue) - dropdownValue,
  //     orderby: orderBy,
  //     statment:
  //         ScreenTableBody.isSearch == true ? BuildAlertSearch.statement : '',
  //     selectcolumns: '',
  //     numberOfPage: numberPage,
  //     dropdownValueOfLimit: dropdownValue,
  //   );
  // }
}

class MyCategory {
  final int id;
  final String name;

  MyCategory(this.id, this.name);
}
/*Expanded(
            child: MyTable(
              columnNumber: listHeader.length,
              numberItemInList: 2,
              // numberItemInList: state.screenModel.dataList.numberofrecords,
              listHeader: listHeader,
              list: state.screenModel.dataList.dynamicList,
              listData: listData,
              widthOtherColumn: MediaQuery.of(context).size.width * .3,
              widthFirstColumn: MediaQuery.of(context).size.width * .3,
              onTap: (value) {},
              // heightHeader: 60,
            ),
          )*/

/*Table(
                  border: TableBorder.all(color: Colors.white),
                  defaultVerticalAlignment:
                      TableCellVerticalAlignment.intrinsicHeight,
                  children: [
                    TableRow(
                      decoration: const BoxDecoration(color: Colors.blue),
                      children: [
                        ...List.generate(
                          listHeader.length,
                          (index) => TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Container(
                                // height: 35,
                                alignment: Alignment.center,
                                padding: const EdgeInsetsDirectional.symmetric(
                                    horizontal: 8),
                                child: Text(
                                  listHeader[index],
                                  textAlign: TextAlign.center,
                                  style: AppStyles.textStyle14,
                                )),
                          ),
                        )
                      ],
                    ),
                    ...List.generate(
                      30,
                      (index) => TableRow(
                        decoration: BoxDecoration(
                            color:
                                index.isEven ? Colors.blue[50] : Colors.white),
                        children: List<TableCell>.generate(
                          listHeader.length,
                          (i) => TableCell(
                            child: Text(listData[i]),
                          ),
                        ),
                      ),
                    )
                  ],
                ),*/
