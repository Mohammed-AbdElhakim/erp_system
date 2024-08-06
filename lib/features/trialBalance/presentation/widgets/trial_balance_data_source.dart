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
                        ? dataGridRow.mony
                        : 0),
              if (selectionItemsShow.contains(AppStrings.closingBalances))
                DataGridCell<double>(
                    columnName: 'creditAfter',
                    value: dataGridRow.creditORDepit == false
                        ? dataGridRow.mony
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
              // color: getColor(dataGridCell.value),
              child: Text(
                dataGridCell.value.toString(),
                style: const TextStyle(color: Color(0xFF02009D)),
              ),
            )
          : Center(
              child: Text(
                dataGridCell.value.toString(),
              ),
            );
    }).toList());
  }

  getMyString(TrialBalanceModel dataGridRow) {
    String levelSpace;
    int numberOfSpaces;
    for (int i = 1;; i++) {
      if (dataGridRow.level == i) {
        numberOfSpaces = (i - 1) * 5;
        levelSpace = ''.padLeft(numberOfSpaces, ' ');
        return "$levelSpace ${dataGridRow.acName} ${dataGridRow.acIndex}";
      }
    }
  }
}
