import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../data/models/general_balance_model.dart';

class GeneralBalanceDataSource extends DataGridSource {
  final List<GeneralBalanceModel> generalBalance;
  final String controllerLevel;
  GeneralBalanceDataSource({
    required this.generalBalance,
    required this.controllerLevel,
  }) {
    late List<GeneralBalanceModel> generalBalanceFinallyList;
    if (controllerLevel.isNotEmpty) {
      generalBalanceFinallyList = generalBalance
          .where((element) => element.level! <= int.parse(controllerLevel))
          .toList();
    } else {
      generalBalanceFinallyList = generalBalance;
    }
    for (var dataGridRow in generalBalanceFinallyList) {
      if (dataGridRow.creditORDepit == true) {
        dataGridRows.add(DataGridRow(cells: [
          DataGridCell<String>(
              columnName: 'description', value: getMyString(dataGridRow)),
          DataGridCell<double>(
              columnName: 'Mony',
              value: !(dataGridRow.level.toString() == controllerLevel ||
                      dataGridRow.isLast == true)
                  ? dataGridRow.mony
                  : 0),
          DataGridCell<double>(
              columnName: 'Subamount',
              value: (dataGridRow.level.toString() == controllerLevel ||
                      dataGridRow.isLast == true)
                  ? dataGridRow.mony
                  : 0),
        ]));
      }
    }

    if (getWin(generalBalance) - getLoss(generalBalance) < 0) {
      dataGridRows.add(DataGridRow(cells: [
        const DataGridCell<String>(
            columnName: 'description', value: "صافي الخسارة"),
        DataGridCell<double>(
            columnName: 'Mony',
            value: controllerLevel != "1"
                ? double.parse(NumberFormat("#0.00").format(
                    (getWin(generalBalance) - getLoss(generalBalance)) * -1))
                : 0),
        DataGridCell<double>(
            columnName: 'Subamount',
            value: controllerLevel == "1"
                ? double.parse(NumberFormat("#0.00").format(
                    (getWin(generalBalance) - getLoss(generalBalance)) * -1))
                : 0),
      ]));
    }
    dataGridRows.add(DataGridRow(cells: [
      const DataGridCell<String>(
          columnName: 'description', value: "إجمالى الأصول"),
      const DataGridCell<String>(columnName: 'Mony', value: ""),
      DataGridCell<String>(
          columnName: 'Subamount', value: "${getWin(generalBalance)}"),
    ]));

    for (var dataGridRow in generalBalanceFinallyList) {
      if (dataGridRow.creditORDepit != true) {
        dataGridRows.add(DataGridRow(cells: [
          DataGridCell<String>(
              columnName: 'description', value: getMyString(dataGridRow)),
          DataGridCell<double>(
              columnName: 'Mony',
              value: !(dataGridRow.level.toString() == controllerLevel ||
                      dataGridRow.isLast == true)
                  ? dataGridRow.mony
                  : 0),
          DataGridCell<double>(
              columnName: 'Subamount',
              value: (dataGridRow.level.toString() == controllerLevel ||
                      dataGridRow.isLast == true)
                  ? dataGridRow.mony
                  : 0),
        ]));
      }
    }
    if (getWin(generalBalance) - getLoss(generalBalance) > 0) {
      dataGridRows.add(DataGridRow(cells: [
        const DataGridCell<String>(
            columnName: 'description', value: "صافي الربح"),
        DataGridCell<double>(
            columnName: 'Mony',
            value: controllerLevel != "1"
                ? double.parse(NumberFormat("#0.00")
                    .format(getWin(generalBalance) - getLoss(generalBalance)))
                : 0),
        DataGridCell<double>(
            columnName: 'Subamount',
            value: controllerLevel == "1"
                ? double.parse(NumberFormat("#0.00")
                    .format(getWin(generalBalance) - getLoss(generalBalance)))
                : 0),
      ]));
    }
    dataGridRows.add(DataGridRow(cells: [
      const DataGridCell<String>(
          columnName: 'description', value: "إجمالى الخصوم"),
      const DataGridCell<String>(columnName: 'Mony', value: ""),
      DataGridCell<String>(
          columnName: 'Subamount', value: "${getWin(generalBalance)}"),
    ]));
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return dataGridCell.columnName == "description"
          ? Container(
              color: dataGridCell.value == "إجمالى الأصول" ||
                      dataGridCell.value == "إجمالى الخصوم"
                  ? Colors.lightBlueAccent
                  : null,
              alignment: AlignmentDirectional.centerStart,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  dataGridCell.value.toString(),
                ),
              ),
            )
          : Container(
              color: dataGridCell.value == "" ||
                      dataGridCell.value == "${getWin(generalBalance)}"
                  ? Colors.lightBlueAccent
                  : null,
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      dataGridCell.value.toString(),
                    ),
                  ),
                ),
              ),
            );
    }).toList());
  }

  getMyString(GeneralBalanceModel dataGridRow) {
    String levelSpace;
    int numberOfSpaces;
    for (int i = 1;; i++) {
      if (dataGridRow.level == i) {
        numberOfSpaces = (i - 1) * 5;
        levelSpace = ''.padLeft(numberOfSpaces, ' ');
        return "$levelSpace ${dataGridRow.description}";
      }
    }
  }

  getWin(List<GeneralBalanceModel> profit) {
    double sum = 0;
    for (var i in profit) {
      if (i.acParent == null && i.creditORDepit == true) {
        sum = sum + i.mony!;
      }
    }
    // return double.parse(NumberFormat("#0.00").format(sum));
    return sum;
  }

  getLoss(List<GeneralBalanceModel> profit) {
    double sum = 0;
    for (var i in profit) {
      if (i.acParent == null && i.creditORDepit != true) {
        sum = sum + i.mony!;
      }
    }
    // return double.parse(NumberFormat("#0.00").format(sum));
    return sum;
  }

  // getColor(int level) {
  //   switch (level) {
  //     case 1:
  //       return Colors.blue.shade900;
  //     case 2:
  //       return Colors.blue.shade800;
  //     case 3:
  //       return Colors.blue.shade700;
  //     case 4:
  //       return Colors.blue.shade600;
  //     case 5:
  //       return Colors.blue.shade500;
  //     case 6:
  //       return Colors.blue.shade400;
  //     case 7:
  //       return Colors.blue.shade300;
  //     case 8:
  //       return Colors.blue.shade200;
  //     case 9:
  //       return Colors.blue.shade100;
  //     case 10:
  //       return Colors.blue.shade50;
  //   }
  // }
  //
  // getLevel(String value) {
  //   for (var i in trialBalance) {
  //     if ("${i.acName} ${i.acIndex}" == value) {
  //       return i.level!;
  //     }
  //   }
  // }
}
