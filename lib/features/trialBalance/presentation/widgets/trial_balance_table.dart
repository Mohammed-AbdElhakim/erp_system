import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../data/models/trial_balance_model.dart';
import 'build_custom_stacked_header_row.dart';
import 'footer_table.dart';
import 'trial_balance_data_source.dart';

class TrialBalanceTable extends StatefulWidget {
  const TrialBalanceTable({super.key, required this.trialBalanceList});
  final List<TrialBalanceModel> trialBalanceList;

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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SfDataGridTheme(
          data: SfDataGridThemeData(
            headerColor: AppColors.blueLight,
            selectionColor: Colors.grey.shade400,
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
            footerHeight: 45,
            footer: const SizedBox(
              height: 45,
            ),
            selectionMode: SelectionMode.singleDeselect,
          ),
        ),
        FooterTable(
          sumScrollController: sumScrollController,
          trialBalanceList: widget.trialBalanceList,
        ),
      ],
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
                        );
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
                        );
                      });
                    },
                  ),
                )),
          ],
        ),
        width: 300,
      ),
      GridColumn(
        width: 120,
        columnName: 'depitBefor',
        label: Center(child: Text('مدين', style: AppStyles.textStyle14)),
      ),
      GridColumn(
        width: 120,
        columnName: 'creditBefor',
        label: Center(child: Text('دائن', style: AppStyles.textStyle14)),
      ),
      GridColumn(
        width: 120,
        columnName: 'depitMony',
        label: Center(child: Text('مدين', style: AppStyles.textStyle14)),
      ),
      GridColumn(
        width: 120,
        columnName: 'creditMony',
        label: Center(child: Text('دائن', style: AppStyles.textStyle14)),
      ),
      GridColumn(
        width: 120,
        columnName: 'depitSum',
        label: Center(child: Text('مدين', style: AppStyles.textStyle14)),
      ),
      GridColumn(
        width: 120,
        columnName: 'creditSum',
        label: Center(child: Text('دائن', style: AppStyles.textStyle14)),
      ),
      GridColumn(
        width: 120,
        columnName: 'depitAfter',
        label: Center(child: Text('مدين', style: AppStyles.textStyle14)),
      ),
      GridColumn(
        width: 120,
        columnName: 'creditAfter',
        label: Center(child: Text('دائن', style: AppStyles.textStyle14)),
      ),
    ];
  }
}
