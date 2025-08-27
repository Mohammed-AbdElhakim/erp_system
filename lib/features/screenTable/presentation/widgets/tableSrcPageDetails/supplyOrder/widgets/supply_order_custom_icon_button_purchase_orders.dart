import 'package:dio/dio.dart';
import 'package:erp_system/core/utils/app_colors.dart';
import 'package:erp_system/core/widgets/custom_text_form_field_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../../../../core/manager/dataGlobal/data_global_cubit.dart';
import '../../../../../../../core/repositories/general/general_repo_impl.dart';
import '../../../../../../../core/utils/api_service.dart';
import '../../../../../../../core/utils/app_strings.dart';
import '../../../../../../../core/utils/service_locator.dart';
import '../../../../../../../core/widgets/custom_error_massage.dart';
import '../../../../../../../core/widgets/custom_loading_widget.dart';
import '../../../../../../../generated/l10n.dart';
import '../models/supply_order_purchase_orders_model.dart';
import '../models/supply_order_purchase_request_detail_model.dart';

typedef OnTapAdd<T> = void Function(T data);

class SupplyOrderCustomIconButtonPurchaseOrders extends StatefulWidget {
  const SupplyOrderCustomIconButtonPurchaseOrders({super.key, required this.onTapAdd});

  final OnTapAdd<List<Map<String, dynamic>>> onTapAdd;
  @override
  State<SupplyOrderCustomIconButtonPurchaseOrders> createState() =>
      _SupplyOrderCustomIconButtonPurchaseOrdersState();
}

class _SupplyOrderCustomIconButtonPurchaseOrdersState
    extends State<SupplyOrderCustomIconButtonPurchaseOrders> {
  late SupplyOrderPurchaseRequestDetailModel purchaseRequestDetailModel;
  List<Map<String, dynamic>> data = [];
  @override
  void initState() {
    super.initState();
    getDataList();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          isDismissible: false,
          builder: (BuildContext context) {
            return SizedBox(
              height: MediaQuery.sizeOf(context).height * .75,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: BlocProvider(
                  create: (context) => DataGlobalCubit(getIt.get<GeneralRepoImpl>())
                    ..getDataGlobal(bodyRequest: {
                      "company": false,
                      "tableName": "purchaseRequestAddedSupplyOrder",
                      "limit": 0,
                      "companyname": null,
                      "statment": "",
                      "tailcondition": null,
                      "Params": null,
                      "employee": false,
                      "authorizationID": 0
                    }, link: "Structure"),
                  child: BlocBuilder<DataGlobalCubit, DataGlobalState>(
                    builder: (context, state) {
                      if (state is DataGlobalSuccess) {
                        SupplyOrderPurchaseOrdersModel purchaseOrdersModel =
                            SupplyOrderPurchaseOrdersModel.fromJson(state.data);
                        return Column(
                          children: [
                            Expanded(
                              child: BuildCustomTable(
                                purchaseOrdersList: purchaseOrdersModel.dynamicList ?? [],
                                onTapRow: (rowData) {
                                  data.clear();
                                  for (var i in rowData) {
                                    List<DynamicListItem> itemsList =
                                        purchaseRequestDetailModel.dynamicList!
                                            .where(
                                              (element) => element.id == i['id'],
                                            )
                                            .toList();
                                    for (var item in itemsList) {
                                      if (item.remainingQuantity != 0) {
                                        data.add({
                                          "ProductID": "${item.productId}",
                                          "ColorID": item.colorID,
                                          "SizeID": item.sizeID,
                                          "DetailQuantity": "${item.remainingQuantity}",
                                          "DetailValue": "${item.proCost}",
                                          "DetailName": item.sOMName ?? "",
                                          "TotalPrice":
                                              "${(item.proCost!) * (item.remainingQuantity!)}",
                                        });
                                      }
                                    }
                                  }
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    widget.onTapAdd(data);
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.blueLight,
                                  ),
                                  child: Text(S.of(context).save,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      )),
                                ),
                                const SizedBox(width: 15),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(S.of(context).cancel)),
                                const SizedBox(width: 15),
                              ],
                            )
                          ],
                        );
                      } else if (state is DataGlobalFailure) {
                        return CustomErrorMassage(errorMassage: state.errorMassage);
                      } else if (state is DataGlobalLoading) {
                        return const CustomLoadingWidget();
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
      icon: const Icon(
        Icons.list_alt,
        color: Colors.white,
      ),
      style: IconButton.styleFrom(
        backgroundColor: Colors.red.shade900,
      ),
    );
  }

  void getDataList() async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      Map<String, dynamic> purchaseRequestDetail = await ApiService(Dio()).post(
        endPoint: "web/Structure/getDataGlobal",
        data: {
          "company": false,
          "tableName": "purchaseRequestDetailView1",
          "limit": 0,
          "companyname": null,
          "statment": "",
          "tailcondition": null,
          "Params": null,
          "employee": false,
          "authorizationID": 0
        },
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );

      setState(() {
        purchaseRequestDetailModel =
            SupplyOrderPurchaseRequestDetailModel.fromJson(purchaseRequestDetail);
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

typedef OnTapRow<T> = void Function(T rowData);

class BuildCustomTable extends StatefulWidget {
  const BuildCustomTable({
    super.key,
    required this.purchaseOrdersList,
    required this.onTapRow,
  });
  final List<DynamicList> purchaseOrdersList;
  final OnTapRow<List<Map<String, dynamic>>> onTapRow;
  @override
  State<BuildCustomTable> createState() => _BuildCustomTableState();
}

class _BuildCustomTableState extends State<BuildCustomTable> {
  late PurchaseOrdersDataSource purchaseOrdersDataSource;
  ScrollController verticalScrollController = ScrollController();
  ScrollController horizontalScrollController = ScrollController();
  List<DynamicList> _filteredList = [];
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> rowsData = [];
  final DataGridController dataGridController = DataGridController();

  @override
  void initState() {
    super.initState();
    _filteredList = widget.purchaseOrdersList;
    purchaseOrdersDataSource =
        PurchaseOrdersDataSource(purchaseOrdersList: _filteredList);

    _searchController.addListener(_filterList);
  }

  void _filterList() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredList = widget.purchaseOrdersList.where((item) {
        return item.serialNumber.toString().contains(query) ||
            (item.note?.toLowerCase().contains(query) ?? false) ||
            (item.sOMName?.toLowerCase().contains(query) ?? false) ||
            (item.customerAccountName?.toLowerCase().contains(query) ?? false) ||
            (item.oMName?.toLowerCase().contains(query) ?? false) ||
            (item.projectName?.toLowerCase().contains(query) ?? false) ||
            (item.employeeNameA?.toLowerCase().contains(query) ?? false);
      }).toList();
      purchaseOrdersDataSource =
          PurchaseOrdersDataSource(purchaseOrdersList: _filteredList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CustomTextFormFieldSearch(
              hintText: S.of(context).search,
              fillColor: Colors.white,
              controller: _searchController,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: SfDataGridTheme(
              data: SfDataGridThemeData(
                gridLineColor: Colors.grey.shade300,
                headerColor: AppColors.blueLight,
                selectionColor: AppColors.blueGreyDark,
              ),
              child: SfDataGrid(
                source: purchaseOrdersDataSource,
                controller: dataGridController,
                headerRowHeight: 35,
                rowHeight: 35,
                selectionMode: SelectionMode.multiple,
                showCheckboxColumn: true,
                verticalScrollController: verticalScrollController,
                horizontalScrollController: horizontalScrollController,
                gridLinesVisibility: GridLinesVisibility.both,
                headerGridLinesVisibility: GridLinesVisibility.both,
                columnWidthMode: ColumnWidthMode.auto,
                isScrollbarAlwaysShown: true,
                checkboxColumnSettings: const DataGridCheckboxColumnSettings(
                  showCheckboxOnHeader: false,
                  width: 35,
                ),
                onSelectionChanged: (addedRows, removedRows) {
                  rowsData.clear();
                  var selectedRows = dataGridController.selectedRows;

                  for (var row in selectedRows) {
                    Map<String, dynamic> mapData = {};
                    row.getCells().forEach((element) {
                      if (element.value != "") {
                        setState(() {
                          mapData[element.columnName] = element.value;
                        });
                      }
                    });
                    rowsData.add(mapData);
                  }
                  widget.onTapRow(rowsData);
                },
                columns: <GridColumn>[
                  GridColumn(
                      columnName: 'id',
                      width: 0,
                      label: const Center(
                        child: Text(
                          'id',
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                  GridColumn(
                      columnName: 'PurchaseRequestNumber',
                      width: 100,
                      label: const Center(
                        child: Text(
                          'رقم طلب الشراء',
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                  GridColumn(
                      columnName: 'dateOrder',
                      width: 100,
                      label: const Center(
                          child: Text(
                        'تاريخ الطلب	',
                        style: TextStyle(color: Colors.white),
                      ))),
                  GridColumn(
                      columnName: 'date',
                      width: 100,
                      label: const Center(
                          child: Text(
                        'التاريخ',
                        style: TextStyle(color: Colors.white),
                      ))),
                  GridColumn(
                      columnName: 'note',
                      width: 130,
                      label: const Center(
                          child: Text(
                        'ملاحظة',
                        style: TextStyle(color: Colors.white),
                      ))),
                  GridColumn(
                      columnName: 'employe',
                      width: 130,
                      label: const Center(
                          child: Text(
                        'الموظف',
                        style: TextStyle(color: Colors.white),
                      ))),
                  GridColumn(
                      columnName: 'name',
                      width: 150,
                      label: const Center(
                          child: Text(
                        'اسم امرالتوريد او البيع',
                        style: TextStyle(color: Colors.white),
                      ))),
                  GridColumn(
                      columnName: 'CustomerAccountName',
                      width: 130,
                      label: const Center(
                          child: Text(
                        'اسم حساب العميل',
                        style: TextStyle(color: Colors.white),
                      ))),
                  GridColumn(
                      columnName: 'PriceRequestName',
                      label: const Center(
                          child: Text(
                        'اسم طلب السعر',
                        style: TextStyle(color: Colors.white),
                      ))),
                  GridColumn(
                      columnName: 'ProjectName',
                      label: const Center(
                          child: Text(
                        'اسم المشروع',
                        style: TextStyle(color: Colors.white),
                      ))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PurchaseOrdersDataSource extends DataGridSource {
  PurchaseOrdersDataSource({required List<DynamicList> purchaseOrdersList}) {
    _purchaseOrdersList = purchaseOrdersList
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<int>(
                  columnName: 'PurchaseRequestNumber', value: e.serialNumber),
              DataGridCell<String>(
                  columnName: 'dateOrder',
                  value: DateFormat('dd-MM-yyyy', 'en')
                      .format(DateTime.parse(e.requestDate!))),
              DataGridCell<String>(
                  columnName: 'date',
                  value: DateFormat('dd-MM-yyyy', 'en').format(DateTime.parse(e.date!))),
              DataGridCell<String>(columnName: 'note', value: e.note),
              DataGridCell<String>(columnName: 'employe', value: e.employeeNameA),
              DataGridCell<String>(columnName: 'name', value: e.sOMName),
              DataGridCell<String>(
                  columnName: 'CustomerAccountName', value: e.customerAccountName),
              DataGridCell<String>(columnName: 'PriceRequestName', value: e.oMName),
              DataGridCell<String>(columnName: 'ProjectName', value: e.projectName),
            ]))
        .toList();
  }

  List<DataGridRow> _purchaseOrdersList = [];

  @override
  List<DataGridRow> get rows => _purchaseOrdersList;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Center(
          child: Text(dataGridCell.value == null ? "" : dataGridCell.value.toString()));
    }).toList());
  }
}
