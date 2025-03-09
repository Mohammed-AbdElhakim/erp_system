import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../core/utils/app_strings.dart';
import '../../data/models/inventory_product_model.dart';

class InventoryProductDataSource extends DataGridSource {
  final List<InventoryProductModel> inventoryProduct;
  // final String controllerLevel;
  final String controllerSearch;
  final List<String> selectionItemsShow;
  InventoryProductDataSource({
    required this.inventoryProduct,
    // required this.controllerLevel,
    required this.controllerSearch,
    required this.selectionItemsShow,
  }) {
    late List<InventoryProductModel> inventoryProductFinallyList;
    if (controllerSearch.isEmpty) {
      inventoryProductFinallyList = inventoryProduct;
    } else if (controllerSearch.isNotEmpty) {
      inventoryProductFinallyList = inventoryProduct
          .where(
            (element) =>
                element.acName!.contains(controllerSearch) ||
                element.acIndex!.toString().contains(controllerSearch),
          )
          .toList();
    }

    dataGridRows = inventoryProductFinallyList
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'acName', value: dataGridRow.acName),
              if (selectionItemsShow.contains(AppStrings.openingBalances))
                DataGridCell<double>(
                    columnName: 'depitBefor',
                    value: dataGridRow.beforCorD == true ? dataGridRow.beformony : 0),
              if (selectionItemsShow.contains(AppStrings.openingBalances))
                DataGridCell<double>(
                    columnName: 'creditBefor',
                    value: dataGridRow.beforCorD == false ? dataGridRow.beformony : 0),
              if (selectionItemsShow.contains(AppStrings.movement))
                DataGridCell<double>(
                    columnName: 'depitMony', value: dataGridRow.depitmony),
              if (selectionItemsShow.contains(AppStrings.movement))
                DataGridCell<double>(
                    columnName: 'creditMony', value: dataGridRow.creditmony),
              if (selectionItemsShow.contains(AppStrings.totals))
                DataGridCell<double>(
                    columnName: 'depitSum',
                    value: (dataGridRow.depitmony! +
                        (dataGridRow.beforCorD == true ? dataGridRow.beformony! : 0))),
              if (selectionItemsShow.contains(AppStrings.totals))
                DataGridCell<double>(
                    columnName: 'creditSum',
                    value: (dataGridRow.creditmony! +
                        (dataGridRow.beforCorD == false ? dataGridRow.beformony! : 0))),
              if (selectionItemsShow.contains(AppStrings.closingBalances))
                DataGridCell<double>(
                    columnName: 'depitAfter',
                    value: dataGridRow.creditORDepit == true
                        ? dataGridRow.mony! > 0
                            ? dataGridRow.mony
                            : 0
                        : 0),
              if (selectionItemsShow.contains(AppStrings.closingBalances))
                DataGridCell<double>(
                    columnName: 'creditAfter',
                    value: dataGridRow.creditORDepit == true
                        ? dataGridRow.mony! < 0
                            ? dataGridRow.mony! * -1
                            : 0
                        : 0),
            ]))
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return dataGridCell.columnName == "acName"
          ? Container(
              alignment: AlignmentDirectional.centerStart,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  dataGridCell.value.toString(),
                  style: const TextStyle(color: Color(0xFF02009D)),
                ),
              ),
            )
          : Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    dataGridCell.value.toString(),
                  ),
                ),
              ),
            );
    }).toList());
  }
}
