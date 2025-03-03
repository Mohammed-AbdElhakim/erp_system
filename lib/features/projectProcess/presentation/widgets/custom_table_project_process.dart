import 'package:erp_system/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../../core/models/menu_model/pages.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../data/models/all_dropdown_model.dart';
import '../../data/models/header_model.dart';

class CustomTableProjectProcess extends StatefulWidget {
  const CustomTableProjectProcess({
    super.key,
    required this.listData,
    required this.paginationWidget,
    required this.listColumn,
    required this.allDropdownModelList,
    required this.tabsWidget,
    required this.pageData,
  });
  final Pages pageData;
  final List<dynamic> listData;
  final List<HeaderModel> listColumn;
  final List<AllDropdownModel> allDropdownModelList;
  final Widget tabsWidget;
  final Widget paginationWidget;

  @override
  State<CustomTableProjectProcess> createState() =>
      _CustomTableProjectProcessState();
}

class _CustomTableProjectProcessState extends State<CustomTableProjectProcess> {
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
  String? lang;
  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    headerScrollController = controllerGroup.addAndGet();
    dataScrollController = controllerGroup.addAndGet();
    sumScrollController = controllerGroup.addAndGet();
    for (int i = 0; i < widget.listData.length; i++) {
      selectedRows.add(false); // Initialize selectedRows with false
    }

    tableDataSource = TableDataSource(
      lang: lang,
      data: widget.listData,
      pageData: widget.pageData,
      context: context,
      listColumn: widget.listColumn,
      allDropdownModelList: widget.allDropdownModelList,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.tabsWidget,
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
              selectionMode: SelectionMode.singleDeselect,
              verticalScrollController: verticalScrollController,
              horizontalScrollController: horizontalScrollController,
              gridLinesVisibility: GridLinesVisibility.both,
              headerGridLinesVisibility: GridLinesVisibility.both,
              columnWidthMode: ColumnWidthMode.auto,
              isScrollbarAlwaysShown: true,
              footerFrozenRowsCount: 1,
              autoExpandGroups: false,
              columns: [
                ...List.generate(
                  widget.listColumn.length,
                  (index) => GridColumn(
                    minimumWidth: 120,
                    maximumWidth: 320,
                    columnName: lang == AppStrings.enLangKey
                        ? widget.listColumn[index].enColumnLabel!
                        : widget.listColumn[index].arColumnLabel!,
                    label: Center(
                      child: Text(
                        lang == AppStrings.enLangKey
                            ? widget.listColumn[index].enColumnLabel!
                            : widget.listColumn[index].arColumnLabel!,
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
        widget.paginationWidget
      ],
    );
  }
}

class TableDataSource extends DataGridSource {
  final List<HeaderModel> listColumn;
  final BuildContext context;
  final List<dynamic> data;
  final Pages pageData;
  final List<AllDropdownModel> allDropdownModelList;
  final String? lang;
  TableDataSource({
    required this.listColumn,
    required this.context,
    required this.data,
    required this.pageData,
    required this.allDropdownModelList,
    required this.lang,
  }) {
    dataGridRows = data.map<DataGridRow>((e) {
      return DataGridRow(cells: [
        ...List.generate(
          listColumn.length,
          (index) => DataGridCell(
              columnName: lang == AppStrings.enLangKey
                  ? listColumn[index].enColumnLabel!
                  : listColumn[index].arColumnLabel!,
              value: getValue(listColumn, listColumn[index].columnName,
                  "${e.toJson()[listColumn[index].columnName] ?? ""}")),
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
      HeaderModel columnList;
      if (e.columnName.toString() == pageData.primary) {
        columnList = listColumn[0];
      } else {
        columnList = listColumn.firstWhere((element) =>
            ((element.enColumnLabel == e.columnName) ||
                (element.arColumnLabel == e.columnName)));
      }
      return Container(
        alignment: Alignment.center,
        color: data[indexRow].toJson()[pageData.columnColor] != null
            ? hexToColor(data[indexRow].toJson()[pageData.columnColor])
            : null,
        padding: const EdgeInsets.all(8),
        child: e.columnName.toString() == pageData.primary
            ? Text(e.value.toString())
            : buildMyWidget(
                value: e.value.toString(),
                columnList: columnList,
                // indexRow: ,
              ),
      );
    }).toList());
  }

  buildMyWidget({
    required String value,
    required HeaderModel columnList,
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

  getValue(List<HeaderModel> listColumn, key, String value) {
    HeaderModel columnList =
        listColumn.firstWhere((element) => (element.columnName == key));
    if (columnList.insertType == "date") {
      try {
        String date = value.isNotEmpty
            ? DateFormat("yyyy-MM-dd", "en")
                .format(DateTime.parse(value).toLocal())
            : '';
        return date;
      } catch (e) {
        String date = value.isNotEmpty
            ? DateFormat("yyyy-MM-dd", "en").format(
                DateFormat("M/d/yyyy h:mm:ss a", "en").parse(value).toLocal())
            : '';
        return date;
      }
      // String date = value.isNotEmpty
      //     ? DateFormat("yyyy-MM-dd", "en")
      //         .format(DateTime.parse(value).toLocal())
      //     : '';
      // return date;
    } else if (columnList.insertType == "number") {
      if (value.isNotEmpty) {
        return NumberFormat("#.##").format(double.parse(value));
      } else {
        return value;
      }
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
