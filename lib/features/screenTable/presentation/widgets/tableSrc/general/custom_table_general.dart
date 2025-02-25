import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../../core/models/menu_model/pages.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_router.dart';
import '../../../../data/models/dropdown_model/all_dropdown_model.dart';
import '../../../../data/models/passData/pass_data_details_row.dart';
import '../../../../data/models/screen_model.dart';

typedef OnTapHeader<String> = void Function(String titleHeader);
typedef OnTapRow<T> = void Function(T rowData);

class CustomTableGeneral extends StatefulWidget {
  const CustomTableGeneral({
    super.key,
    required this.listData,
    required this.paginationWidget,
    required this.onTapHeader,
    required this.listColumn,
    required this.onTapRow,
    this.listSum,
    required this.allDropdownModelList,
    required this.pageData,
  });
  final Pages pageData;
  final List<dynamic> listData;
  final List<dynamic>? listSum;
  final List<ColumnList> listColumn;
  final List<AllDropdownModel> allDropdownModelList;
  final Widget paginationWidget;
  final OnTapHeader<String> onTapHeader;
  final OnTapRow<List<Map<String, dynamic>>> onTapRow;

  @override
  State<CustomTableGeneral> createState() => _CustomTableGeneralState();
}

class _CustomTableGeneralState extends State<CustomTableGeneral> {
  LinkedScrollControllerGroup controllerGroup = LinkedScrollControllerGroup();
  ScrollController? headerScrollController;
  ScrollController? dataScrollController;
  ScrollController? sumScrollController;
  final DataGridController dataGridController = DataGridController();
  // int? indexColorRow;
  List<bool> selectedRows = [];
  List<Map<String, dynamic>> rowsData = [];
  late TableDataSource tableDataSource;

  ScrollController verticalScrollController = ScrollController();
  ScrollController horizontalScrollController = ScrollController();
  @override
  void initState() {
    headerScrollController = controllerGroup.addAndGet();
    dataScrollController = controllerGroup.addAndGet();
    sumScrollController = controllerGroup.addAndGet();
    for (int i = 0; i < widget.listData.length; i++) {
      selectedRows.add(false); // Initialize selectedRows with false
    }

    tableDataSource = TableDataSource(
      data: widget.listData,
      pageData: widget.pageData,
      context: context,
      listColumn: widget.listColumn,
      allDropdownModelList: widget.allDropdownModelList,
      listSum: widget.listSum,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
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
                selectionMode: SelectionMode.multiple,
                showCheckboxColumn: true,
                verticalScrollController: verticalScrollController,
                horizontalScrollController: horizontalScrollController,
                gridLinesVisibility: GridLinesVisibility.both,
                headerGridLinesVisibility: GridLinesVisibility.both,
                columnWidthMode: ColumnWidthMode.auto,
                isScrollbarAlwaysShown: true,
                checkboxColumnSettings: const DataGridCheckboxColumnSettings(
                  showCheckboxOnHeader: false,
                  width: 35,
                ),
                onSelectionChanged: (addedRows, removedRows) {
                  rowsData.clear();
                  var selectedRows = dataGridController.selectedRows;

                  for (var row in selectedRows) {
                    Map<String, dynamic> mapData = {};
                    row.getCells().forEach((element) {
                      if (element.value != "Icon(Icons.add)") {
                        if (element.value != "") {
                          setState(() {
                            mapData[element.columnName] = element.value;
                          });
                        }
                      }
                    });
                    rowsData.add(mapData);
                  }
                  widget.onTapRow(rowsData);
                },

                autoExpandGroups: false,
                columns: [
                  if (widget.pageData.master == true)
                    GridColumn(
                      width: 30,
                      columnName: "icon",
                      label: const Text(""),
                    ),
                  GridColumn(
                    width: 0,
                    columnName: widget.pageData.primary,
                    label: const Center(child: Text("id")),
                  ),
                  ...List.generate(
                    widget.listColumn.length,
                    (index) => GridColumn(
                      minimumWidth: 90,
                      maximumWidth: 150,
                      columnName: widget.listColumn[index].columnName!,
                      label: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: InkWell(
                          onTap: () {
                            widget.onTapHeader(
                                widget.listColumn[index].columnName!);
                          },
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text(
                                    widget.listColumn[index].arColumnLabel!,
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              },
                            );
                          },
                          child: Center(
                            child: Text(
                              widget.listColumn[index].arColumnLabel!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      visible: widget.listColumn[index].visible!,
                    ),
                  )
                ],
                onCellLongPress: (DataGridCellLongPressDetails details) {
                  final String value = tableDataSource
                      .effectiveRows[details.rowColumnIndex.rowIndex - 1]
                      .getCells()[details.rowColumnIndex.columnIndex - 1]
                      .value;

                  if (value.isNotEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text(
                            value,
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    );
                  }
                },
                tableSummaryRows: [
                  if (widget.listSum!.isNotEmpty)
                    GridTableSummaryRow(
                      showSummaryInRow: false,
                      color: AppColors.blueLight,
                      columns: [
                        if (widget.pageData.master == true)
                          const GridSummaryColumn(
                            name: 'SumIcon',
                            columnName: 'icon',
                            summaryType: GridSummaryType.sum,
                          ),
                        GridSummaryColumn(
                          name: 'SumId',
                          columnName: widget.pageData.primary,
                          summaryType: GridSummaryType.sum,
                        ),
                        ...List.generate(
                          widget.listColumn.length,
                          (index) {
                            return GridSummaryColumn(
                              name: 'Sum',
                              columnName: widget.listColumn[index].columnName!,
                              summaryType: GridSummaryType.sum,
                            );
                          },
                        )
                      ],
                      position: GridTableSummaryRowPosition.bottom,
                    ),
                ],
              ),
            ),
          ),
          widget.paginationWidget
        ],
      ),
    );
  }
}

class TableDataSource extends DataGridSource {
  final List<ColumnList> listColumn;
  final BuildContext context;
  final List<dynamic> data;
  final Pages pageData;
  final List<AllDropdownModel> allDropdownModelList;
  final List<dynamic>? listSum;
  TableDataSource({
    required this.listColumn,
    required this.context,
    required this.data,
    required this.pageData,
    required this.allDropdownModelList,
    required this.listSum,
  }) {
    dataGridRows = data.map<DataGridRow>((e) {
      return DataGridRow(cells: [
        if (pageData.master == true)
          const DataGridCell(columnName: "icon", value: ""),
        DataGridCell(
            columnName: pageData.primary,
            value: "${e[pageData.primary] ?? ""}"),
        ...List.generate(
          listColumn.length,
          (index) => DataGridCell(
              columnName: listColumn[index].columnName!,
              value: getValue(
                  listColumn: listColumn,
                  key: listColumn[index].columnName!,
                  value: "${e[listColumn[index].columnName!] ?? ""}")),
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
    int indexRow = dataGridRows.indexOf(row);
    return DataGridRowAdapter(
        color: data[indexRow][pageData.columnColor] != null
            ? hexToColor(data[indexRow][pageData.columnColor])
            : null,
        cells: row.getCells().map<Widget>((e) {
          ColumnList columnList;
          if (e.columnName.toString() == pageData.primary) {
            columnList = listColumn[0];
          } else {
            if (e.columnName == "icon") {
              columnList = listColumn[0];
            } else {
              columnList = listColumn
                  .firstWhere((element) => element.columnName == e.columnName);
            }
          }
          if (e.columnName == "icon") {
            return InkWell(
              onTap: () {
                GoRouter.of(context).push(AppRouter.kDetailsRowView,
                    extra: PassDataDetailsRow(
                      pageData: pageData,
                      rowData: data[indexRow],
                    ));
              },
              child: Container(
                margin: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.blue,
                ),
                child: Icon(
                  Icons.add,
                  color: AppColors.white,
                  size: 15,
                ),
              ),
            );
          } else {
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8),
              child: e.columnName.toString() == pageData.primary
                  ? Text(e.value.toString())
                  : buildMyWidget(
                      value: e.value.toString(),
                      columnList: columnList,
                      // indexRow: ,
                    ),
            );
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
    if (listSum!.isNotEmpty) {
      for (var i in listColumn) {
        if ((i.arColumnLabel == summaryColumn!.columnName) ||
            (i.enColumnLabel == summaryColumn.columnName)) {
          if (listSum![0][i.columnName] != null) {
            sum = double.parse((listSum![0][i.columnName]).toString());
          }
        }
      }
    }

    return InkWell(
      onTap: () {
        if (sum != 0) {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              child: InkWell(
                child: Container(
                  padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 16, vertical: 32),
                  child: Text(
                      textAlign: TextAlign.center,
                      NumberFormat('##0.00').format(sum)),
                ),
              ),
            ),
          );
        }
      },
      child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              border: Border.symmetric(
                  vertical: BorderSide(color: Colors.grey, width: .8))),
          padding: const EdgeInsets.all(5),
          child: Text(
            sum == 0 ? "" : NumberFormat('##0.00').format(sum),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white),
          )),
    );
  }

  buildMyWidget({
    required String value,
    required ColumnList columnList,
    /* required int indexRow*/
  }) {
    switch (columnList.insertType) {
      case "date":
        String date = value;
        return Text(
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          date == "0001-12-31" || date == "0000-12-31" ? '' : date,
        );

      case "checkbox":
        if (value == "true") {
          return const Icon(
            Icons.check,
            size: 20,
            color: Colors.green,
          );
        } else {
          return const Icon(
            Icons.close,
            size: 20,
            color: Colors.red,
          );
        }
      case "dropdown":
        String val = value;
        return Text(
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          val,
        );
      default:
        return Text(
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          value,
        );
    }
  }

  getValue({required List<ColumnList> listColumn, key, required String value}) {
    ColumnList columnList =
        listColumn.firstWhere((element) => (element.columnName == key));
    if (columnList.insertType == "date") {
      String date = value.isNotEmpty
          ? DateFormat("yyyy-MM-dd", "en")
              .format(DateTime.parse(value).toLocal())
          : '';
      return date;
    } else if (columnList.insertType == "dateTime") {
      String date = value.isNotEmpty
          ? DateFormat('yyyy/MM/dd hh:mm a', "en")
              .format(DateTime.parse(value).toLocal())
          : '';
      return date;
    } else if (columnList.insertType == "dropdown") {
      String val = '';
      if (columnList.columnName == columnList.searchName) {
        List<ListDrop>? listDrop = [];
        List<ItemDrop>? myListDrop = [];
        for (var item in allDropdownModelList) {
          if (item.listName == pageData.listName) {
            listDrop = item.list;
          }
        }

        for (var item in listDrop!) {
          if (item.columnName == columnList.columnName &&
              item.nameAr == columnList.arColumnLabel) {
            myListDrop = item.list;
          }
        }
        for (var item in myListDrop!) {
          if (item.id.toString() == value) {
            val = item.text ?? "";
          }
        }
      } else {
        val = value;
      }
      return val;
    } else {
      return value;
    }
  }

  // دالة لتحويل الكود hex إلى لون
  Color hexToColor(String hex) {
    hex = hex.replaceAll('#', ''); // إزالة #

    // إضافة شفافية كاملة إذا لم يكن الكود يحتوي على 8 خانات (ARGB)
    if (hex.length == 6) {
      hex = "FF$hex"; // إضافة الشفافية
    }

    return Color(int.parse("0x$hex"));
  }
}
