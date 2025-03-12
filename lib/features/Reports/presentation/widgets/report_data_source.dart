import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/constants.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/all_dropdown_model.dart';
import '../../data/models/table_model.dart';
import '../views/reports_view.dart';
import 'build_report_alert_dialog.dart';
import 'table_reports_view_body.dart';

class ReportDataSource extends DataGridSource {
  final TableModel tableModel;
  final int numberPage;
  final int itemsInPage;
  final BuildContext context;
  final Pages pageData;
  final String title;

  ReportDataSource({
    required this.numberPage,
    required this.itemsInPage,
    required this.tableModel,
    required this.context,
    required this.pageData,
    required this.title,
  }) {
    int start = (numberPage - 1) * itemsInPage;
    int end = numberPage * itemsInPage;
    List allData = tableModel.dynamicList[0];
    List allDataShow = removeDuplicates(
        originalList: tableModel.dynamicList[0],
        keys: tableModel.listes.map((item) => item.columnName as String).toList());
    List dataShow =
        allDataShow.sublist(start, end > allDataShow.length ? allDataShow.length : end);
    for (Map<String, dynamic> i in dataShow) {
      dataGridRows.add(DataGridRow(cells: [
        ...List.generate(
          tableModel.listes.length,
          (index) {
            return DataGridCell<String>(
              // width: MediaQuery.of(context).size.width * .5 ,
              columnName: tableModel.listes[index].columnName!,
              value: getValue(
                      i[tableModel.listes[index].columnName], tableModel.listes[index])
                  .toString(),
            );
          },
        ),
        if (tableModel.data!.sowHSum == true)
          ...List.generate(
            tableModel.arabicLableAggrigate.length,
            (index) {
              String columnName = tableModel.arabicLableAggrigate[index].columnName!;
              return DataGridCell<double>(
                // width: MediaQuery.of(context).size.width * .5 ,
                columnName: columnName,
                value: getTotalH(
                  item: i,
                  dataList: allData,
                  typeValue: columnName,
                  keys:
                      tableModel.listes.map((item) => item.columnName as String).toList(),
                ),
              );
            },
          ),
        ...List.generate(
          tableModel.dynamicList[1].length * tableModel.arabicLableAggrigate.length,
          (index) {
            String columnName = getTitle(
                index: index,
                dynamicList: tableModel.dynamicList[1],
                arabicLableAggrigate: tableModel.arabicLableAggrigate);

            return DataGridCell<double>(
              columnName: columnName,
              value: getDataValue(
                index: index,
                item: i,
                dataList: allData,
                keys: tableModel.listes.map((item) => item.columnName as String).toList(),
                dynamicList: tableModel.dynamicList[1],
                arabicLableAggrigate: tableModel.arabicLableAggrigate,
              ),
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
      int indexColumn =
          getCellIndexInRow(dataGridRows[indexRow], dataGridCell.columnName);

      if (findParentColumnName(dataGridCell.columnName) == 'Total') {
        return Container(
          color: Colors.blue,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Center(
            child: GestureDetector(
              onTap: () {
                String myTailCondition = "and ${tableModel.data!.tailCondition} ";
                int start = (numberPage - 1) * itemsInPage;
                int end = numberPage * itemsInPage;
                List allDataShow = removeDuplicates(
                    originalList: tableModel.dynamicList[0],
                    keys: tableModel.listes
                        .map((item) => item.columnName as String)
                        .toList());
                List dataShow = allDataShow.sublist(
                    start, end > allDataShow.length ? allDataShow.length : end);
                var item = dataShow[indexRow];

                for (var j in tableModel.listes) {
                  String value = item[j.columnName];
                  myTailCondition = "$myTailCondition and ${j.columnName}=N'$value'";
                }

                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        "$title - ${tableModel.data!.reportName!}",
                        style: const TextStyle(fontSize: 14),
                      ),
                      content: BuildReportAlertDialog(
                        tableModel: tableModel,
                        tailCondition: myTailCondition,
                        pageData: pageData,
                      ),
                      contentPadding: const EdgeInsets.only(top: 12),
                      actions: [
                        TextButton(
                          onPressed: () {
                            GoRouter.of(context).pop();
                          },
                          child: Text(S.of(context).cancel),
                        ),
                      ],
                    );
                  },
                );
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
                dataGridCell.value,
                textAlign: TextAlign.center,
              ),
            ),
          );
        } else {
          return Container(
            color: indexColumn.isOdd ? null : Colors.blue[50],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    String myTailCondition =
                        "and ${tableModel.data!.tailCondition} and ${tableModel.data!.pivotRepeat}=N'${findParentColumnName(dataGridCell.columnName)}'";
                    int start = (numberPage - 1) * itemsInPage;
                    int end = numberPage * itemsInPage;
                    List allDataShow = removeDuplicates(
                        originalList: tableModel.dynamicList[0],
                        keys: tableModel.listes
                            .map((item) => item.columnName as String)
                            .toList());
                    List dataShow = allDataShow.sublist(
                        start, end > allDataShow.length ? allDataShow.length : end);
                    var item = dataShow[indexRow];

                    for (var j in tableModel.listes) {
                      String value = item[j.columnName];
                      myTailCondition = "$myTailCondition and ${j.columnName}=N'$value'";
                    }

                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            "$title - ${tableModel.data!.reportName!}",
                            style: const TextStyle(fontSize: 14),
                          ),
                          content: BuildReportAlertDialog(
                            tableModel: tableModel,
                            tailCondition: myTailCondition,
                            pageData: pageData,
                          ),
                          contentPadding: const EdgeInsets.only(top: 12),
                          actions: [
                            TextButton(
                              onPressed: () {
                                GoRouter.of(context).pop();
                              },
                              child: Text(S.of(context).cancel),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    dataGridCell.value == 0 ? "0.0" : dataGridCell.value.toString(),
                    textAlign: TextAlign.center,
                    style: AppStyles.textStyle14.copyWith(color: Colors.black),
                  ),
                ),
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
    double sum = 0;
    List allDataShow = removeDuplicates(
        originalList: tableModel.dynamicList[0],
        keys: tableModel.listes.map((item) => item.columnName as String).toList());

    if (tableModel.data!.sowHSum == true) {
      for (var i2 in allDataShow) {
        for (var i1 in tableModel.arabicLableAggrigate) {
          if (summaryColumn!.columnName == i1.columnName!) {
            sum = sum +
                getTotalH(
                  item: i2,
                  keys:
                      tableModel.listes.map((item) => item.columnName as String).toList(),
                  dataList: tableModel.dynamicList[0],
                  typeValue: i1.columnName!,
                );
          }
        }
      }
    }

    for (var i2 in allDataShow) {
      for (var i1 in tableModel.arabicLableAggrigate) {
        for (var i3 in tableModel.dynamicList[1]) {
          if (summaryColumn!.columnName ==
              "${i3['Coulumn']}$spaceBetweenWords${i1.columnName!}") {
            sum = sum +
                getTotalV(
                  item: i2,
                  keys:
                      tableModel.listes.map((item) => item.columnName as String).toList(),
                  dataList: tableModel.dynamicList[0],
                  typeValue: i1.columnName!,
                  keyToSum: i3['Coulumn'],
                );
          }
        }
      }
    }

    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          border: Border.symmetric(vertical: BorderSide(color: Colors.grey, width: .8))),
      padding: const EdgeInsets.all(5),
      // child: Text(NumberFormat('##0.00').format(double.parse(summaryValue))),
      child: GestureDetector(
          onTap: () {
            if (findParentColumnName(summaryColumn!.columnName) == 'Total') {
              String myTailCondition = "and ${tableModel.data!.tailCondition} ";

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      "$title - ${tableModel.data!.reportName!}",
                      style: const TextStyle(fontSize: 14),
                    ),
                    content: BuildReportAlertDialog(
                      tableModel: tableModel,
                      tailCondition: myTailCondition,
                      pageData: pageData,
                    ),
                    contentPadding: const EdgeInsets.only(top: 12),
                    actions: [
                      TextButton(
                        onPressed: () {
                          GoRouter.of(context).pop();
                        },
                        child: Text(S.of(context).cancel),
                      ),
                    ],
                  );
                },
              );
            } else {
              String myTailCondition =
                  "and ${tableModel.data!.tailCondition} and ${tableModel.data!.pivotRepeat}=N'${findParentColumnName(summaryColumn.columnName)}'";

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      "$title - ${tableModel.data!.reportName!}",
                      style: const TextStyle(fontSize: 14),
                    ),
                    content: BuildReportAlertDialog(
                      tableModel: tableModel,
                      tailCondition: myTailCondition,
                      pageData: pageData,
                    ),
                    contentPadding: const EdgeInsets.only(top: 12),
                    actions: [
                      TextButton(
                        onPressed: () {
                          GoRouter.of(context).pop();
                        },
                        child: Text(S.of(context).cancel),
                      ),
                    ],
                  );
                },
              );
            }
          },
          onLongPress: () {
            if (NumberFormat('##0.00').format(sum).isNotEmpty) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text(
                      NumberFormat('##0.00').format(sum),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              );
            }
          },
          child: Text(NumberFormat('##0.00').format(sum))),
    );
  }

  double getTotalH({
    required Map<String, dynamic> item,
    required List<dynamic> dataList,
    required List<String> keys,
    required String typeValue,
  }) {
    Map<String, dynamic> itemToSearch = getSubMap(
      originalMap: item,
      keys: keys,
    );
    itemToSearch['Type'] = typeValue;
    Map<String, dynamic>? myItem = searchForMapInList(
      listOfMaps: dataList,
      targetMap: itemToSearch,
    );

    // تحقق لو الـ Map فيها المفتاح Type وقيمته تساوي القيمة المطلوبة
    if (myItem!.containsKey("Type") && myItem["Type"] == typeValue) {
      // تصفية القيم من نوع double وجمعها
      double sum = myItem.values
          .whereType<double>()
          .fold(0.0, (previous, current) => previous + current);

      return sum;
    }

    return 0.0; // لو الشرط مش متحقق بيرجع صفر
  }

  double getTotalV({
    required Map<String, dynamic> item,
    required List<dynamic> dataList,
    required List<String> keys,
    required String typeValue,
    required String keyToSum,
  }) {
    Map<String, dynamic> itemToSearch = getSubMap(
      originalMap: item,
      keys: keys,
    );
    itemToSearch['Type'] = typeValue;
    Map<String, dynamic>? myItem = searchForMapInList(
      listOfMaps: dataList,
      targetMap: itemToSearch,
    );

    if (myItem != null && myItem.containsKey("Type") && myItem["Type"] == typeValue) {
      if (myItem.containsKey(keyToSum) && myItem[keyToSum] is double) {
        return myItem[keyToSum];
      }
    }

    return 0.0; // لو الشرط مش متحقق بيرجع صفر
  }

  double getTotal(Map<String, dynamic> data) {
    // تصفية القيم من نوع double فقط وجمعها
    double sum = data.values
        .whereType<double>() // تصفية القيم التي تكون من نوع double
        .fold(0.0, (previous, current) => previous + current); // جمع القيم

    return sum;
  }

  getValue(value, Liste listes) {
    if (listes.insertType == "dropdown") {
      if (value is String) {
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
    } else {
      return value;
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

  getTitle(
      {required int index,
      required List dynamicList,
      required List<ArabicLableAggrigate> arabicLableAggrigate}) {
    String title1 = dynamicList[(index ~/ arabicLableAggrigate.length)]['Coulumn'];
    String title2 =
        arabicLableAggrigate[(index % arabicLableAggrigate.length)].columnName!;
    return "$title1$spaceBetweenWords$title2";
  }

  List removeDuplicates({required List originalList, required List<String> keys}) {
    final uniqueItems = <String, Map<String, dynamic>>{};

    for (var item in originalList) {
      // نكوّن المفتاح بناءً على القيم لكل مفتاح موجود في القائمة keys
      String key = keys.map((k) => item[k].toString()).join('_');

      if (!uniqueItems.containsKey(key)) {
        uniqueItems[key] = item;
      }
    }

    return uniqueItems.values.toList();
  }

  getDataValue(
      {required int index,
      required Map<String, dynamic> item,
      required List<dynamic> dataList,
      required List dynamicList,
      required List<ArabicLableAggrigate> arabicLableAggrigate,
      required List<String> keys}) {
    Map<String, dynamic> itemToSearch = getSubMap(
      originalMap: item,
      keys: keys,
    );

    String title1 = dynamicList[(index ~/ arabicLableAggrigate.length)]['Coulumn'];
    String title2 =
        arabicLableAggrigate[(index % arabicLableAggrigate.length)].columnName!;
    itemToSearch['Type'] = title2;
    Map<String, dynamic>? myItem = searchForMapInList(
      listOfMaps: dataList,
      targetMap: itemToSearch,
    );
    return myItem![title1] ?? 0.0;
  }

  Map<String, dynamic> getSubMap(
      {required Map<String, dynamic> originalMap, required List<String> keys}) {
    // إنشاء خريطة جديدة تحتوي فقط على المفاتيح المطلوبة
    Map<String, dynamic> subMap = {};

    for (var key in keys) {
      if (originalMap.containsKey(key)) {
        subMap[key] = originalMap[key];
      }
    }

    return subMap;
  }

  Map<String, dynamic>? searchForMapInList(
      {required List<dynamic> listOfMaps, required Map<String, dynamic> targetMap}) {
    for (var map in listOfMaps) {
      // نتأكد أن كل مفتاح وقيمة في الـ targetMap موجودة في العنصر الحالي
      bool allMatch = targetMap.keys
          .every((key) => map.containsKey(key) && map[key] == targetMap[key]);

      if (allMatch) {
        return map; // رجّع الـ Map المتطابقة
      }
    }

    return null; // لو مفيش تطابق
  }

  String getFirstPart(String input) {
    if (input.contains(spaceBetweenWords)) {
      return input.split(spaceBetweenWords).first;
    }
    return input; // يرجع النص كامل لو لم يحتوي على "#$%^@"
  }

  findParentColumnName(String childColumnName) {
    final stackedHeaderRows = TableReportsViewBody.mySfDataGrid!.stackedHeaderRows;

    for (var row in stackedHeaderRows) {
      for (var cell in row.cells) {
        if (cell.columnNames.contains(childColumnName)) {
          // print('Parent Column Name: ${cell.child}');
          return cell.text;
        }
      }
    }
  }

  int getCellIndexInRow(DataGridRow row, String columnName) {
    return row.getCells().indexWhere((cell) => cell.columnName == columnName);
  }
}
