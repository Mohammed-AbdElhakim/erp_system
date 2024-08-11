import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../data/models/general_balance_model.dart';
import 'general_balance_data_source.dart';

class GeneralBalanceTable extends StatefulWidget {
  const GeneralBalanceTable({super.key, required this.generalBalanceList});
  final List<GeneralBalanceModel> generalBalanceList;
  // final List<String> selectionItemsShow;

  @override
  State<GeneralBalanceTable> createState() => _GeneralBalanceTableState();
}

class _GeneralBalanceTableState extends State<GeneralBalanceTable> {
  late GeneralBalanceDataSource generalBalanceDataSource;

  LinkedScrollControllerGroup controllerGroup = LinkedScrollControllerGroup();
  ScrollController? dataScrollController;
  TextEditingController controllerLevel = TextEditingController();

  @override
  void initState() {
    super.initState();
    dataScrollController = controllerGroup.addAndGet();
    generalBalanceDataSource = GeneralBalanceDataSource(
      generalBalance: widget.generalBalanceList,
      controllerLevel: controllerLevel.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * .5,
            child: CustomTextFormField(
              hintText: 'level',
              controller: controllerLevel,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  generalBalanceDataSource = GeneralBalanceDataSource(
                    generalBalance: widget.generalBalanceList,
                    controllerLevel: value,
                  );
                });
              },
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height - 367.5,
          child: SfDataGridTheme(
            data: SfDataGridThemeData(
              headerColor: AppColors.blueLight,
              selectionColor: Colors.blueGrey.shade100,
              // indentColumnWidth: 0,
              // gridLineColor: Colors.red,
              // gridLineStrokeWidth: 1,
            ),
            child: SfDataGrid(
              gridLinesVisibility: GridLinesVisibility.both,
              headerGridLinesVisibility: GridLinesVisibility.both,
              source: generalBalanceDataSource,
              headerRowHeight: 35,
              rowHeight: 40,
              horizontalScrollController: dataScrollController,
              showHorizontalScrollbar: false,
              showVerticalScrollbar: false,
              columns: buildColumnsTable(),
              selectionMode: SelectionMode.singleDeselect,
            ),
          ),
        ),
      ],
    );
  }

  List<GridColumn> buildColumnsTable() {
    return [
      GridColumn(
        // width: MediaQuery.of(context).size.width * .5 ,
        columnName: 'description',
        label: Center(child: Text('البيان', style: AppStyles.textStyle14)),
        columnWidthMode: ColumnWidthMode.auto,
      ),
      GridColumn(
        // width: MediaQuery.of(context).size.width * .25,
        columnName: 'Mony',
        label: Center(child: Text('القيمة', style: AppStyles.textStyle14)),
        columnWidthMode: ColumnWidthMode.auto,
      ),
      GridColumn(
        // width: MediaQuery.of(context).size.width * .25,
        columnName: 'Subamount',
        label: Center(child: Text('Subamount', style: AppStyles.textStyle14)),
        columnWidthMode: ColumnWidthMode.auto,
      ),
    ];
  }
}
