import 'package:erp_system/features/trialCost/data/models/trial_cost_model.dart';
import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../trialCost/presentation/widgets/multi_select.dart';
import 'trial_cost_data_source.dart';

class TrialCostTable extends StatefulWidget {
  const TrialCostTable({super.key, required this.trialCostList});

  final List<TrialCostItem> trialCostList;

  // final List<String> selectionItemsShow;

  @override
  State<TrialCostTable> createState() => _TrialCostTableState();
}

class _TrialCostTableState extends State<TrialCostTable> {
  late TrialCostDataSource trialCostDataSource;

  LinkedScrollControllerGroup controllerGroup = LinkedScrollControllerGroup();
  ScrollController? headerScrollController;
  ScrollController? dataScrollController;
  ScrollController? sumScrollController;
  final DataGridController dataGridController = DataGridController();
  TextEditingController controllerSearch = TextEditingController();
  TextEditingController controllerLevel = TextEditingController();
  List<String> selectionItems = [AppStrings.closingBalances];

  @override
  void initState() {
    super.initState();
    headerScrollController = controllerGroup.addAndGet();
    dataScrollController = controllerGroup.addAndGet();
    sumScrollController = controllerGroup.addAndGet();
  }

  @override
  Widget build(BuildContext context) {
    trialCostDataSource = TrialCostDataSource(
        trialCost: widget.trialCostList,
        controllerLevel: controllerLevel.text,
        controllerSearch: controllerSearch.text,
        selectionItemsShow: selectionItems);
    return SizedBox(
      // height: widget.trialCostList.length * 40 + 40,
      // height: MediaQuery.of(context).size.height * .75,
      height: MediaQuery.of(context).size.height - 317.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // alignment: Alignment.center,
        // clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 8, bottom: 8, start: 16),
            child: InkWell(
              onTap: _showMultiSelectDialog,
              child: const Icon(
                Icons.settings,
                size: 30,
                color: Colors.blue,
              ),
            ),
          ),
          SfDataGridTheme(
            data: SfDataGridThemeData(
              headerColor: AppColors.blueLight,
              selectionColor: Colors.blueGrey.shade100,
              indentColumnWidth: 0,

              // gridLineColor: Colors.red,
              // gridLineStrokeWidth: 1,
            ),
            child: Expanded(
              child: SfDataGrid(
                gridLinesVisibility: GridLinesVisibility.both,
                headerGridLinesVisibility: GridLinesVisibility.both,
                source: trialCostDataSource,
                // verticalScrollPhysics: const NeverScrollableScrollPhysics(),
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
                  final String value = trialCostDataSource.effectiveRows[details.rowColumnIndex.rowIndex - 2]
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
              ),
            ),
          ),
          // PositionedDirectional(
          //   top: -5,
          //   start: 8,
          //   child: IconButton(
          //     onPressed: _showMultiSelectDialog,
          //     icon: const Icon(
          //       Icons.settings,
          //       size: 30,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  List<GridColumn> buildColumnsTable() {
    return [
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
                        trialCostDataSource = TrialCostDataSource(
                            trialCost: widget.trialCostList,
                            controllerLevel: controllerLevel.text,
                            controllerSearch: value,
                            selectionItemsShow: selectionItems);
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
                        trialCostDataSource = TrialCostDataSource(
                            trialCost: widget.trialCostList,
                            controllerLevel: value,
                            controllerSearch: controllerSearch.text,
                            selectionItemsShow: selectionItems);
                      });
                    },
                  ),
                )),
          ],
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
      StackedHeaderCell(columnNames: ['acName'], child: Center(child: Text('الحساب', style: AppStyles.textStyle14))),
      if (selectionItems.contains(AppStrings.openingBalances))
        StackedHeaderCell(
            columnNames: ['depitBefor', 'creditBefor'],
            child: Center(child: Text('الأرصدة الافتتاحية', style: AppStyles.textStyle14))),
      if (selectionItems.contains(AppStrings.movement))
        StackedHeaderCell(
            columnNames: ['depitMony', 'creditMony'], child: Center(child: Text('الحركة', style: AppStyles.textStyle14))),
      if (selectionItems.contains(AppStrings.totals))
        StackedHeaderCell(
            columnNames: ['depitSum', 'creditSum'], child: Center(child: Text('مجاميع', style: AppStyles.textStyle14))),
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
    }
  }
}
