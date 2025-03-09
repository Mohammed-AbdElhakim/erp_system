import 'dart:math';

import 'package:erp_system/features/inventoryProduct/presentation/widgets/pagination_widget.dart';
import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/inventory_product_model.dart';
import 'footer_table.dart';
import 'inventory_product_data_source.dart';
import 'multi_select.dart';

class InventoryProductTable extends StatefulWidget {
  const InventoryProductTable({
    super.key,
    required this.inventoryProductList,
    // required this.selectionItemsShow,
  });
  final List<InventoryProductModel> inventoryProductList;
  // final List<String> selectionItemsShow;

  @override
  State<InventoryProductTable> createState() => _InventoryProductTableState();
}

class _InventoryProductTableState extends State<InventoryProductTable> {
  late InventoryProductDataSource inventoryProductDataSource;

  LinkedScrollControllerGroup controllerGroup = LinkedScrollControllerGroup();
  ScrollController? headerScrollController;
  ScrollController? dataScrollController;
  ScrollController? sumScrollController;
  final DataGridController dataGridController = DataGridController();
  TextEditingController controllerSearch = TextEditingController();
  int _page = 1; // default page to 0
  late int _perPage;
  List<int> listNumberItemInList = [10, 25, 50, 100];
  List<String> selectionItems = [AppStrings.closingBalances];
  bool checkboxValue = false;
  late List<InventoryProductModel> inventoryProductListShow;

  @override
  void initState() {
    super.initState();
    headerScrollController = controllerGroup.addAndGet();
    dataScrollController = controllerGroup.addAndGet();
    sumScrollController = controllerGroup.addAndGet();
    inventoryProductListShow = widget.inventoryProductList;
    _perPage = listNumberItemInList[0];
  }

  @override
  Widget build(BuildContext context) {
    final int start = (_page - 1) * _perPage;
    final int end = min(start + _perPage, inventoryProductListShow.length);
    final List<InventoryProductModel> dataToShow =
        inventoryProductListShow.sublist(start, end);
    inventoryProductDataSource = InventoryProductDataSource(
        inventoryProduct: dataToShow,
        controllerSearch: controllerSearch.text,
        selectionItemsShow: selectionItems);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: StatefulBuilder(
                builder:
                    (BuildContext context, void Function(void Function()) nsetState) {
                  return CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      value: checkboxValue,
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(
                        S.of(context).massage_number_zero,
                        style: AppStyles.textStyle14.copyWith(color: Colors.black),
                      ),
                      onChanged: (newValue) {
                        nsetState(() {
                          checkboxValue = !checkboxValue;
                        });
                        if (checkboxValue) {
                          inventoryProductListShow = widget.inventoryProductList
                              .where((element) => element.mony! > 0)
                              .toList();
                        } else {
                          inventoryProductListShow = widget.inventoryProductList;
                        }
                        _page = 1;

                        setState(() {});
                      });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                onPressed: _showMultiSelectDialog,
                icon: const Icon(
                  Icons.settings,
                  size: 30,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          // height: MediaQuery.of(context).size.height - 317.4,
          height: MediaQuery.of(context).size.height * .45,
          child: SfDataGridTheme(
            data: SfDataGridThemeData(
              headerColor: AppColors.blueLight,
              selectionColor: Colors.blueGrey.shade100,
              indentColumnWidth: 0,
              // gridLineColor: Colors.red,
              // gridLineStrokeWidth: 1,
            ),
            child: SfDataGrid(
              gridLinesVisibility: GridLinesVisibility.both,
              headerGridLinesVisibility: GridLinesVisibility.both,
              source: inventoryProductDataSource,
              headerRowHeight: 40,
              controller: dataGridController,
              rowHeight: 40,
              horizontalScrollController: dataScrollController,
              showHorizontalScrollbar: false,
              showVerticalScrollbar: false,
              columns: buildColumnsTable(),
              stackedHeaderRows: <StackedHeaderRow>[buildCustomStackedHeaderRow()],
              selectionMode: SelectionMode.singleDeselect,
              onCellLongPress: (DataGridCellLongPressDetails details) {
                final String value = inventoryProductDataSource
                    .effectiveRows[details.rowColumnIndex.rowIndex - 2]
                    .getCells()[details.rowColumnIndex.columnIndex]
                    .value
                    .toString();

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
              footer: FooterTable(
                sumScrollController: sumScrollController,
                inventoryProductList: widget.inventoryProductList,
                selectionItemsShow: selectionItems,
              ),
            ),
          ),
        ),
        PaginationWidget(
          numberOfRecords: inventoryProductListShow.length,
          onChangeLimit: (limit) {
            setState(() {
              _page = 1;
              _perPage = limit;
            });
          },
          listNumberItemInList: listNumberItemInList,
          dropdownValue: _perPage,
          myPage: _page,
          allPages: (inventoryProductListShow.length % _perPage) == 0
              ? (inventoryProductListShow.length ~/ _perPage)
              : (inventoryProductListShow.length ~/ _perPage) + 1,
          onTapMin: () {
            setState(() {
              _page -= 1;
            });
          },
          onTapAdd: () {
            setState(() {
              _page += 1;
            });
          },
        )
      ],
    );
  }

  List<GridColumn> buildColumnsTable() {
    return [
      GridColumn(
        columnName: 'acName',
        label: Padding(
          padding: const EdgeInsets.all(5.0),
          child: CustomTextFormField(
            hintText: 'search',
            filled: true,
            fillColor: Colors.white,
            controller: controllerSearch,
            onChanged: (value) {
              setState(() {
                inventoryProductDataSource = InventoryProductDataSource(
                    inventoryProduct: inventoryProductListShow,
                    controllerSearch: value,
                    selectionItemsShow: selectionItems);
              });
            },
          ),
        ),
        width: MediaQuery.of(context).size.width * .5,
      ),
      if (selectionItems.contains(AppStrings.openingBalances))
        GridColumn(
          width: MediaQuery.of(context).size.width * .25,
          columnName: 'depitBefor',
          label: Center(child: Text('مدين', style: AppStyles.textStyle14)),
        ),
      if (selectionItems.contains(AppStrings.openingBalances))
        GridColumn(
          width: MediaQuery.of(context).size.width * .25,
          columnName: 'creditBefor',
          label: Center(child: Text('دائن', style: AppStyles.textStyle14)),
        ),
      if (selectionItems.contains(AppStrings.movement))
        GridColumn(
          width: MediaQuery.of(context).size.width * .25,
          columnName: 'depitMony',
          label: Center(child: Text('مدين', style: AppStyles.textStyle14)),
        ),
      if (selectionItems.contains(AppStrings.movement))
        GridColumn(
          width: MediaQuery.of(context).size.width * .25,
          columnName: 'creditMony',
          label: Center(child: Text('دائن', style: AppStyles.textStyle14)),
        ),
      if (selectionItems.contains(AppStrings.totals))
        GridColumn(
          width: MediaQuery.of(context).size.width * .25,
          columnName: 'depitSum',
          label: Center(child: Text('مدين', style: AppStyles.textStyle14)),
        ),
      if (selectionItems.contains(AppStrings.totals))
        GridColumn(
          width: MediaQuery.of(context).size.width * .25,
          columnName: 'creditSum',
          label: Center(child: Text('دائن', style: AppStyles.textStyle14)),
        ),
      if (selectionItems.contains(AppStrings.closingBalances))
        GridColumn(
          width: MediaQuery.of(context).size.width * .25,
          columnName: 'depitAfter',
          label: Center(child: Text('مدين', style: AppStyles.textStyle14)),
        ),
      if (selectionItems.contains(AppStrings.closingBalances))
        GridColumn(
          width: MediaQuery.of(context).size.width * .25,
          columnName: 'creditAfter',
          label: Center(child: Text('دائن', style: AppStyles.textStyle14)),
        ),
    ];
  }

  StackedHeaderRow buildCustomStackedHeaderRow() {
    return StackedHeaderRow(cells: [
      StackedHeaderCell(
          columnNames: ['acName'],
          child: Center(child: Text('الحساب', style: AppStyles.textStyle14))),
      if (selectionItems.contains(AppStrings.openingBalances))
        StackedHeaderCell(
            columnNames: ['depitBefor', 'creditBefor'],
            child:
                Center(child: Text('الأرصدة الافتتاحية', style: AppStyles.textStyle14))),
      if (selectionItems.contains(AppStrings.movement))
        StackedHeaderCell(
            columnNames: ['depitMony', 'creditMony'],
            child: Center(child: Text('الحركة', style: AppStyles.textStyle14))),
      if (selectionItems.contains(AppStrings.totals))
        StackedHeaderCell(
            columnNames: ['depitSum', 'creditSum'],
            child: Center(child: Text('مجاميع', style: AppStyles.textStyle14))),
      if (selectionItems.contains(AppStrings.closingBalances))
        StackedHeaderCell(
            columnNames: ['depitAfter', 'creditAfter'],
            child: Center(child: Text('الأرصدة الختامية', style: AppStyles.textStyle14))),
    ]);
  }

  void _showMultiSelectDialog() async {
    final List<String> items = [
      AppStrings.openingBalances,
      AppStrings.movement,
      // AppStrings.totals,
      AppStrings.closingBalances,
    ];
    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(
          items: items,
          selectionItems: selectionItems,
        );
      },
    );
    if (results != null) {
      setState(() {
        selectionItems = results;
      });
      // if (dateFrom.isNotEmpty && dateTo.isNotEmpty) {
      //   BlocProvider.of<InventoryProductCubit>(context).getInventoryProduct(
      //     inventoryProductBody: InventoryProductBodyModel(
      //       datefrom: dateFrom,
      //       dateto: dateTo,
      //       iszero: checkboxValue,
      //       pram: 0,
      //     ),
      //   );
      // }
    }
  }
}
