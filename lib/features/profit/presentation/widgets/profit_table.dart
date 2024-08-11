import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../data/models/profit_model.dart';
import 'profit_data_source.dart';

class ProfitTable extends StatefulWidget {
  const ProfitTable({super.key, required this.profitList});
  final List<ProfitModel> profitList;
  // final List<String> selectionItemsShow;

  @override
  State<ProfitTable> createState() => _ProfitTableState();
}

class _ProfitTableState extends State<ProfitTable> {
  late ProfitDataSource profitDataSource;

  LinkedScrollControllerGroup controllerGroup = LinkedScrollControllerGroup();
  ScrollController? dataScrollController;
  TextEditingController controllerLevel = TextEditingController();

  @override
  void initState() {
    super.initState();
    dataScrollController = controllerGroup.addAndGet();
    profitDataSource = ProfitDataSource(
      profit: widget.profitList,
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
                  profitDataSource = ProfitDataSource(
                    profit: widget.profitList,
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
              source: profitDataSource,
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
