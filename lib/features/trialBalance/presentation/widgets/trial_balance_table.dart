import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../data/models/trial_balance_model.dart';

class TrialBalanceTable extends StatefulWidget {
  const TrialBalanceTable({super.key, required this.trialBalanceList});
  final List<TrialBalanceModel> trialBalanceList;

  @override
  State<TrialBalanceTable> createState() => _TrialBalanceTableState();
}

class _TrialBalanceTableState extends State<TrialBalanceTable> {
  late TrialBalanceDataSource trialBalanceDataSource;

  LinkedScrollControllerGroup controllerGroup = LinkedScrollControllerGroup();
  ScrollController? headerScrollController;
  ScrollController? dataScrollController;
  ScrollController? sumScrollController;
  final DataGridController dataGridController = DataGridController();
  TextEditingController controllerSearch = TextEditingController();
  TextEditingController controllerLevel = TextEditingController();
  @override
  void initState() {
    super.initState();
    headerScrollController = controllerGroup.addAndGet();
    dataScrollController = controllerGroup.addAndGet();
    sumScrollController = controllerGroup.addAndGet();
    trialBalanceDataSource = TrialBalanceDataSource(
      trialBalance: widget.trialBalanceList,
      controllerLevel: controllerLevel.text,
      controllerSearch: controllerSearch.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SfDataGridTheme(
          data: SfDataGridThemeData(
            headerColor: AppColors.blueLight,
            // selectionColor: AppColors.blueGreyDark,
            indentColumnWidth: 0,
            // gridLineColor: Colors.transparent,
          ),
          child: SfDataGrid(
            gridLinesVisibility: GridLinesVisibility.both,
            headerGridLinesVisibility: GridLinesVisibility.both,
            source: trialBalanceDataSource,
            headerRowHeight: 40,
            controller: dataGridController,
            rowHeight: 40,
            horizontalScrollController: dataScrollController,
            showHorizontalScrollbar: false,
            showVerticalScrollbar: false,
            columns: [
              GridColumn(
                columnName: 'acName',
                label: Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: CustomTextFormField(
                            hintText: 'search',
                            filled: true,
                            fillColor: Colors.white,
                            controller: controllerSearch,
                            onChanged: (value) {
                              setState(() {
                                trialBalanceDataSource = TrialBalanceDataSource(
                                  trialBalance: widget.trialBalanceList,
                                  controllerLevel: controllerLevel.text,
                                  controllerSearch: value,
                                );
                              });
                            },
                          ),
                        )),
                    Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: CustomTextFormField(
                            hintText: 'level',
                            filled: true,
                            fillColor: Colors.white,
                            controller: controllerLevel,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                trialBalanceDataSource = TrialBalanceDataSource(
                                  trialBalance: widget.trialBalanceList,
                                  controllerLevel: value,
                                  controllerSearch: controllerSearch.text,
                                );
                              });
                            },
                          ),
                        )),
                  ],
                ),
                width: 300,
              ),
              GridColumn(
                width: 120,
                columnName: 'depitBefor',
                label:
                    Center(child: Text('مدين', style: AppStyles.textStyle14)),
              ),
              GridColumn(
                width: 120,
                columnName: 'creditBefor',
                label:
                    Center(child: Text('دائن', style: AppStyles.textStyle14)),
              ),
              GridColumn(
                width: 120,
                columnName: 'depitMony',
                label:
                    Center(child: Text('مدين', style: AppStyles.textStyle14)),
              ),
              GridColumn(
                width: 120,
                columnName: 'creditMony',
                label:
                    Center(child: Text('دائن', style: AppStyles.textStyle14)),
              ),
              GridColumn(
                width: 120,
                columnName: 'depitSum',
                label:
                    Center(child: Text('مدين', style: AppStyles.textStyle14)),
              ),
              GridColumn(
                width: 120,
                columnName: 'creditSum',
                label:
                    Center(child: Text('دائن', style: AppStyles.textStyle14)),
              ),
              GridColumn(
                width: 120,
                columnName: 'depitAfter',
                label:
                    Center(child: Text('مدين', style: AppStyles.textStyle14)),
              ),
              GridColumn(
                width: 120,
                columnName: 'creditAfter',
                label:
                    Center(child: Text('دائن', style: AppStyles.textStyle14)),
              ),
            ],
            stackedHeaderRows: <StackedHeaderRow>[
              StackedHeaderRow(cells: [
                StackedHeaderCell(
                    columnNames: ['acName'],
                    child: Center(
                        child: Text('الحساب', style: AppStyles.textStyle14))),
                StackedHeaderCell(
                    columnNames: ['depitBefor', 'creditBefor'],
                    child: Center(
                        child: Text('الأرصدة الافتتاحية',
                            style: AppStyles.textStyle14))),
                StackedHeaderCell(
                    columnNames: ['depitMony', 'creditMony'],
                    child: Center(
                        child: Text('الحركة', style: AppStyles.textStyle14))),
                StackedHeaderCell(
                    columnNames: ['depitSum', 'creditSum'],
                    child: Center(
                        child: Text('مجاميع', style: AppStyles.textStyle14))),
                StackedHeaderCell(
                    columnNames: ['depitAfter', 'creditAfter'],
                    child: Center(
                        child: Text('الأرصدة الختامية',
                            style: AppStyles.textStyle14))),
              ])
            ],
            footerHeight: 45,
            footer: const SizedBox(
              height: 45,
            ),
          ),
        ),
        buildFooterTable(),
      ],
    );
  }

  Positioned buildFooterTable() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: sumScrollController,
        child: Row(
          children: [
            Container(
              width: 300,
              height: 45,
              color: AppColors.blueLight,
              child: Center(
                  child: Text(
                "الإجمالى",
                style: AppStyles.textStyle14,
              )),
            ),
            Container(
              width: 120,
              height: 45,
              color: AppColors.blueLight,
              child: Center(
                child: Text(
                  getSum(
                          listData: widget.trialBalanceList,
                          columnName: "depitBefor")
                      .toString(),
                  style: AppStyles.textStyle14,
                ),
              ),
            ),
            Container(
              width: 120,
              height: 45,
              color: AppColors.blueLight,
              child: Center(
                child: Text(
                  getSum(
                          listData: widget.trialBalanceList,
                          columnName: "creditBefor")
                      .toString(),
                  style: AppStyles.textStyle14,
                ),
              ),
            ),
            Container(
              width: 120,
              height: 45,
              color: AppColors.blueLight,
              child: Center(
                child: Text(
                  getSum(
                          listData: widget.trialBalanceList,
                          columnName: "depitMony")
                      .toString(),
                  style: AppStyles.textStyle14,
                ),
              ),
            ),
            Container(
              width: 120,
              height: 45,
              color: AppColors.blueLight,
              child: Center(
                child: Text(
                  getSum(
                          listData: widget.trialBalanceList,
                          columnName: "creditMony")
                      .toString(),
                  style: AppStyles.textStyle14,
                ),
              ),
            ),
            Container(
              width: 120,
              height: 45,
              color: AppColors.blueLight,
              child: Center(
                child: Text(
                  getSum(
                          listData: widget.trialBalanceList,
                          columnName: "depitSum")
                      .toString(),
                  style: AppStyles.textStyle14,
                ),
              ),
            ),
            Container(
              width: 120,
              height: 45,
              color: AppColors.blueLight,
              child: Center(
                child: Text(
                  getSum(
                          listData: widget.trialBalanceList,
                          columnName: "creditSum")
                      .toString(),
                  style: AppStyles.textStyle14,
                ),
              ),
            ),
            Container(
              width: 120,
              height: 45,
              color: AppColors.blueLight,
              child: Center(
                child: Text(
                  getSum(
                          listData: widget.trialBalanceList,
                          columnName: "depitAfter")
                      .toString(),
                  style: AppStyles.textStyle14,
                ),
              ),
            ),
            Container(
              width: 120,
              height: 45,
              color: AppColors.blueLight,
              child: Center(
                child: Text(
                  getSum(
                          listData: widget.trialBalanceList,
                          columnName: "creditAfter")
                      .toString(),
                  style: AppStyles.textStyle14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getSum(
      {required List<TrialBalanceModel> listData, required String columnName}) {
    switch (columnName) {
      case "depitBefor":
        double sum = 0;
        for (var item in listData) {
          sum = sum + (item.beforCorD == true ? item.beformony! : 0);
        }

        return double.parse(NumberFormat("#0.00").format(sum));
      case "creditBefor":
        double sum = 0;
        for (var item in listData) {
          sum = sum + (item.beforCorD == false ? item.beformony! : 0);
        }
        return double.parse(NumberFormat("#0.00").format(sum));
      case "depitMony":
        double sum = 0;
        for (var item in listData) {
          sum = sum + (item.depitmony!);
        }
        return double.parse(NumberFormat("#0.00").format(sum));
      case "creditMony":
        double sum = 0;
        for (var item in listData) {
          sum = sum + (item.creditmony!);
        }
        return double.parse(NumberFormat("#0.00").format(sum));
      case "depitSum":
        double sum = 0;
        for (var item in listData) {
          sum = sum +
              ((item.depitmony! +
                  (item.beforCorD == true ? item.beformony! : 0)));
        }
        return double.parse(NumberFormat("#0.00").format(sum));
      case "creditSum":
        double sum = 0;
        for (var item in listData) {
          sum = sum +
              ((item.depitmony! +
                  (item.beforCorD == false ? item.beformony! : 0)));
        }
        return double.parse(NumberFormat("#0.00").format(sum));
      case "depitAfter":
        double sum = 0;
        for (var item in listData) {
          sum = sum + (item.creditORDepit == true ? item.mony! : 0);
        }
        return double.parse(NumberFormat("#0.00").format(sum));
      case "creditAfter":
        double sum = 0;
        for (var item in listData) {
          sum = sum + (item.creditORDepit == false ? item.mony! : 0);
        }
        return double.parse(NumberFormat("#0.00").format(sum));
    }
  }
}

class TrialBalanceDataSource extends DataGridSource {
  final List<TrialBalanceModel> trialBalance;
  final String controllerLevel;
  final String controllerSearch;
  TrialBalanceDataSource({
    required this.trialBalance,
    required this.controllerLevel,
    required this.controllerSearch,
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
              DataGridCell<double>(
                  columnName: 'depitBefor',
                  value: dataGridRow.beforCorD == true
                      ? dataGridRow.beformony
                      : 0),
              DataGridCell<double>(
                  columnName: 'creditBefor',
                  value: dataGridRow.beforCorD == false
                      ? dataGridRow.beformony
                      : 0),
              DataGridCell<double>(
                  columnName: 'depitMony', value: dataGridRow.depitmony),
              DataGridCell<double>(
                  columnName: 'creditMony', value: dataGridRow.creditmony),
              DataGridCell<double>(
                  columnName: 'depitSum',
                  value: (dataGridRow.depitmony! +
                      (dataGridRow.beforCorD == true
                          ? dataGridRow.beformony!
                          : 0))),
              DataGridCell<double>(
                  columnName: 'creditSum',
                  value: (dataGridRow.creditmony! +
                      (dataGridRow.beforCorD == false
                          ? dataGridRow.beformony!
                          : 0))),
              DataGridCell<double>(
                  columnName: 'depitAfter',
                  value:
                      dataGridRow.creditORDepit == true ? dataGridRow.mony : 0),
              DataGridCell<double>(
                  columnName: 'creditAfter',
                  value: dataGridRow.creditORDepit == false
                      ? dataGridRow.mony
                      : 0),
            ]))
        .toList();
    // dataGridRows.add(DataGridRow(cells: [
    //   const DataGridCell<String>(columnName: 'acName', value: "الإجمالي"),
    //   DataGridCell<double>(
    //       columnName: 'depitBefor',
    //       value: getSum(
    //           listData: trialBalanceFinallyList, columnName: 'depitBefor')),
    //   DataGridCell<double>(
    //       columnName: 'creditBefor',
    //       value: getSum(
    //           listData: trialBalanceFinallyList, columnName: 'creditBefor')),
    //   DataGridCell<double>(
    //       columnName: 'depitMony',
    //       value: getSum(
    //           listData: trialBalanceFinallyList, columnName: 'depitMony')),
    //   DataGridCell<double>(
    //       columnName: 'creditMony',
    //       value: getSum(
    //           listData: trialBalanceFinallyList, columnName: 'creditMony')),
    //   DataGridCell<double>(
    //       columnName: 'depitSum',
    //       value: getSum(
    //           listData: trialBalanceFinallyList, columnName: 'depitSum')),
    //   DataGridCell<double>(
    //       columnName: 'creditSum',
    //       value: getSum(
    //           listData: trialBalanceFinallyList, columnName: 'creditSum')),
    //   DataGridCell<double>(
    //       columnName: 'depitAfter',
    //       value: getSum(
    //           listData: trialBalanceFinallyList, columnName: 'depitAfter')),
    //   DataGridCell<double>(
    //       columnName: 'creditAfter',
    //       value: getSum(
    //           listData: trialBalanceFinallyList, columnName: 'creditAfter')),
    // ]));
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

  // getSum(
  //     {required List<TrialBalanceModel> listData, required String columnName}) {
  //   switch (columnName) {
  //     case "depitBefor":
  //       double sum = 0;
  //       for (var item in listData) {
  //         sum = sum + (item.beforCorD == true ? item.beformony! : 0);
  //       }
  //
  //       return double.parse(NumberFormat("#0.00").format(sum));
  //     case "creditBefor":
  //       double sum = 0;
  //       for (var item in listData) {
  //         sum = sum + (item.beforCorD == false ? item.beformony! : 0);
  //       }
  //       return double.parse(NumberFormat("#0.00").format(sum));
  //     case "depitMony":
  //       double sum = 0;
  //       for (var item in listData) {
  //         sum = sum + (item.depitmony!);
  //       }
  //       return double.parse(NumberFormat("#0.00").format(sum));
  //     case "creditMony":
  //       double sum = 0;
  //       for (var item in listData) {
  //         sum = sum + (item.creditmony!);
  //       }
  //       return double.parse(NumberFormat("#0.00").format(sum));
  //     case "depitSum":
  //       double sum = 0;
  //       for (var item in listData) {
  //         sum = sum +
  //             ((item.depitmony! +
  //                 (item.beforCorD == true ? item.beformony! : 0)));
  //       }
  //       return double.parse(NumberFormat("#0.00").format(sum));
  //     case "creditSum":
  //       double sum = 0;
  //       for (var item in listData) {
  //         sum = sum +
  //             ((item.depitmony! +
  //                 (item.beforCorD == false ? item.beformony! : 0)));
  //       }
  //       return double.parse(NumberFormat("#0.00").format(sum));
  //     case "depitAfter":
  //       double sum = 0;
  //       for (var item in listData) {
  //         sum = sum + (item.creditORDepit == true ? item.mony! : 0);
  //       }
  //       return double.parse(NumberFormat("#0.00").format(sum));
  //     case "creditAfter":
  //       double sum = 0;
  //       for (var item in listData) {
  //         sum = sum + (item.creditORDepit == false ? item.mony! : 0);
  //       }
  //       return double.parse(NumberFormat("#0.00").format(sum));
  //   }
  // }
  //
  // Color getColor(String value) {
  //   int spacesCount = value.length - value.trimLeft().length;
  //   return const Color(0xFF1992D2)
  //       .withOpacity(((spacesCount / 5) + 1) / 10); // Output: 4
  // }
}
