import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:erp_system/core/widgets/custom_date_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_date.dart';
import '../../../../core/widgets/custom_dropdown_list.dart';
import '../../../../core/widgets/custom_error_massage.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/cost_balance_model.dart';
import '../../data/models/cost_items_model.dart';
import '../../data/models/currency_model.dart';
import '../../data/models/customer_account_entries_model.dart';
import '../../data/models/product_fast_inventory_model.dart';
import '../../data/models/product_non_inventory_model.dart';
import '../../data/models/supplier_model.dart';
import '../manager/costBalance/cost_balance_cubit.dart';
import 'cost_balance_table.dart';

class CostBalanceViewBody extends StatefulWidget {
  const CostBalanceViewBody({super.key});

  @override
  State<CostBalanceViewBody> createState() => _CostBalanceViewBodyState();
}

class _CostBalanceViewBodyState extends State<CostBalanceViewBody> {
  String dateFrom = "", dateTo = "";
  int costItemID = 0, productID = 0, supplierID = 0;
  List<int> currencyIDS = [];
  List<int> customerIDs = [];
  bool checkboxValue = false;

  List<CostItem> listCostItems = [];
  List<CurrencyItem> listCurrencyModel = [];
  List<CustomerAccountEntriesItem> listCustomerAccountEntriesModel = [];
  List<ProductFastInventoryItem> listProductFastInventoryModel = [];
  List<ProductNonInventoryItem> listProductNonInventoryModel = [];
  List<SupplierItem> listSupplierModel = [];
  Map<String, dynamic> bodyRequest = {};

  @override
  void initState() {
    initStatePage1();
    super.initState();
  }

  void initStatePage1() {
    fetchCostItems();
    fetchCurrency();
    fetchCustomerAccountEntries();
    fetchProductFastInventory();
    fetchProductNonInventory();
    fetchSupplier();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 12, right: 12),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomDateWidget(
                      onSelect: (date) {
                        setState(() {
                          dateFrom = date;
                          if (dateFrom == "") {
                            bodyRequest.remove("datefrom");
                          } else {
                            bodyRequest["datefrom"] = dateFrom;
                          }
                        });
                        if (costItemID != 0 ||
                            currencyIDS.isNotEmpty ||
                            customerIDs.isNotEmpty ||
                            productID != 0 ||
                            supplierID != 0) {
                          print("====================$dateFrom");
                          BlocProvider.of<CostBalanceCubit>(context).getCostBalance(
                            bodyRequest: bodyRequest,
                          );
                        }
                      },
                      title: S.of(context).date_from,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: CustomDateWidget(
                      onSelect: (date) {
                        setState(() {
                          dateTo = date;
                          if (dateTo == "") {
                            bodyRequest.remove("dateto");
                          } else {
                            bodyRequest["dateto"] = dateTo;
                          }
                        });
                        if (dateFrom.isNotEmpty &&
                            (costItemID != 0 ||
                                currencyIDS.isNotEmpty ||
                                customerIDs.isNotEmpty ||
                                productID != 0 ||
                                supplierID != 0)) {
                          print("====================$dateTo");
                          BlocProvider.of<CostBalanceCubit>(context).getCostBalance(
                            bodyRequest: bodyRequest,
                          );
                        }
                      },
                      title: S.of(context).date_to,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              CustomDropdownList<CostItem>(
                listData: listCostItems,
                onChanged: (costItem) {
                  setState(() {
                    costItemID = costItem?.cIID ?? 0;
                    if (costItemID == 0) {
                      bodyRequest.remove("CostItemID");
                    } else {
                      bodyRequest["CostItemID"] = costItemID;
                    }
                  });
                  if (dateFrom.isNotEmpty) {
                    print("====================$costItemID");
                    BlocProvider.of<CostBalanceCubit>(context).getCostBalance(
                      bodyRequest: bodyRequest,
                    );
                  }
                },
                title: S.of(context).cost_item,
              ),
              const SizedBox(height: 8),
              CustomDropdownList<CurrencyItem>(
                listData: listCurrencyModel,
                isMultiSelect: true,
                onListChanged: (selectedList) {
                  setState(() {
                    currencyIDS = selectedList.map((item) => item.cID!).toList();
                    if (currencyIDS.isEmpty) {
                      bodyRequest.remove("currancy");
                    } else {
                      bodyRequest["currancy"] = currencyIDS;
                    }
                  });
                  if (dateFrom.isNotEmpty) {
                    print("====================${currencyIDS.first}");
                    BlocProvider.of<CostBalanceCubit>(context).getCostBalance(
                      bodyRequest: bodyRequest,
                    );
                  }
                },
                title: S.of(context).currency,
              ),
              const SizedBox(height: 8),
              CustomDropdownList<CustomerAccountEntriesItem>(
                listData: listCustomerAccountEntriesModel,
                isMultiSelect: true,
                onListChanged: (customerAccountEntriesItem) {
                  setState(() {
                    customerIDs = customerAccountEntriesItem.map((item) => item.customerAccountID!).toList();
                    if (customerIDs.isEmpty) {
                      bodyRequest.remove("CustomerID");
                    } else {
                      bodyRequest["CustomerID"] = customerIDs;
                    }
                  });
                  if (dateFrom.isNotEmpty) {
                    BlocProvider.of<CostBalanceCubit>(context).getCostBalance(
                      bodyRequest: bodyRequest,
                    );
                  }
                },
                title: S.of(context).customer,
              ),
              const SizedBox(height: 8),
              CustomDropdownList<ProductFastInventoryItem>(
                listData: listProductFastInventoryModel,
                onChanged: (productFastInventoryItem) {
                  setState(() {
                    productID = productFastInventoryItem?.proID ?? 0;

                    if (productID == 0) {
                      bodyRequest.remove("ProductID");
                    } else {
                      bodyRequest["ProductID"] = productID;
                    }
                  });
                  if (dateFrom.isNotEmpty) {
                    print("====================$productID");
                    BlocProvider.of<CostBalanceCubit>(context).getCostBalance(
                      bodyRequest: bodyRequest,
                    );
                  }
                },
                title: S.of(context).products,
              ),
              const SizedBox(height: 8),
              CustomDropdownList<ProductNonInventoryItem>(
                listData: listProductNonInventoryModel,
                onChanged: (productNonInventoryItem) {
                  setState(() {
                    productID = productNonInventoryItem?.proID ?? 0;

                    if (productID == 0) {
                      bodyRequest.remove("ProductID");
                    } else {
                      bodyRequest["ProductID"] = productID;
                    }
                  });
                  if (dateFrom.isNotEmpty) {
                    print("====================$productID");
                    BlocProvider.of<CostBalanceCubit>(context).getCostBalance(
                      bodyRequest: bodyRequest,
                    );
                  }
                },
                title: S.of(context).projects,
              ),
              const SizedBox(height: 8),
              CustomDropdownList<SupplierItem>(
                listData: listSupplierModel,
                onChanged: (supplierItem) {
                  setState(() {
                    supplierID = supplierItem?.sID ?? 0;
                    if (supplierID == 0) {
                      bodyRequest.remove("supplierID");
                    } else {
                      bodyRequest["supplierID"] = supplierID;
                    }
                  });
                  if (dateFrom.isNotEmpty) {
                    print("====================$supplierID");
                    BlocProvider.of<CostBalanceCubit>(context).getCostBalance(
                      bodyRequest: bodyRequest,
                    );
                  }
                },
                title: S.of(context).supplier,
              ),
              StatefulBuilder(
                builder: (BuildContext context, void Function(void Function()) nsetState) {
                  return CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      value: checkboxValue,
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(
                        S.of(context).massage_number_zero,
                        style: AppStyles.textStyle14.copyWith(color: Colors.black),
                      ),
                      onChanged: (newValue) {
                        nsetState(() {
                          checkboxValue = !checkboxValue;
                        });

                        setState(() {
                          if (checkboxValue) {
                            bodyRequest["Iszero"] = true;
                          } else {
                            bodyRequest.remove("Iszero");
                          }
                        });
                        BlocProvider.of<CostBalanceCubit>(context).getCostBalance(
                          bodyRequest: bodyRequest,
                        );
                      });
                },
              ),
            ],
          ),
        ),
        BlocBuilder<CostBalanceCubit, CostBalanceState>(
          builder: (context, state) {
            if (state is CostBalanceSuccess) {
              List<CostBalanceModel> inventoryProductList = state.inventoryProductModel;
              return CostBalanceTable(
                costBalanceList: inventoryProductList,
                // selectionItemsShow: selectionItems,
              );
            } else if (state is CostBalanceFailure) {
              return CustomErrorMassage(errorMassage: state.errorMassage);
            } else if (state is CostBalanceLoading) {
              return const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: CustomLoadingWidget(),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
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

  void fetchCurrency() async {
    try {
      String companyKey = await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";

      Map<String, dynamic> currency = await ApiService(Dio()).post(
        endPoint: "web/Structure/getDataGlobal",
        data: {"tableName": "Currancy"},
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );

      setState(() {
        listCurrencyModel = CurrencyModel.fromJson(currency).currencyItemList!;
      });
    } catch (e) {
      log('Error fetching data: $e');
    }
  }

  void fetchCustomerAccountEntries() async {
    try {
      String companyKey = await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";

      Map<String, dynamic> customerAccountEntries = await ApiService(Dio()).post(
        endPoint: "web/Structure/getDataGlobal",
        data: {"tableName": "CustomerAccountEntries"},
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );

      setState(() {
        listCustomerAccountEntriesModel =
            CustomerAccountEntriesModel.fromJson(customerAccountEntries).customerAccountEntriesItemList!;
      });
    } catch (e) {
      log('Error fetching data: $e');
    }
  }

  void fetchProductFastInventory() async {
    try {
      String companyKey = await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";

      Map<String, dynamic> productFastInventory = await ApiService(Dio()).post(
        endPoint: "web/Structure/getDataGlobal",
        data: {"tableName": "ProductFastInv"},
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );

      setState(() {
        listProductFastInventoryModel = ProductFastInventoryModel.fromJson(productFastInventory).productFastInventoryItemList!;
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
}

// {
// "CostItemID": costItemID == 0 ? null : costItemID,
// "ProductID": productID == 0 ? null : productID,
// "datefrom": dateFrom == "" ? null : dateFrom,
// "dateto": dateTo == "" ? null : dateTo,
// "supplierID": supplierID == 0 ? null : supplierID,
// "currancy": currencyIDS.isEmpty ? [] : currencyIDS,
// "CustomerID": customerIDs.isEmpty ? [] : customerIDs,
// }
