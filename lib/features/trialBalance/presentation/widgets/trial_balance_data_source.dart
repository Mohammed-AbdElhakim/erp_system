import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../core/utils/app_strings.dart';
import '../../data/models/trial_balance_model.dart';

class TrialBalanceDataSource extends DataGridSource {
  final List<TrialBalanceModel> trialBalance;
  final String controllerLevel;
  final String controllerSearch;
  final List<String> selectionItemsShow;
  TrialBalanceDataSource({
    required this.trialBalance,
    required this.controllerLevel,
    required this.controllerSearch,
    required this.selectionItemsShow,
  }) {
    late List<TrialBalanceModel> trialBalanceFinallyList;
    if (controllerSearch.isEmpty && controllerLevel.isEmpty) {
      trialBalanceFinallyList = trialBalance;
    } else if (controllerSearch.isNotEmpty && controllerLevel.isNotEmpty) {
      trialBalanceFinallyList = trialBalance
          .where(
            (element) =>
                (element.acName!.contains(controllerSearch) ||
                    element.acIndex!.contains(controllerSearch)) &&
                element.level! <= int.parse(controllerLevel),
          )
          .toList();
    } else if (controllerSearch.isNotEmpty) {
      trialBalanceFinallyList = trialBalance
          .where(
            (element) =>
                element.acName!.contains(controllerSearch) ||
                element.acIndex!.contains(controllerSearch),
          )
          .toList();
    } else if (controllerLevel.isNotEmpty) {
      trialBalanceFinallyList = trialBalance
          .where((element) => element.level! <= int.parse(controllerLevel))
          .toList();
    }

    dataGridRows = trialBalanceFinallyList
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'acName', value: getMyString(dataGridRow)),
              if (selectionItemsShow.contains(AppStrings.openingBalances))
                DataGridCell<double>(
                    columnName: 'depitBefor',
                    value: dataGridRow.beforCorD == true
                        ? dataGridRow.beformony
                        : 0),
              if (selectionItemsShow.contains(AppStrings.openingBalances))
                DataGridCell<double>(
                    columnName: 'creditBefor',
                    value: dataGridRow.beforCorD == false
                        ? dataGridRow.beformony
                        : 0),
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
                        (dataGridRow.beforCorD == true
                            ? dataGridRow.beformony!
                            : 0))),
              if (selectionItemsShow.contains(AppStrings.totals))
                DataGridCell<double>(
                    columnName: 'creditSum',
                    value: (dataGridRow.creditmony! +
                        (dataGridRow.beforCorD == false
                            ? dataGridRow.beformony!
                            : 0))),
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

  getMyString(TrialBalanceModel dataGridRow) {
    String levelSpace;
    int numberOfSpaces;
    for (int i = 1;; i++) {
      if (dataGridRow.level == i) {
        numberOfSpaces = (i - 1) * 3;
        levelSpace = ''.padLeft(numberOfSpaces, ' ');
        return "$levelSpace ${dataGridRow.acName} ${dataGridRow.acIndex}";
      }
    }
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
