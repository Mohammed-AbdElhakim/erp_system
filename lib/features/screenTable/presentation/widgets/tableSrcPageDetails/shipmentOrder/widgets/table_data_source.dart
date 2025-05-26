import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../models/bills_data_model.dart';

class TableDataSource extends DataGridSource {
  // final List<BillsHeaderModel> listColumn;
  final BuildContext context;
  final List<BillsDataModel> data;

  // final Pages pageData;
  // final List<AllDropdownModel> allDropdownModelList;
  // final List<dynamic>? listSum;
  TableDataSource({
    // required this.listColumn,
    required this.context,
    required this.data,
    // required this.pageData,
    // required this.allDropdownModelList,
    // required this.listSum,
  }) {
    dataGridRows = data.map<DataGridRow>((e) {
      return DataGridRow(cells: [
        DataGridCell<int>(columnName: "ContractID", value: e.contractID),
        DataGridCell<String>(columnName: "AutoNumber", value: "${e.autoNumber ?? ""}"),
        DataGridCell<String>(columnName: "CustomerAccountName", value: e.customerAccountName ?? ""),
        DataGridCell<String>(columnName: "TotalOrder", value: "${e.totalOrder ?? ""}"),
        DataGridCell<String>(columnName: "ContractQuantity", value: "${e.contractQuantity ?? ""}"),
        DataGridCell<String>(columnName: "shippingPrice", value: "${e.shippingPrice ?? ""}"),
        DataGridCell<String>(columnName: "Phone2", value: e.phone2 ?? ""),
        DataGridCell<String>(columnName: "CustomerAccountAddress", value: e.customerAccountAddress ?? ""),
        DataGridCell<String>(columnName: "AreaName", value: e.areaName ?? ""),
        DataGridCell<String>(columnName: "GovName", value: e.govName ?? ""),
      ]);
    }).toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    // int indexRow = dataGridRows.indexOf(row);
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        child: Text(
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          e.value.toString(),
        ),
      );
    }).toList());
  }

// getValue({required List<ColumnList> listColumn, key, required String value}) {
//   ColumnList columnList = listColumn.firstWhere((element) => (element.columnName == key));
//   if (columnList.insertType == "date") {
//     String date = value.isNotEmpty ? DateFormat("yyyy-MM-dd", "en").format(DateTime.parse(value).toLocal()) : '';
//     return date;
//   } else if (columnList.insertType == "dateTime") {
//     String date = value.isNotEmpty ? DateFormat('yyyy/MM/dd hh:mm a', "en").format(DateTime.parse(value).toLocal()) : '';
//     return date;
//   } else if (columnList.insertType == "dropdown") {
//     String val = '';
//     if (columnList.columnName == columnList.searchName) {
//       List<ListDrop>? listDrop = [];
//       List<ItemDrop>? myListDrop = [];
//       for (var item in allDropdownModelList) {
//         if (item.listName == pageData.listName) {
//           listDrop = item.list;
//         }
//       }
//
//       for (var item in listDrop!) {
//         if (item.columnName == columnList.columnName && item.nameAr == columnList.arColumnLabel) {
//           myListDrop = item.list;
//         }
//       }
//       for (var item in myListDrop!) {
//         if (item.id.toString() == value) {
//           val = item.text ?? "";
//         }
//       }
//     } else {
//       val = value;
//     }
//     return val;
//   } else {
//     return value;
//   }
// }
}
