import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/methods.dart';
import '../../data/models/dropdown_model/all_dropdown_model.dart';
import '../../data/models/screen_model.dart';

typedef OnTapHeader<String> = void Function(String titleHeader);
typedef OnTapRow<T> = void Function(T rowData);

class CustomTableGroup extends StatefulWidget {
  const CustomTableGroup({
    super.key,
    required this.listHeader,
    required this.listData,
    required this.listKey,
    required this.paginationWidget,
    required this.onTapHeader,
    required this.listColumn,
    required this.onTapRow,
    this.listSum,
    required this.allDropdownModelList,
    required this.pageData,
  });
  final Pages pageData;
  final List<String> listHeader;
  final List<dynamic> listData;
  final List<dynamic>? listSum;
  final List<dynamic> listKey;
  final List<ColumnList> listColumn;
  final List<AllDropdownModel> allDropdownModelList;
  final Widget paginationWidget;
  final OnTapHeader<String> onTapHeader;
  final OnTapRow<List<Map<String, dynamic>>> onTapRow;

  @override
  State<CustomTableGroup> createState() => _CustomTableGroupState();
}

class _CustomTableGroupState extends State<CustomTableGroup> {
  LinkedScrollControllerGroup controllerGroup = LinkedScrollControllerGroup();
  ScrollController? headerScrollController;
  ScrollController? dataScrollController;
  ScrollController? sumScrollController;
  // int? indexColorRow;
  List<bool> selectedRows = [];
  List<Map<String, dynamic>> rowsData = [];

  late TableDataSource tableDataSource;
  final DataGridController dataGridController = DataGridController();

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
      keys: widget.listKey,
      pageData: widget.pageData,
      context: context,
      listColumn: widget.listColumn,
      allDropdownModelList: widget.allDropdownModelList,
    );
    tableDataSource.addColumnGroup(
        ColumnGroup(name: 'PaymentAccount', sortGroupRows: false));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SfDataGridTheme(
        data: SfDataGridThemeData(
            headerColor: AppColors.blueLight,
            selectionColor: AppColors.blueGreyDark,
            indentColumnWidth: 0,
            gridLineColor: Colors.transparent),
        child: SfDataGrid(
          source: tableDataSource,
          // allowExpandCollapseGroup: true,
          headerRowHeight: 35,
          controller: dataGridController,
          rowHeight: 35,
          horizontalScrollController: dataScrollController,
          showHorizontalScrollbar: false,
          showVerticalScrollbar: false,
          selectionMode: SelectionMode.multiple,
          showCheckboxColumn: true,
          checkboxColumnSettings: const DataGridCheckboxColumnSettings(
            showCheckboxOnHeader: false,
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

          // autoExpandGroups: false,
          columns: [
            if (widget.pageData.editSrc == "addOrEditExcel")
              GridColumn(
                width: 45,
                columnName: '',
                label: Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: const Text(""),
                ),
              ),
            GridColumn(
              width: 0,
              columnName: widget.pageData.primary,
              label: Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: const Text("id"),
              ),
            ),
            ...List.generate(
              widget.listHeader.length,
              (index) => GridColumn(
                width: 130,
                columnName: widget.listKey[index],
                label: InkWell(
                  onTap: () {
                    widget.onTapHeader(widget.listColumn[index].columnName!);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: Text(
                      widget.listHeader[index],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
          footerHeight: 230,
          footer: Column(
            children: [
              //********************* Sum ***********************
              if (widget.listSum!.isNotEmpty)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: sumScrollController,
                  child: DataTable(
                    columnSpacing: 0,
                    horizontalMargin: 48,
                    dataRowMinHeight: 50,
                    dataRowMaxHeight: 50,
                    headingRowHeight: 35,
                    headingRowColor:
                        MaterialStateProperty.all(AppColors.blueLight),
                    columns: [
                      if (widget.pageData.editSrc == "addOrEditExcel")
                        const DataColumn(
                          label: SizedBox(
                            width: 47,
                          ),
                        ),
                      ...List.generate(
                        widget.listHeader.length,
                        (index) {
                          return DataColumn(
                            label: InkWell(
                              onTap: () {
                                if (widget.listSum![0][widget.listKey[index]]
                                        .toString()
                                        .length >
                                    12) {
                                  buildShowDialog(context,
                                      text: widget.listSum![0]
                                              [widget.listKey[index]]
                                          .toString());
                                }
                              },
                              child: SizedBox(
                                width: 130,
                                child: Text(
                                  widget.listSum![0][widget.listKey[index]] ==
                                          null
                                      ? ""
                                      : widget.listSum![0]
                                              [widget.listKey[index]]
                                          .toString(),
                                  // widget.listHeader[index],
                                  textAlign: TextAlign.center,
                                  style: AppStyles.textStyle14,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                    rows: const [],
                  ),
                ),
              //********************* pages *********************
              widget.paginationWidget,
            ],
          ),
        ),
      ),
    );
  }

  bool containsAllKeyValuePairs(
      Map<String, dynamic> map1, Map<String, dynamic> map2) {
    return map2.entries.every((entry) {
      final key = entry.key;
      final value = entry.value;
      return map1.containsKey(key) && map1[key] == value;
    });
  }
}

class TableDataSource extends DataGridSource {
  final List<ColumnList> listColumn;
  final BuildContext context;
  final List<dynamic> data;
  final List<dynamic> keys;
  final Pages pageData;
  final List<AllDropdownModel> allDropdownModelList;
  TableDataSource({
    required this.listColumn,
    required this.context,
    required this.data,
    required this.keys,
    required this.pageData,
    required this.allDropdownModelList,
  }) {
    dataGridRows = data.map<DataGridRow>((e) {
      return DataGridRow(cells: [
        if (pageData.editSrc == "addOrEditExcel")
          const DataGridCell(columnName: '', value: "Icon(Icons.add)"),
        DataGridCell(columnName: pageData.primary, value: e[pageData.primary]),
        ...List.generate(
          keys.length,
          (index) => DataGridCell(
              columnName: keys[index], value: "${e[keys[index]] ?? ""}"),
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
      ColumnList columnList;
      if (e.value.toString() == "Icon(Icons.add)") {
        columnList = listColumn[0];
      } else if (e.columnName.toString() == pageData.primary) {
        columnList = listColumn[0];
      } else {
        columnList = listColumn
            .firstWhere((element) => element.columnName == e.columnName);
      }

      return InkWell(
        onTap: columnList.insertType! != "date"
            ? e.value.toString().length > 12
                ? () {
                    buildShowDialog(context, text: e.value.toString());
                  }
                : null
            : null,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: e.value.toString() == "Icon(Icons.add)"
              ? const Icon(Icons.add)
              : e.columnName.toString() == pageData.primary
                  ? Text(e.value.toString())
                  : buildMyWidget(
                      value: e.value.toString(),
                      columnList: columnList,
                      // indexRow: ,
                    ),
        ),
      );
    }).toList());
  }

  @override
  Widget? buildGroupCaptionCellWidget(
      RowColumnIndex rowColumnIndex, String summaryValue) {
    return Container(
        color: Colors.blue.shade100,
        alignment: AlignmentDirectional.centerStart,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(summaryValue.split(":")[1].trim().split('-')[0].trim()));
  }

  buildMyWidget({
    required String value,
    required ColumnList columnList,
    /* required int indexRow*/
  }) {
    switch (columnList.insertType) {
      case "date":
        String date = value.isNotEmpty
            ? DateFormat("yyyy-MM-dd", "en")
                .format(DateTime.parse(value).toLocal())
            : '';
        return Text(
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          date == "0001-12-31" || date == "0000-12-31" ? '' : date,
          // style: TextStyle(
          //     color:
          //         selectedRows[indexRow] == true ? Colors.white : Colors.black),
        );
      case "checkbox":
        if (value == "true") {
          return const Icon(
            Icons.check,
            size: 20,
            color: Colors.green,
          );
        } else if (value == "false") {
          return const Icon(
            Icons.close,
            size: 20,
            color: Colors.red,
          );
        }
      case "dropdown":
        String val = '';
        if (columnList.columnName == columnList.searchName) {
          List<ListDrop>? myListDrop = [];
          for (var item in allDropdownModelList) {
            if (item.columnName == columnList.columnName) {
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
        return Text(
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          val,
          // style: TextStyle(
          //     color:
          //         selectedRows[indexRow] == true ? Colors.white : Colors.black),
        );
      default:
        return Text(
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          value,
          // style: TextStyle(
          //     color:
          //         selectedRows[indexRow] == true ? Colors.white : Colors.black),
        );
    }
  }
}