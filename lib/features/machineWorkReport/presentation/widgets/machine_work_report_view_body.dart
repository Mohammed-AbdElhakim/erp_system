import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_dropdown_list.dart';
import '../../../../core/widgets/custom_error_massage.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/header_model.dart';
import '../../data/models/cost_items_model.dart';
import '../../data/models/customer_account_view_model.dart';
import '../../data/models/machine_work_report_model.dart';
import '../../data/models/product_non_inventory_model.dart';
import '../../data/models/supplier_model.dart';
import '../manager/machineWorkReport/machine_work_report_cubit.dart';
import 'custom_table_widget.dart';
import 'pagination_widget.dart';

class MachineWorkReportViewBody extends StatefulWidget {
  const MachineWorkReportViewBody({super.key, required this.pageData});

  final Pages pageData;

  @override
  State<MachineWorkReportViewBody> createState() => _MachineWorkReportViewBodyState();
}

class _MachineWorkReportViewBodyState extends State<MachineWorkReportViewBody> {
  int costItemID = 0, projectID = 0, supplierID = 0, customerID = 0;

  List<CostItem> listCostItems = [];
  List<CustomerAccountViewItem> listCustomerAccountViewModel = [];
  List<ProductNonInventoryItem> listProductNonInventoryModel = [];
  List<SupplierItem> listSupplierModel = [];
  List<HeaderModel> listHeader = [];
  Map<String, dynamic> bodyRequest = {
    "Groupby": null,
    "IsStoredProc": false,
    "Params": null,
    "arrayToSum": null,
    "authorizationID": 0,
    "company": true,
    "companyname": "ComID",
    "employee": false,
    "isCashed": false,
    "isDepartment": false,
    "isdesc": true,
    "limit": 10,
    "listName": "MachinWorkDetailReport",
    "offset": 0,
    "selectFromCash": true,
    "selectcolumns": null,
    "statment": "",
    "tableName": "[MachinworkwithEntries]",
    "tailcondition": "",
    "viewEmployeeColumn": "",
  };

  late int allPages;
  List<int> listNumberItemInList = [10, 25, 50, 100];
  late int numberPage;
  late int dropdownValue;

  @override
  void initState() {
    numberPage = 1;
    dropdownValue = listNumberItemInList[0];
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 12, right: 12),
          child: Column(
            children: [
              CustomDropdownList<SupplierItem>(
                listData: listSupplierModel,
                onChanged: (supplierItem) {
                  setState(() {
                    supplierID = supplierItem?.sID ?? 0;

                    bodyRequest['tailcondition'] = createTailCondition(
                      costItem: costItemID,
                      projectId: projectID,
                      supplierId: supplierID,
                    );
                  });
                  bodyRequest["offset"] = (numberPage * dropdownValue) - dropdownValue;
                  bodyRequest["limit"] = dropdownValue;
                  BlocProvider.of<MachineWorkReportCubit>(context).getMachineWorkReport(
                    bodyRequest: bodyRequest,
                    numberOfPage: numberPage,
                    dropdownValueOfLimit: dropdownValue,
                  );
                },
                title: S.of(context).supplier,
              ),
              const SizedBox(height: 8),
              CustomDropdownList<ProductNonInventoryItem>(
                listData: listProductNonInventoryModel,
                onChanged: (productNonInventoryItem) {
                  setState(() {
                    projectID = productNonInventoryItem?.proID ?? 0;

                    bodyRequest['tailcondition'] = createTailCondition(
                      costItem: costItemID,
                      projectId: projectID,
                      supplierId: supplierID,
                    );
                  });
                  bodyRequest["offset"] = (numberPage * dropdownValue) - dropdownValue;
                  bodyRequest["limit"] = dropdownValue;
                  BlocProvider.of<MachineWorkReportCubit>(context).getMachineWorkReport(
                    bodyRequest: bodyRequest,
                    numberOfPage: numberPage,
                    dropdownValueOfLimit: dropdownValue,
                  );
                },
                title: S.of(context).projects,
              ),
              const SizedBox(height: 8),
              CustomDropdownList<CostItem>(
                listData: listCostItems,
                onChanged: (costItem) {
                  setState(() {
                    costItemID = costItem?.cIID ?? 0;
                    bodyRequest['tailcondition'] = createTailCondition(
                      costItem: costItemID,
                      projectId: projectID,
                      supplierId: supplierID,
                    );
                  });

                  bodyRequest["offset"] = (numberPage * dropdownValue) - dropdownValue;
                  bodyRequest["limit"] = dropdownValue;
                  BlocProvider.of<MachineWorkReportCubit>(context).getMachineWorkReport(
                    bodyRequest: bodyRequest,
                    numberOfPage: numberPage,
                    dropdownValueOfLimit: dropdownValue,
                  );
                },
                title: S.of(context).cost_item,
              ),
              const SizedBox(height: 8),
              CustomDropdownList<CustomerAccountViewItem>(
                listData: listCustomerAccountViewModel,
                onChanged: (customerAccountViewItem) {
                  // setState(() {
                  //   customerID = customerAccountViewItem?.customerAccountID ?? 0;
                  //   bodyRequest['tailcondition'] = createTailCondition(
                  //     costItem: costItemID,
                  //     projectId: projectID,
                  //     supplierId: supplierID,
                  //   );
                  // });
                  // BlocProvider.of<MachineWorkReportCubit>(context).getMachineWorkReport(bodyRequest: bodyRequest);
                },
                title: S.of(context).customer,
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .65,
          child: BlocBuilder<MachineWorkReportCubit, MachineWorkReportState>(
            builder: (context, state) {
              if (state is MachineWorkReportSuccess) {
                int? numberOfRecords = state.machineWorkReportData.numberofrecords;
                List<MachineWorkReportItem>? listData = state.machineWorkReportData.listMachineWorkReport;

                numberPage = state.numberPage;
                dropdownValue = state.dropdownValue;
                allPages = (numberOfRecords! % dropdownValue) == 0
                    ? (numberOfRecords ~/ dropdownValue)
                    : (numberOfRecords ~/ dropdownValue) + 1;
                List<HeaderModel> headerInTable =
                    listHeader.where((item) => item.visible == true && item.cvisable == true).toList();

                return CustomTableWidget(
                  listData: listData!,
                  listColumn: headerInTable,
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

                      bodyRequest["offset"] = (numberPage * dropdownValue) - dropdownValue;
                      bodyRequest["limit"] = dropdownValue;
                      BlocProvider.of<MachineWorkReportCubit>(context).getMachineWorkReport(
                        bodyRequest: bodyRequest,
                        numberOfPage: numberPage,
                        dropdownValueOfLimit: dropdownValue,
                      );
                    },
                    onTapMin: () {
                      setState(() {
                        numberPage--;
                      });
                      bodyRequest["offset"] = (numberPage * dropdownValue) - dropdownValue;
                      bodyRequest["limit"] = dropdownValue;
                      BlocProvider.of<MachineWorkReportCubit>(context).getMachineWorkReport(
                        bodyRequest: bodyRequest,
                        numberOfPage: numberPage,
                        dropdownValueOfLimit: dropdownValue,
                      );
                    },
                    onTapAdd: () {
                      setState(() {
                        numberPage++;
                      });
                      bodyRequest["offset"] = (numberPage * dropdownValue) - dropdownValue;
                      bodyRequest["limit"] = dropdownValue;
                      BlocProvider.of<MachineWorkReportCubit>(context).getMachineWorkReport(
                        bodyRequest: bodyRequest,
                        numberOfPage: numberPage,
                        dropdownValueOfLimit: dropdownValue,
                      );
                    },
                    pageData: widget.pageData,
                    myData: bodyRequest,
                  ),
                );
              } else if (state is MachineWorkReportFailure) {
                return CustomErrorMassage(errorMassage: state.errorMassage);
              } else if (state is MachineWorkReportLoading) {
                return const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: CustomLoadingWidget(),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ],
    );
  }

  void fetchData() {
    fetchCostItems();
    fetchCustomerAccountView();
    fetchProductNonInventory();
    fetchSupplier();
    fetchHeader();
  }

  void fetchCostItems() async {
    try {
      String companyKey = await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";

      Map<String, dynamic> costItems = await ApiService(Dio()).post(
        endPoint: "web/Structure/getDataGlobal",
        data: {"tableName": "CostItems"},
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      setState(() {
        listCostItems = CostItemsModel.fromJson(costItems).costItemList!;
      });
    } catch (e) {
      log('Error fetching data: $e');
    }
  }

  void fetchCustomerAccountView() async {
    try {
      String companyKey = await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";

      Map<String, dynamic> customerAccountEntries = await ApiService(Dio()).post(
        endPoint: "web/Structure/getDataGlobal",
        data: {"tableName": "CustomerAccounTView"},
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );

      setState(() {
        listCustomerAccountViewModel = CustomerAccountViewModel.fromJson(customerAccountEntries).customerAccountViewItemList!;
      });
    } catch (e) {
      log('Error fetching data: $e');
    }
  }

  void fetchProductNonInventory() async {
    try {
      String companyKey = await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";

      Map<String, dynamic> productNonInventory = await ApiService(Dio()).post(
        endPoint: "web/Structure/getDataGlobal",
        data: {"tableName": "ProductNonInventory"},
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );

      setState(() {
        listProductNonInventoryModel = ProductNonInventoryModel.fromJson(productNonInventory).productNonInventoryItemList!;
      });
    } catch (e) {
      log('Error fetching data: $e');
    }
  }

  void fetchSupplier() async {
    try {
      String companyKey = await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";

      Map<String, dynamic> supplier = await ApiService(Dio()).post(
        endPoint: "web/Structure/getDataGlobal",
        data: {"tableName": "supplier"},
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      setState(() {
        listSupplierModel = SupplierModel.fromJson(supplier).supplierItemList!;
      });
    } catch (e) {
      log('Error fetching data: $e');
    }
  }

  void fetchHeader() async {
    try {
      String companyKey = await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";

      List<dynamic> header = await ApiService(Dio()).get(
        endPoint: "web/Structure/getListSetups/MachinWorkDetailReport",
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      List<HeaderModel> list = [];
      for (var i in header) {
        list.add(HeaderModel.fromJson(i));
      }
      setState(() {
        listHeader = list;
      });
    } catch (e) {
      log('Error fetching data: $e');
    }
  }

  String createTailCondition({
    required int supplierId,
    required int costItem,
    required int projectId,
  }) {
    List<String> conditions = ['1=1'];

    if (supplierId != 0) {
      conditions.add('SupplierID =$supplierId');
    }

    if (costItem != 0) {
      conditions.add('CostItem =$costItem');
    }

    if (projectId != 0) {
      conditions.add('ProjectID =$projectId');
      conditions.add('ProjectID =$projectId');
    }

    return conditions.join('and ');
  }
}
