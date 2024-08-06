import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../data/models/trial_balance_model.dart';
import 'footer_table.dart';
import 'trial_balance_data_source.dart';

class TrialBalanceTable extends StatefulWidget {
  const TrialBalanceTable(
      {super.key,
      required this.trialBalanceList,
      required this.selectionItemsShow});
  final List<TrialBalanceModel> trialBalanceList;
  final List<String> selectionItemsShow;

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
        selectionItemsShow: widget.selectionItemsShow);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 317.4,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 45),
            child: SfDataGridTheme(
              data: SfDataGridThemeData(
                headerColor: AppColors.blueLight,
                selectionColor: Colors.blueGrey.shade100,
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
                columns: buildColumnsTable(),
                stackedHeaderRows: <StackedHeaderRow>[
                  buildCustomStackedHeaderRow()
                ],
                selectionMode: SelectionMode.singleDeselect,
              ),
            ),
          ),
          FooterTable(
            sumScrollController: sumScrollController,
            trialBalanceList: widget.trialBalanceList,
            selectionItemsShow: widget.selectionItemsShow,
          ),
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
                        trialBalanceDataSource = TrialBalanceDataSource(
                            trialBalance: widget.trialBalanceList,
                            controllerLevel: controllerLevel.text,
                            controllerSearch: value,
                            selectionItemsShow: widget.selectionItemsShow);
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
                            selectionItemsShow: widget.selectionItemsShow);
                      });
                    },
                  ),
                )),
          ],
        ),
        width: 300,
      ),
      if (widget.selectionItemsShow.contains(AppStrings.openingBalances))
        GridColumn(
          width: 120,
          columnName: 'depitBefor',
          label: Center(child: Text('مدين', style: AppStyles.textStyle14)),
        ),
      if (widget.selectionItemsShow.contains(AppStrings.openingBalances))
        GridColumn(
          width: 120,
          columnName: 'creditBefor',
          label: Center(child: Text('دائن', style: AppStyles.textStyle14)),
        ),
      if (widget.selectionItemsShow.contains(AppStrings.movement))
        GridColumn(
          width: 120,
          columnName: 'depitMony',
          label: Center(child: Text('مدين', style: AppStyles.textStyle14)),
        ),
      if (widget.selectionItemsShow.contains(AppStrings.movement))
        GridColumn(
          width: 120,
          columnName: 'creditMony',
          label: Center(child: Text('دائن', style: AppStyles.textStyle14)),
        ),
      if (widget.selectionItemsShow.contains(AppStrings.totals))
        GridColumn(
          width: 120,
          columnName: 'depitSum',
          label: Center(child: Text('مدين', style: AppStyles.textStyle14)),
        ),
      if (widget.selectionItemsShow.contains(AppStrings.totals))
        GridColumn(
          width: 120,
          columnName: 'creditSum',
          label: Center(child: Text('دائن', style: AppStyles.textStyle14)),
        ),
      if (widget.selectionItemsShow.contains(AppStrings.closingBalances))
        GridColumn(
          width: 120,
          columnName: 'depitAfter',
          label: Center(child: Text('مدين', style: AppStyles.textStyle14)),
        ),
      if (widget.selectionItemsShow.contains(AppStrings.closingBalances))
        GridColumn(
          width: 120,
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
      if (widget.selectionItemsShow.contains(AppStrings.openingBalances))
        StackedHeaderCell(
            columnNames: ['depitBefor', 'creditBefor'],
            child: Center(
                child:
                    Text('الأرصدة الافتتاحية', style: AppStyles.textStyle14))),
      if (widget.selectionItemsShow.contains(AppStrings.movement))
        StackedHeaderCell(
            columnNames: ['depitMony', 'creditMony'],
            child: Center(child: Text('الحركة', style: AppStyles.textStyle14))),
      if (widget.selectionItemsShow.contains(AppStrings.totals))
        StackedHeaderCell(
            columnNames: ['depitSum', 'creditSum'],
            child: Center(child: Text('مجاميع', style: AppStyles.textStyle14))),
      if (widget.selectionItemsShow.contains(AppStrings.closingBalances))
        StackedHeaderCell(
            columnNames: ['depitAfter', 'creditAfter'],
            child: Center(
                child: Text('الأرصدة الختامية', style: AppStyles.textStyle14))),
    ]);
  }
}
