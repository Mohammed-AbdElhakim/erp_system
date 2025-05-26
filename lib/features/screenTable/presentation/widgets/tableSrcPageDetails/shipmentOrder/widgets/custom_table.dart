import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../../../core/utils/app_colors.dart';
import '../../../../../../../core/utils/app_strings.dart';
import '../models/bills_data_model.dart';
import 'table_data_source.dart';

typedef OnTapRow<T> = void Function(T rowData);

class CustomTable extends StatefulWidget {
  const CustomTable({super.key, required this.dataList, required this.onTapRow});

  // final List<BillsHeaderModel> heaterList;
  final List<BillsDataModel> dataList;
  final OnTapRow<List<Map<String, dynamic>>> onTapRow;

  @override
  State<CustomTable> createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
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
  void didUpdateWidget(covariant CustomTable oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.dataList != widget.dataList) {
      setState(() {
        tableDataSource = TableDataSource(
          data: widget.dataList,
          context: context,
        );
      });
    }
  }

  @override
  void initState() {
    headerScrollController = controllerGroup.addAndGet();
    dataScrollController = controllerGroup.addAndGet();
    sumScrollController = controllerGroup.addAndGet();
    for (int i = 0; i < widget.dataList.length; i++) {
      selectedRows.add(false); // Initialize selectedRows with false
    }

    tableDataSource = TableDataSource(
      data: widget.dataList,
      // pageData: widget.pageData,
      context: context,
      // listColumn: widget.heaterList,
      // allDropdownModelList: widget.allDropdownModelList,
      // listSum: widget.listSum,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
            GridColumn(
              width: 0,
              columnName: "ContractID",
              label: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Center(
                  child: Text(
                    "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            GridColumn(
              minimumWidth: 90,
              maximumWidth: 150,
              columnName: "AutoNumber",
              label: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Center(
                  child: Text(
                    lang == AppStrings.arLangKey ? "رقم الفاتورة" : "Invoice number",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            GridColumn(
              minimumWidth: 90,
              maximumWidth: 150,
              columnName: "CustomerAccountName",
              label: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Center(
                  child: Text(
                    lang == AppStrings.arLangKey ? "العميل" : "Customer",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            GridColumn(
              minimumWidth: 90,
              maximumWidth: 150,
              columnName: "TotalOrder",
              label: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Center(
                  child: Text(
                    lang == AppStrings.arLangKey ? "قيمة الفاتورة" : "invoice value",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            GridColumn(
              minimumWidth: 90,
              maximumWidth: 150,
              columnName: "ContractQuantity",
              label: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Center(
                  child: Text(
                    lang == AppStrings.arLangKey ? "عدد الفاتورة" : "Invoice number",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            GridColumn(
              minimumWidth: 90,
              maximumWidth: 150,
              columnName: "shippingPrice",
              label: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Center(
                  child: Text(
                    lang == AppStrings.arLangKey ? "سعر الشحن" : "Shipping price",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            GridColumn(
              minimumWidth: 90,
              maximumWidth: 150,
              columnName: "Phone2",
              label: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Center(
                  child: Text(
                    lang == AppStrings.arLangKey ? "تليفون العميل" : "Customer Phone",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            GridColumn(
              minimumWidth: 90,
              maximumWidth: 150,
              columnName: "CustomerAccountAddress",
              label: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Center(
                  child: Text(
                    lang == AppStrings.arLangKey ? "عنوان العميل" : "Customer Address",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            GridColumn(
              minimumWidth: 90,
              maximumWidth: 150,
              columnName: "AreaName",
              label: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Center(
                  child: Text(
                    lang == AppStrings.arLangKey ? "المنطقة" : "Area Name",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            GridColumn(
              minimumWidth: 90,
              maximumWidth: 150,
              columnName: "GovName",
              label: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Center(
                  child: Text(
                    lang == AppStrings.arLangKey ? "الحي" : "Gov. Name",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
          onCellLongPress: (DataGridCellLongPressDetails details) {
            final String value = tableDataSource.effectiveRows[details.rowColumnIndex.rowIndex - 1]
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
        ),
      ),
    );
  }
}
