import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/custom_error_massage.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../data/models/all_dropdown_model.dart';
import '../../data/models/screen_model.dart';
import '../../data/repositories/supplier_process_repo_impl.dart';
import '../manager/supplierProcess/supplier_process_cubit.dart';
import '../views/supplier_process_view.dart';
import 'custom_table_supplier_process.dart';
import 'pagination_widget.dart';
import 'tabs_widget.dart';

class SupplierProcessViewBody extends StatefulWidget {
  const SupplierProcessViewBody(
      {super.key,
      required this.listColumn,
      required this.pageData,
      required this.listColumnInTable});

  final List<ColumnList> listColumn;
  final List<ColumnList> listColumnInTable;
  final Pages pageData;

  @override
  State<SupplierProcessViewBody> createState() =>
      _SupplierProcessViewBodyState();
}

class _SupplierProcessViewBodyState extends State<SupplierProcessViewBody> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<Map<String, dynamic>> widgetsData = [];
  late List<AllDropdownModel> myAllDropdownModelList;

  String? lang;
  Map<String, dynamic> myData = {};
  ScrollController verticalScrollController = ScrollController();
  ScrollController horizontalScrollController = ScrollController();

  final DataGridController dataGridController = DataGridController();
  late TableDataSource tableDataSource;

  late int allPages;
  List<int> listNumberItemInList = [10, 25, 50, 100];
  late int numberPage;
  late int dropdownValue;
  late int selectTab;

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    initStatePage1();
    initStatePage2();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              _buildPage1(),
              _buildPage2(),
            ],
          ),
        ),
        navigationPageView(),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  navigationPageView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(2, (index) {
          return InkWell(
            onTap: () {
              _pageController.jumpToPage(index);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
              width: _currentPage == index ? 13 : 7,
              height: _currentPage == index ? 13 : 7,
              decoration: BoxDecoration(
                color: _currentPage == index ? Colors.blue : Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
          );
        }),
      ],
    );
  }

  void initStatePage1() {
    widgetsData.add({"widget": 1, "value": ""});
    widgetsData.add({"widget": 2, "value": ""});
    widgetsData.add({"widget": 3, "value": ""});
    widgetsData.add({"widget": 4, "value": ""});
    widgetsData.add({"widget": 5, "value": false});
    widgetsData.add({"widget": 6, "value": false});

    myAllDropdownModelList = SupplierProcessView.myAllDropdownModelList;
  }

  void initStatePage2() {
    numberPage = 1;
    dropdownValue = listNumberItemInList[0];
    selectTab = 0;
  }

  _buildPage1() {
    String? dropValue1;
    for (var i in myAllDropdownModelList[0]
        .list!
        .firstWhere(
          (element) => element.columnName == "supplierIDs",
        )
        .list!) {
      if (i.id.toString() == widgetsData[0]['value'].toString()) {
        dropValue1 = i.text ?? '';
      }
    }

    String? dropValue2;
    for (var i in myAllDropdownModelList[0]
        .list!
        .firstWhere(
          (element) => element.columnName == "CurrancyID",
        )
        .list!) {
      if (i.id.toString() == widgetsData[1]['value'].toString()) {
        dropValue2 = i.text ?? '';
      }
    }
    String dateFrom = widgetsData[2]['value'] != ""
        ? DateFormat("yyyy-MM-dd", 'en')
            .format(DateTime.parse(widgetsData[2]['value']))
        : "";
    String dateTo = widgetsData[3]['value'] != ""
        ? DateFormat("yyyy-MM-dd", 'en')
            .format(DateTime.parse(widgetsData[3]['value']))
        : "";
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "المورد",
                    style: AppStyles.textStyle14.copyWith(color: Colors.grey),
                  ),
                  StatefulBuilder(
                    builder: (context, dropSetState) {
                      return SizedBox(
                        height: 40,
                        child: CustomDropdown<String>.search(
                          hintText: '',
                          initialItem: dropValue1,
                          closedHeaderPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          decoration: CustomDropdownDecoration(
                            headerStyle: AppStyles.textStyle16
                                .copyWith(color: Colors.black),
                            closedFillColor: Colors.transparent,
                            closedBorder: Border.all(color: AppColors.blueDark),
                          ),
                          items: List.generate(
                            myAllDropdownModelList[0]
                                .list!
                                .firstWhere(
                                  (element) =>
                                      element.columnName == "supplierIDs",
                                )
                                .list!
                                .length,
                            (index) {
                              return myAllDropdownModelList[0]
                                      .list!
                                      .firstWhere(
                                        (element) =>
                                            element.columnName == "supplierIDs",
                                      )
                                      .list![index]
                                      .text ??
                                  "";
                            },
                          ),
                          onChanged: (value) {
                            dropSetState(() {
                              ItemDrop ii = myAllDropdownModelList[0]
                                  .list!
                                  .firstWhere(
                                    (element) =>
                                        element.columnName == "supplierIDs",
                                  )
                                  .list!
                                  .firstWhere(
                                      (element) => element.text == value);
                              widgetsData[0]['value'] = "";
                              widgetsData[0]['value'] = ii.id;
                            });
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "العملة",
                    style: AppStyles.textStyle14.copyWith(color: Colors.grey),
                  ),
                  StatefulBuilder(
                    builder: (context, dropSetState) {
                      return SizedBox(
                        height: 40,
                        child: CustomDropdown<String>.search(
                          hintText: '',
                          initialItem: dropValue2,
                          closedHeaderPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          decoration: CustomDropdownDecoration(
                            headerStyle: AppStyles.textStyle16
                                .copyWith(color: Colors.black),
                            closedFillColor: Colors.transparent,
                            closedBorder: Border.all(color: AppColors.blueDark),
                          ),
                          items: List.generate(
                            myAllDropdownModelList[0]
                                .list!
                                .firstWhere(
                                  (element) =>
                                      element.columnName == "CurrancyID",
                                )
                                .list!
                                .length,
                            (index) {
                              return myAllDropdownModelList[0]
                                      .list!
                                      .firstWhere(
                                        (element) =>
                                            element.columnName == "CurrancyID",
                                      )
                                      .list![index]
                                      .text ??
                                  "";
                            },
                          ),
                          onChanged: (value) {
                            dropSetState(() {
                              ItemDrop ii = myAllDropdownModelList[0]
                                  .list!
                                  .firstWhere(
                                    (element) =>
                                        element.columnName == "CurrancyID",
                                  )
                                  .list!
                                  .firstWhere(
                                      (element) => element.text == value);
                              widgetsData[1]['value'] = "";
                              widgetsData[1]['value'] = ii.id;
                            });
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "تاريخ من",
                    style: AppStyles.textStyle14.copyWith(color: Colors.grey),
                  ),
                  StatefulBuilder(
                    builder: (context, dsetState) {
                      return InkWell(
                        onTap: () async {
                          DateTime? dateTime = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1980),
                            lastDate: DateTime(2100),
                          );
                          if (dateTime != null) {
                            dsetState(() {
                              dateFrom = DateFormat("yyyy-MM-dd", 'en')
                                  .format(dateTime);
                              widgetsData[2]['value'] = "";
                              widgetsData[2]['value'] = dateTime.toString();
                            });
                          }
                        },
                        child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.blueDark)),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              dateFrom,
                              textAlign: TextAlign.center,
                              style: AppStyles.textStyle14
                                  .copyWith(color: Colors.black),
                            )),
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "تاريخ إلى",
                    style: AppStyles.textStyle14.copyWith(color: Colors.grey),
                  ),
                  StatefulBuilder(
                    builder: (context, dsetState) {
                      return InkWell(
                        onTap: () async {
                          DateTime? dateTime = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1980),
                            lastDate: DateTime(2100),
                          );
                          if (dateTime != null) {
                            dsetState(() {
                              dateTo = DateFormat("yyyy-MM-dd", 'en')
                                  .format(dateTime);
                              widgetsData[3]['value'] = "";
                              widgetsData[3]['value'] = dateTime.toString();
                            });
                          }
                        },
                        child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.blueDark)),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              dateTo,
                              textAlign: TextAlign.center,
                              style: AppStyles.textStyle14
                                  .copyWith(color: Colors.black),
                            )),
                      );
                    },
                  ),
                ],
              ),
            ),
            StatefulBuilder(
              builder: (context, csetState) {
                return CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: widgetsData[4]['value'],
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    "عدم حساب الشيكات",
                    style: AppStyles.textStyle14.copyWith(color: Colors.black),
                  ),
                  onChanged: (newValue) {
                    csetState(() {
                      widgetsData[4]['value'] = false;
                      widgetsData[4]['value'] = newValue;
                    });
                  },
                );
              },
            ),
            StatefulBuilder(
              builder: (context, csetState) {
                return CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: widgetsData[5]['value'],
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    "استخدام الداتا السابقة",
                    style: AppStyles.textStyle14.copyWith(color: Colors.black),
                  ),
                  onChanged: (newValue) {
                    csetState(() {
                      widgetsData[5]['value'] = false;
                      widgetsData[5]['value'] = newValue;
                    });
                  },
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.blueLight,
          shape: const StadiumBorder(),
          child: Icon(
            Icons.search,
            color: AppColors.white,
          ),
          onPressed: () {
            selectTab = 0;
            numberPage = 1;
            dropdownValue = listNumberItemInList[0];
            createMyData(data: {
              "pageId": widget.pageData.pageId,
              "employee": false,
              "limit": dropdownValue,
              "offset": (numberPage * dropdownValue) - dropdownValue,
              "statment": "",
              "selectcolumns": "",
              "IsDepartment": widget.pageData.isDepartment,
              "DepartmentName": widget.pageData.departmentName,
              "AuthorizationID": widget.pageData.authorizationID,
              "ViewEmployeeColumn": widget.pageData.viewEmployeeColumn,
              "OrderBy": widget.pageData.orderBy,
              "IsDesc": widget.pageData.isDesc,
              "tableName": "[ProfAccount]",
              "tailcondition": "",
            });
            _pageController.jumpToPage(2);
          },
        ),
      ),
    );
  }

  _buildPage2() {
    return myData.isNotEmpty
        ? BlocProvider(
            create: (context) =>
                SupplierProcessCubit(getIt.get<SupplierProcessRepoImpl>())
                  ..getTableSupplierProcess(
                    selectTab: selectTab,
                    objectData: myData,
                    numberOfPage: numberPage,
                    link: "ProfAccount",
                    dropdownValueOfLimit: dropdownValue,
                  ),
            child: BlocBuilder<SupplierProcessCubit, SupplierProcessState>(
              builder: (context, state) {
                if (state is SupplierProcessSuccess) {
                  int? numberOfRecords = state.accountProfModel.numberofrecords;

                  List<dynamic>? listData = state.accountProfModel.dynamicList;

                  numberPage = state.numberPage;
                  selectTab = state.selectTap;
                  dropdownValue = state.dropdownValue;
                  allPages = (numberOfRecords! % dropdownValue) == 0
                      ? (numberOfRecords ~/ dropdownValue)
                      : (numberOfRecords ~/ dropdownValue) + 1;
                  return CustomTableSupplierProcess(
                    pageData: widget.pageData,
                    listData: listData!,
                    listColumn: widget.listColumnInTable,
                    allDropdownModelList:
                        SupplierProcessView.myAllDropdownModelList,
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
                        // createMyData();
                        BlocProvider.of<SupplierProcessCubit>(context)
                            .getTableSupplierProcess(
                          selectTab: selectTab,
                          objectData: myData,
                          link: selectTab == 0
                              ? "ProfAccount"
                              : selectTab == 5
                                  ? "ProfAccount"
                                  : "Structure",
                          numberOfPage: numberPage,
                          dropdownValueOfLimit: dropdownValue,
                        );
                      },
                      onTapMin: () {
                        setState(() {
                          numberPage--;
                        });
                        // createMyData();
                        BlocProvider.of<SupplierProcessCubit>(context)
                            .getTableSupplierProcess(
                          selectTab: selectTab,
                          objectData: myData,
                          link: selectTab == 0
                              ? "ProfAccount"
                              : selectTab == 5
                                  ? "ProfAccount"
                                  : "Structure",
                          numberOfPage: numberPage,
                          dropdownValueOfLimit: dropdownValue,
                        );
                      },
                      onTapAdd: () {
                        setState(() {
                          numberPage++;
                        });
                        // createMyData();
                        BlocProvider.of<SupplierProcessCubit>(context)
                            .getTableSupplierProcess(
                          selectTab: selectTab,
                          objectData: myData,
                          link: selectTab == 0
                              ? "ProfAccount"
                              : selectTab == 5
                                  ? "ProfAccount"
                                  : "Structure",
                          numberOfPage: numberPage,
                          dropdownValueOfLimit: dropdownValue,
                        );
                      },
                    ),
                    tabsWidget: TabsWidget(
                      selectTab: selectTab,
                      onTap: (index) {
                        setState(() {
                          selectTab = index;
                        });
                        switch (index) {
                          case 0:
                            createMyData(data: {
                              "pageId": widget.pageData.pageId,
                              "employee": false,
                              "limit": dropdownValue,
                              "offset":
                                  (numberPage * dropdownValue) - dropdownValue,
                              "statment": "",
                              "selectcolumns": "",
                              "IsDepartment": widget.pageData.isDepartment,
                              "DepartmentName": widget.pageData.departmentName,
                              "AuthorizationID":
                                  widget.pageData.authorizationID,
                              "ViewEmployeeColumn":
                                  widget.pageData.viewEmployeeColumn,
                              "OrderBy": widget.pageData.orderBy,
                              "IsDesc": widget.pageData.isDesc,
                              "tableName": "[ProfAccount]",
                              "tailcondition": "",
                            });

                            BlocProvider.of<SupplierProcessCubit>(context)
                                .getTableSupplierProcess(
                              selectTab: selectTab,
                              objectData: myData,
                              link: "ProfAccount",
                              numberOfPage: numberPage,
                              dropdownValueOfLimit: dropdownValue,
                            );
                            break;
                          case 1:
                            String till = "";
                            if (widgetsData[0]['value'] != "") {
                              till =
                                  "${till}POID is not null AND SupplierID= ${widgetsData[0]['value']} ";
                            }
                            if (widgetsData[2]['value'] != "") {
                              till =
                                  "${till}AND PODate >= CONVERT(DATETIME,'${widgetsData[2]['value']}', 102) ";
                            }
                            if (widgetsData[3]['value'] != "") {
                              till =
                                  "${till}AND PODate <= CONVERT(DATETIME,'${widgetsData[3]['value']}', 102) ";
                            }

                            createMyData(data: {
                              "pageId": 289,
                              "employee": false,
                              "limit": dropdownValue,
                              "offset":
                                  (numberPage * dropdownValue) - dropdownValue,
                              "statment": "",
                              "selectcolumns": "",
                              "IsDepartment": false,
                              "DepartmentName": "",
                              "AuthorizationID": 0,
                              "ViewEmployeeColumn": "",
                              "OrderBy": "POID",
                              "IsDesc": true,
                              "tableName": "[PurchaseDetialView]",
                              "tailcondition": till,
                            });

                            BlocProvider.of<SupplierProcessCubit>(context)
                                .getTableSupplierProcess(
                              selectTab: selectTab,
                              objectData: myData,
                              link: "Structure",
                              numberOfPage: numberPage,
                              dropdownValueOfLimit: dropdownValue,
                            );
                            break;
                          case 2:
                            String till = "";
                            if (widgetsData[0]['value'] != "") {
                              till =
                                  "${till}PRID is not null AND SupplierID= ${widgetsData[0]['value']} ";
                            }
                            if (widgetsData[2]['value'] != "") {
                              till =
                                  "${till}AND ActualPayDate >= CONVERT(DATETIME,'${widgetsData[2]['value']}', 102) ";
                            }
                            if (widgetsData[3]['value'] != "") {
                              till =
                                  "${till}AND ActualPayDate <= CONVERT(DATETIME,'${widgetsData[3]['value']}', 102) ";
                            }

                            createMyData(data: {
                              "pageId": 289,
                              "employee": false,
                              "limit": dropdownValue,
                              "offset":
                                  (numberPage * dropdownValue) - dropdownValue,
                              "statment": "",
                              "selectcolumns": "",
                              "IsDepartment": false,
                              "DepartmentName": "",
                              "AuthorizationID": 0,
                              "ViewEmployeeColumn": "",
                              "OrderBy": "POID",
                              "IsDesc": true,
                              "tableName": "[PaymentReciveView]",
                              "tailcondition": till,
                            });

                            BlocProvider.of<SupplierProcessCubit>(context)
                                .getTableSupplierProcess(
                              selectTab: selectTab,
                              objectData: myData,
                              numberOfPage: numberPage,
                              link: "Structure",
                              dropdownValueOfLimit: dropdownValue,
                            );
                            break;
                          case 3:
                            String till = "";
                            if (widgetsData[0]['value'] != "") {
                              till =
                                  "${till}ExtractionID is not null AND SupplierID= ${widgetsData[0]['value']} ";
                            }
                            if (widgetsData[2]['value'] != "") {
                              till =
                                  "${till}AND ExtractionDate >= CONVERT(DATETIME,'${widgetsData[2]['value']}', 102) ";
                            }
                            if (widgetsData[3]['value'] != "") {
                              till =
                                  "${till}AND ExtractionDate <= CONVERT(DATETIME,'${widgetsData[3]['value']}', 102) ";
                            }

                            createMyData(data: {
                              "pageId": widget.pageData.pageId,
                              "employee": false,
                              "limit": dropdownValue,
                              "offset":
                                  (numberPage * dropdownValue) - dropdownValue,
                              "statment": "",
                              "selectcolumns": "",
                              "IsDepartment": widget.pageData.isDepartment,
                              "DepartmentName": widget.pageData.departmentName,
                              "AuthorizationID":
                                  widget.pageData.authorizationID,
                              "ViewEmployeeColumn":
                                  widget.pageData.viewEmployeeColumn,
                              "OrderBy": widget.pageData.orderBy,
                              "IsDesc": widget.pageData.isDesc,
                              "tableName": "[ExtractionDetailsReport]",
                              "tailcondition": till,
                            });

                            BlocProvider.of<SupplierProcessCubit>(context)
                                .getTableSupplierProcess(
                              selectTab: selectTab,
                              objectData: myData,
                              numberOfPage: numberPage,
                              link: "Structure",
                              dropdownValueOfLimit: dropdownValue,
                            );
                            break;
                          case 4:
                            String till = "";
                            if (widgetsData[0]['value'] != "") {
                              till =
                                  "${till}ExtractionMasterID is not null AND SupplierID= ${widgetsData[0]['value']} ";
                            }
                            if (widgetsData[2]['value'] != "") {
                              till =
                                  "${till}AND ExtractionDate >= CONVERT(DATETIME,'${widgetsData[2]['value']}', 102) ";
                            }
                            if (widgetsData[3]['value'] != "") {
                              till =
                                  "${till}AND ExtractionDate <= CONVERT(DATETIME,'${widgetsData[3]['value']}', 102) ";
                            }

                            createMyData(data: {
                              "pageId": widget.pageData.pageId,
                              "employee": false,
                              "limit": dropdownValue,
                              "offset":
                                  (numberPage * dropdownValue) - dropdownValue,
                              "statment": "",
                              "selectcolumns": "",
                              "IsDepartment": widget.pageData.isDepartment,
                              "DepartmentName": widget.pageData.departmentName,
                              "AuthorizationID":
                                  widget.pageData.authorizationID,
                              "ViewEmployeeColumn":
                                  widget.pageData.viewEmployeeColumn,
                              "OrderBy": widget.pageData.orderBy,
                              "IsDesc": widget.pageData.isDesc,
                              "tableName": "[ExtractionTotalReport]",
                              "tailcondition": till,
                            });

                            BlocProvider.of<SupplierProcessCubit>(context)
                                .getTableSupplierProcess(
                              selectTab: selectTab,
                              objectData: myData,
                              link: "Structure",
                              numberOfPage: numberPage,
                              dropdownValueOfLimit: dropdownValue,
                            );
                            break;
                          case 5:
                            createMyData(data: {
                              "pageId": widget.pageData.pageId,
                              "employee": false,
                              "limit": dropdownValue,
                              "offset":
                                  (numberPage * dropdownValue) - dropdownValue,
                              "statment": "",
                              "selectcolumns": "",
                              "IsDepartment": widget.pageData.isDepartment,
                              "DepartmentName": widget.pageData.departmentName,
                              "AuthorizationID":
                                  widget.pageData.authorizationID,
                              "ViewEmployeeColumn":
                                  widget.pageData.viewEmployeeColumn,
                              "OrderBy": widget.pageData.orderBy,
                              "IsDesc": widget.pageData.isDesc,
                              "tableName": "EntryWithPurchaseDetail",
                              "tailcondition": "",
                            });

                            BlocProvider.of<SupplierProcessCubit>(context)
                                .getTableSupplierProcess(
                              selectTab: selectTab,
                              objectData: myData,
                              link: "ProfAccount",
                              numberOfPage: numberPage,
                              dropdownValueOfLimit: dropdownValue,
                            );
                            break;
                        }
                      },
                    ),
                  );
                } else if (state is SupplierProcessFailure) {
                  return CustomErrorMassage(errorMassage: state.errorMassage);
                } else {
                  return const CustomLoadingWidget();
                }
              },
            ),
          )
        : const SizedBox();
  }

  void createMyData({required Map<String, dynamic> data}) {
    String tailCondition = "";
    Map<String, dynamic> params = {};
    myData = {};
    myData.addAll(data);

    params["supplierID"] = widgetsData[0]['value'];
    params["CurrancyID"] = widgetsData[1]['value'];
    params["datefrom"] = widgetsData[2]['value'];
    params["dateto"] = widgetsData[3]['value'];
    params["DontShowCheque"] = widgetsData[4]['value'];
    params["GettingFromTemp"] = widgetsData[5]['value'];

    myData["Params"] = params;
  }
}
