import 'package:erp_system/core/utils/methods.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';

class BuildTablesCard extends StatefulWidget {
  const BuildTablesCard({
    super.key,
    required this.tableName,
    required this.columnList,
    required this.dataList,
  });
  final String tableName;
  final List<Map<String, dynamic>> columnList;
  final List<Map<String, dynamic>> dataList;

  @override
  State<BuildTablesCard> createState() => _BuildTablesCardState();
}

class _BuildTablesCardState extends State<BuildTablesCard> {
  /* final DataGridController dataGridController = DataGridController();

  late TableDataSource tableDataSource;

  ScrollController verticalScrollController = ScrollController();
  ScrollController horizontalScrollController = ScrollController();*/

  int selectedRowIndex = -1;

  String? lang;

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  /* @override
  void initState() {
    tableDataSource = TableDataSource(
      data: widget.dataList,
      context: context,
      listColumn: widget.columnList,
    );
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    double containerWidth = widget.columnList.length * 120;
    return Container(
      width: containerWidth,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(10), topEnd: Radius.circular(10)),
          border: Border.all(
            color: Colors.blueGrey,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 45,
            padding: const EdgeInsets.only(left: 16, right: 16),
            decoration: const BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(10), topEnd: Radius.circular(10)),
              color: Colors.blueGrey,
            ),
            child: Center(
              child: Text(
                widget.tableName,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          //Header Table
          Container(
            color: AppColors.blueLight,
            height: 35,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                widget.columnList.length,
                (index) => Expanded(
                  child: InkWell(
                    onLongPress: () {
                      final String text = lang == AppStrings.enLangKey
                          ? widget.columnList[index]["enColumnLabel"]
                          : widget.columnList[index]["arColumnLabel"];

                      if (text.isNotEmpty) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text(
                                text,
                                textAlign: TextAlign.center,
                              ),
                            );
                          },
                        );
                      }
                    },
                    child: Container(
                      height: 35,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey.shade300, width: .5)),
                      child: Text(
                        lang == AppStrings.enLangKey
                            ? widget.columnList[index]["enColumnLabel"]
                            : widget.columnList[index]["arColumnLabel"],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          //Body Table
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      ...widget.dataList.asMap().entries.map(
                        (entry) {
                          final int rowIndex = entry.key;
                          final Map<String, dynamic> row = entry.value;

                          return Row(
                            children: List.generate(
                              widget.columnList.length,
                              (index) => Expanded(
                                child: InkWell(
                                  onTap: () {
                                    if (selectedRowIndex == rowIndex) {
                                      setState(() {
                                        selectedRowIndex = -1;
                                      });
                                    } else {
                                      setState(() {
                                        selectedRowIndex = rowIndex;
                                      });
                                    }
                                  },
                                  onLongPress: () {
                                    final String text = getText(
                                      row["${widget.columnList[index]['ColumnName']}"] ??
                                          "",
                                      widget.columnList[index],
                                    );

                                    if (text.isNotEmpty) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            content: Text(
                                              text,
                                              textAlign: TextAlign.center,
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  },
                                  child: Container(
                                    height: 35,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: selectedRowIndex == rowIndex
                                          ? colorWithOpacity(
                                              color: AppColors.blueGreyDark,
                                              opacity: .8)
                                          : (rowIndex % 2 == 0
                                              ? Colors.white
                                              : Colors.white),
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                        width: .5,
                                      ),
                                    ),
                                    child: Text(
                                      getText(
                                        row["${widget.columnList[index]['ColumnName']}"] ??
                                            "",
                                        widget.columnList[index],
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
    /*return Column(
      children: [
        Container(
          // width: double.infinity,
          height: 45,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            color: AppColors.blueLight,
          ),
          child: Center(
            child: Text(
              widget.tableName,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: SfDataGridTheme(
            data: SfDataGridThemeData(
              gridLineColor: Colors.grey.shade300,
              // gridLineStrokeWidth: 1,
              headerColor: AppColors.blueLight,
              selectionColor: AppColors.blueGreyDark,
              // indentColumnWidth: 0,
            ),
            child: SfDataGrid(
              source: tableDataSource,
              headerRowHeight: 35,
              rowHeight: 35,
              controller: dataGridController,
              // showHorizontalScrollbar: false,
              // showVerticalScrollbar: false,
              selectionMode: SelectionMode.singleDeselect,
              // verticalScrollController: verticalScrollController,
              // horizontalScrollController: horizontalScrollController,
              gridLinesVisibility: GridLinesVisibility.both,
              headerGridLinesVisibility: GridLinesVisibility.both,
              columnWidthMode: ColumnWidthMode.fitByCellValue,
              isScrollbarAlwaysShown: true,

              autoExpandGroups: false,
              columns: [
                ...List.generate(
                  widget.columnList.length,
                  (index) => GridColumn(
                    // minimumWidth: 120,
                    // maximumWidth: 320,
                    columnName: widget.columnList[index]['ColumnName']!,
                    label: Center(
                      child: Text(
                        lang == AppStrings.enLangKey
                            ? widget.columnList[index]['enColumnLabel']!
                            : widget.columnList[index]['arColumnLabel']!,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
              onCellLongPress: (DataGridCellLongPressDetails details) {
                final String text = tableDataSource
                    .effectiveRows[details.rowColumnIndex.rowIndex - 1]
                    .getCells()[details.rowColumnIndex.columnIndex]
                    .value;

                if (text.isNotEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text(
                          text,
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),
      ],
    );*/
  }

  String getText(value, Map<String, dynamic> columnList) {
    if (columnList['ColumnType'] == "date") {
      String date = value.isNotEmpty
          ? DateFormat("yyyy-MM-dd", "en")
              .format(DateTime.parse(value).toLocal())
          : '';
      return date;
    } else if (columnList['ColumnType'] == "dateTime") {
      String date = value.isNotEmpty
          ? DateFormat('yyyy/MM/dd   hh:mm a', "en")
              .format(DateTime.parse(value).toLocal())
          : '';
      return date;
    } else {
      return value;
    }
  }
}

/*class TableDataSource extends DataGridSource {
  final List<Map<String, dynamic>> listColumn;
  final BuildContext context;
  final List<Map<String, dynamic>> data;
  TableDataSource({
    required this.listColumn,
    required this.context,
    required this.data,
  }) {
    dataGridRows = data.map<DataGridRow>((e) {
      return DataGridRow(cells: [
        ...List.generate(
          listColumn.length,
          (index) => DataGridCell(
              columnName: listColumn[index]['ColumnName']!,
              value: getValue(listColumn, listColumn[index]['ColumnName']!,
                  "${e[listColumn[index]['ColumnName']!] ?? ""}")),
          // columnName: listHeader[index], value: "${e[keys[index]] ?? ""}"),
        )
      ]);
    }).toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      int indexRow = dataGridRows.indexOf(row);
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        child: Text(e.value.toString()),
      );
    }).toList());
  }

  getValue(List<Map<String, dynamic>> listColumn, key, String value) {
    Map<String, dynamic> columnList =
        listColumn.firstWhere((element) => (element['ColumnName'] == key));
    if (columnList['ColumnType'] == "date") {
      String date = value.isNotEmpty
          ? DateFormat("yyyy-MM-dd", "en")
              .format(DateTime.parse(value).toLocal())
          : '';
      return date;
    } else if (columnList['ColumnType'] == "dateTime") {
      String date = value.isNotEmpty
          ? DateFormat('yyyy/MM/dd   hh:mm a', "en")
              .format(DateTime.parse(value).toLocal())
          : '';
      return date;
    } else {
      return value;
    }
  }
}*/
