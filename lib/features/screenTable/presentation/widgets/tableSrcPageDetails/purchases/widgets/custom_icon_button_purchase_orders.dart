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
import '../models/purchase_orders_model.dart';
import '../models/purchase_request_detail_model.dart';

typedef OnTapAdd<T> = void Function(T data);

class CustomIconButtonPurchaseOrders extends StatefulWidget {
  const CustomIconButtonPurchaseOrders({super.key, required this.onTapAdd});

  final OnTapAdd<List<Map<String, dynamic>>> onTapAdd;
  @override
  State<CustomIconButtonPurchaseOrders> createState() =>
      _CustomIconButtonPurchaseOrdersState();
}

class _CustomIconButtonPurchaseOrdersState extends State<CustomIconButtonPurchaseOrders> {
  late PurchaseRequestDetailModel purchaseRequestDetailModel;
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
                      "tableName": "purchaseRequestAdded",
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
                        PurchaseOrdersModel purchaseOrdersModel =
                            PurchaseOrdersModel.fromJson(state.data);
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
                                      data.add({
                                        "ProductID": item.productId,
                                        "project": item.projectId,
                                        // "ItemsTreeId": item.,
                                        // "MaintemTreeId":item.,
                                        "UnitID": item.unitID,
                                        // "SecUnit":item.,
                                        "Quntity": item.quntity,
                                        // "CostCurrancy":item.,
                                        "Total": item.totalCost,
                                        "SecQuntity": item.secQuntity,
                                        "Cost": item.cost,
                                        // "PriceAfterDiscount":item.,
                                        "length": item.length,
                                      });
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
          "tableName": "purchaseRequestDetailView",
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
            PurchaseRequestDetailModel.fromJson(purchaseRequestDetail);
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
