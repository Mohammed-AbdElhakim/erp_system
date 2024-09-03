import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../core/utils/app_styles.dart';
import '../../data/models/all_dropdown_model.dart';
import '../../data/models/table_model.dart';
import '../views/reports_view.dart';

class ReportDataSource extends DataGridSource {
  final TableModel tableModel;
  final int numberPage;
  final int itemsInPage;

  ReportDataSource(
      {required this.numberPage,
      required this.itemsInPage,
      required this.tableModel}) {
    int start = (numberPage - 1) * itemsInPage;
    int end = numberPage * itemsInPage;
    List allData = tableModel.dynamicList![0];
    List dataShow =
        allData.sublist(start, end > allData.length ? allData.length : end);
    for (Map<String, dynamic> i in dataShow) {
      dataGridRows.add(DataGridRow(cells: [
        ...List.generate(
          tableModel.listes!.length,
          (index) {
            return DataGridCell<String>(
              // width: MediaQuery.of(context).size.width * .5 ,
              columnName: tableModel.listes![index].columnName!,
              value: getValue(i[tableModel.listes![index].columnName],
                  tableModel.listes![index]),
            );
          },
        ),
        DataGridCell<double>(
          // width: MediaQuery.of(context).size.width * .5 ,
          columnName: "total",
          value: getTotal(i),
        ),
        ...List.generate(
          tableModel.dynamicList![1].length,
          (index) {
            return DataGridCell<double>(
              columnName: tableModel.dynamicList![1][index]['Coulumn'],
              value: (i[tableModel.dynamicList![1][index]['Coulumn']]) ?? 0,
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

      if (dataGridCell.columnName == 'total') {
        return Container(
          color: Colors.blue,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Center(
            child: GestureDetector(
              onTap: () {
                print("=========================");
                print(dataGridCell.value.toString());
              },
              child: Text(
                dataGridCell.value.toString(),
              ),
            ),
          ),
        );
      } else {
        if (dataGridCell.value is String) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Center(
              child: Text(
                dataGridCell.value.toString(),
                textAlign: TextAlign.center,
              ),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      print("=========================");
                      print(dataGridCell.value.toString());
                    },
                    child: Text(
                      dataGridCell.value == 0
                          ? ""
                          : dataGridCell.value.toString(),
                      textAlign: TextAlign.center,
                      style:
                          AppStyles.textStyle14.copyWith(color: Colors.black),
                    ),
                  ),
                  if (dataGridCell.value != 0 &&
                      dataGridCell.value > 0 &&
                      ((dataGridCell.value /
                                  getTotal(
                                      tableModel.dynamicList![0][indexRow])) *
                              100) >
                          0)
                    Stack(
                      children: [
                        SizedBox(
                          width: 100,
                          child: LinearProgressIndicator(
                            value: dataGridCell.value /
                                getTotal(tableModel.dynamicList![0]
                                    [indexRow]), // قيمة التقدم (نسبة مئوية)
                            minHeight: 10.0,
                            backgroundColor: Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation<Color>(getColor(
                                (dataGridCell.value /
                                        getTotal(tableModel.dynamicList![0]
                                            [indexRow])) *
                                    100)),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        Positioned.fill(
                          child: Center(
                            child: Text(
                              "${NumberFormat('##0.00').format((dataGridCell.value / getTotal(tableModel.dynamicList![0][indexRow])) * 100)} %",
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                        )
                      ],
                    ),
                ],
              ),
            ),
          );
        }
      }
    }).toList());
  }

  @override
  Widget? buildTableSummaryCellWidget(
      GridTableSummaryRow summaryRow,
      GridSummaryColumn? summaryColumn,
      RowColumnIndex rowColumnIndex,
      String summaryValue) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          border: Border.symmetric(
              vertical: BorderSide(color: Colors.grey, width: .8))),
      padding: const EdgeInsets.all(5),
      child: Text(NumberFormat('##0.00').format(double.parse(summaryValue))),
    );
  }

  double getTotal(Map<String, dynamic> data) {
    // تصفية القيم من نوع double فقط وجمعها
    double sum = data.values
        .whereType<double>() // تصفية القيم التي تكون من نوع double
        .fold(0.0, (previous, current) => previous + current); // جمع القيم

    return sum;
  }

  getValue(value, Listes listes) {
    if (value is String) {
      // if (listes.columnName != listes.searchName) {
      return value;
    } else if (value is int) {
      // } else if (listes.columnName == listes.searchName) {
      List<ListDrop>? listDrop;
      List<ItemDrop>? list;
      String? valueDrop;
      for (var i in ReportsView.myAllDropdownModelList) {
        if (i.listName == listes.listName) {
          listDrop = i.list;
        }
      }
      for (var i in listDrop!) {
        if (i.columnName == listes.columnName) {
          list = i.list;
        }
      }
      for (var i in list!) {
        if (i.id == value.toString()) {
          valueDrop = i.text;
        }
      }

      return valueDrop;
    }
  }

  Color getColor(double format) {
    double value = format;
    if (value >= 70 && value <= 100) {
      return Colors.green;
    } else if (value >= 30 && value < 70) {
      return Colors.blue;
    } else if (value >= 0 && value < 30) {
      return Colors.red;
    } else {
      return Colors.grey;
    }
  }
}
