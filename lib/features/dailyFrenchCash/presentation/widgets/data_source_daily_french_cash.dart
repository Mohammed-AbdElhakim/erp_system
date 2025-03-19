import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../data/models/daily_french_cash_model.dart';

class DataSourceDailyFrenchCash extends DataGridSource {
  final List<ListItem> dataList;
  final List<Columns> columns1;
  final List<Columns> columns2;
  final List<Total> totalEntry;
  final List<Total> totalAccount;
  final double totalAll;
  final List<Map<String, dynamic>> itemList;
  final DataGridController controller;
  final BuildContext context;

  DataSourceDailyFrenchCash({
    required this.dataList,
    required this.columns1,
    required this.columns2,
    required this.totalEntry,
    required this.itemList,
    required this.totalAccount,
    required this.totalAll,
    required this.controller,
    required this.context,
  }) {
    List<ListItem> list = [];
    for (ListItem obj1 in dataList) {
      bool exists = list.any((obj2) => obj2.eMasterID == obj1.eMasterID);
      if (!exists) {
        list.add(obj1);
      }
    }

    for (ListItem item in list) {
      dataGridRows.add(DataGridRow(cells: [
        DataGridCell<String>(
          columnName: "EDate",
          value: DateFormat('dd/MM/yyyy', "en")
              .format(DateTime.parse(item.eDate!).toLocal()),
        ),
        DataGridCell<String>(
          columnName: "EDescription",
          value: item.eDescription,
        ),
        DataGridCell<String>(
          columnName: "ETotal",
          value: totalEntry
              .firstWhere(
                (element) => element.key == item.eMasterID,
              )
              .total
              .toString(),
        ),
        ...List.generate(
          columns1.length,
          (index) {
            String name = columns1[index].acName!;
            int id = columns1[index].accountID!;

            bool columnCreditORDepit = columns1[index].creditORDepit!;
            String columnName = "$name $id $columnCreditORDepit";
            String nameRow = item.eDescription ?? "";
            int eMasterID = item.eMasterID!;

            return DataGridCell<double>(
              columnName: columnName,
              value: getValue(
                  columnName: columnName,
                  columnCreditORDepit: columnCreditORDepit,
                  name: name,
                  id: id,
                  nameRow: nameRow,
                  dataList: dataList,
                  eMasterID: eMasterID),
            );
          },
        ),
        const DataGridCell(columnName: "space", value: ""),
        ...List.generate(
          columns2.length,
          (index) {
            String name = columns2[index].acName!;
            int id = columns2[index].accountID!;

            bool columnCreditORDepit = columns2[index].creditORDepit!;
            String columnName = "$name $id $columnCreditORDepit";
            int eMasterID = item.eMasterID!;
            String nameRow = item.eDescription ?? "";

            return DataGridCell<double>(
              columnName: columnName,
              value: getValue(
                  columnName: columnName,
                  columnCreditORDepit: columnCreditORDepit,
                  name: name,
                  id: id,
                  nameRow: nameRow,
                  dataList: dataList,
                  eMasterID: eMasterID),
            );
          },
        ),
      ]));
    }
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      int indexRow = dataGridRows.indexOf(row);
      // int indexColumn =
      //     getCellIndexInRow(dataGridRows[indexRow], dataGridCell.columnName);

      bool isSelected = controller.selectedIndex == indexRow;
      return Container(
        decoration: BoxDecoration(
          color: dataGridCell.columnName == "ETotal"
              ? isSelected
                  ? Colors.transparent
                  : Colors.blue.shade50
              : dataGridCell.columnName.contains("space")
                  ? Colors.grey.shade300
                  : Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Center(
            child: Text(
              dataGridCell.value == null ? "" : dataGridCell.value.toString(),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }).toList());
  }

  @override
  Widget? buildTableSummaryCellWidget(
      GridTableSummaryRow summaryRow,
      GridSummaryColumn? summaryColumn,
      RowColumnIndex rowColumnIndex,
      String summaryValue) {
    String columnName = summaryColumn!.columnName;
    double value = columnName == "ETotal"
        ? totalAll
        : getValueSummary(
            columnName: columnName,
            totalAccount: totalAccount,
          );
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border:
            const Border.symmetric(vertical: BorderSide(color: Colors.grey, width: .8)),
        color: columnName == "space" ? Colors.grey.shade300 : Colors.blue,
      ),
      padding: const EdgeInsets.all(5),
      child: GestureDetector(
          onLongPress: () {
            if (value != 0.0) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text(
                      NumberFormat('##0.00').format(value),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              );
            }
          },
          child: Text(columnName == "EDescription"
              ? "الإجمالي"
              : value == 0.0
                  ? ""
                  : NumberFormat('##0.00').format(value))),
    );
  }

  int getCellIndexInRow(DataGridRow row, String columnName) {
    return row.getCells().indexWhere((cell) => cell.columnName == columnName);
  }

  getValue({
    required String columnName,
    required bool columnCreditORDepit,
    required String name,
    required String nameRow,
    required int id,
    required int eMasterID,
    required List<ListItem> dataList,
  }) {
    List<ListItem> itemList = dataList
        .where((element) =>
            element.eMasterID == eMasterID && element.eDescription == nameRow)
        .toList();
    ListItem? item = itemList.firstWhere(
      (element) =>
          element.acName == name &&
          element.accountID == id &&
          element.creditORDepit == columnCreditORDepit,
      orElse: () => ListItem(),
    );

    return item.mony;
  }

  double getValueSummary(
      {required String columnName, required List<Total> totalAccount}) {
    for (var i in totalAccount) {
      if (columnName.contains("${i.key}")) {
        return i.total!;
      } else if (columnName == "space") {
        return 0.0;
      }
    }
    return 0.0;
  }
}
