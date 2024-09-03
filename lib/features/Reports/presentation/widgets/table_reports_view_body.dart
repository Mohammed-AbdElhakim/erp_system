import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../data/models/table_model.dart';
import 'pagination_widget.dart';
import 'report_data_source.dart';

class TableReportsViewBody extends StatefulWidget {
  const TableReportsViewBody({super.key, required this.tableModel});
  final TableModel tableModel;

  @override
  State<TableReportsViewBody> createState() => _TableReportsViewBodyState();
}

class _TableReportsViewBodyState extends State<TableReportsViewBody> {
  String? lang;
  // LinkedScrollControllerGroup controllerGroup = LinkedScrollControllerGroup();
  ScrollController verticalScrollController = ScrollController();
  ScrollController horizontalScrollController = ScrollController();
  late ReportDataSource reportDataSource;
  late int allPages;
  int dropdownValue = 10;
  int numberPage = 1;

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    // dataScrollController = controllerGroup.addAndGet();
    reportDataSource = ReportDataSource(
        tableModel: widget.tableModel,
        itemsInPage: dropdownValue,
        numberPage: numberPage);
    allPages = (widget.tableModel.numberofrecords! % dropdownValue) == 0
        ? (widget.tableModel.numberofrecords! ~/ dropdownValue)
        : (widget.tableModel.numberofrecords! ~/ dropdownValue) + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: SfDataGridTheme(
              data: SfDataGridThemeData(
                headerColor: AppColors.blueLight,
                selectionColor: Colors.blueGrey.shade100,
                // indentColumnWidth: 0,
                gridLineColor: Colors.grey,
                // gridLineStrokeWidth: 1,
              ),
              child: SfDataGrid(
                gridLinesVisibility: GridLinesVisibility.both,
                headerGridLinesVisibility: GridLinesVisibility.both,
                source: reportDataSource,
                headerRowHeight: 35,
                rowHeight: 35,
                verticalScrollController: verticalScrollController,
                horizontalScrollController: horizontalScrollController,
                // showHorizontalScrollbar: false,
                // showVerticalScrollbar: false,
                isScrollbarAlwaysShown: true,
                columns: buildColumnsTable(),
                columnWidthMode: ColumnWidthMode.auto,
                selectionMode: SelectionMode.singleDeselect,
                tableSummaryRows: [
                  GridTableSummaryRow(
                    showSummaryInRow: false,
                    color: Colors.blue,
                    columns: [
                      const GridSummaryColumn(
                        name: 'SumTotal',
                        columnName: 'total',
                        summaryType: GridSummaryType.sum,
                      ),
                      ...List.generate(
                        widget.tableModel.dynamicList![1].length,
                        (index) {
                          return GridSummaryColumn(
                            name: 'Sum',
                            columnName: widget.tableModel.dynamicList![1][index]
                                ['Coulumn'],
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
          PaginationWidget(
            allPages: allPages,
            dropdownValue: dropdownValue,
            listNumberItemInList: const [10, 25, 50, 100],
            myPage: numberPage,
            numberOfRecords: widget.tableModel.numberofrecords!,
            onChangeLimit: (limit) {
              setState(() {
                dropdownValue = limit;
                numberPage = 1;
                allPages = (widget.tableModel.numberofrecords! %
                            dropdownValue) ==
                        0
                    ? (widget.tableModel.numberofrecords! ~/ dropdownValue)
                    : (widget.tableModel.numberofrecords! ~/ dropdownValue) + 1;
                reportDataSource = ReportDataSource(
                    tableModel: widget.tableModel,
                    itemsInPage: dropdownValue,
                    numberPage: numberPage);
                horizontalScrollController.jumpTo(0.0);
                verticalScrollController.jumpTo(0.0);
              });
            },
            onTapMin: () {
              setState(() {
                numberPage = numberPage - 1;
                reportDataSource = ReportDataSource(
                    tableModel: widget.tableModel,
                    itemsInPage: dropdownValue,
                    numberPage: numberPage);
                horizontalScrollController.jumpTo(0.0);
                verticalScrollController.jumpTo(0.0);
              });
            },
            onTapAdd: () {
              setState(() {
                numberPage = numberPage + 1;
                reportDataSource = ReportDataSource(
                    tableModel: widget.tableModel,
                    itemsInPage: dropdownValue,
                    numberPage: numberPage);
                horizontalScrollController.jumpTo(0.0);
                verticalScrollController.jumpTo(0.0);
              });
            },
          )
        ],
      ),
    );
  }

  double getTotal(Map<String, dynamic> data) {
    // تصفية القيم من نوع double فقط وجمعها
    double sum = data.values
        .whereType<double>() // تصفية القيم التي تكون من نوع double
        .fold(0.0, (previous, current) => previous + current); // جمع القيم

    return sum;
  }

  buildColumnsTable() {
    return [
      ...List.generate(
        widget.tableModel.listes!.length,
        (index) {
          String title = lang == AppStrings.enLangKey
              ? widget.tableModel.listes![index].enColumnLabel!
              : widget.tableModel.listes![index].arColumnLabel!;
          return GridColumn(
            // width: MediaQuery.of(context).size.width * .4,
            columnName: widget.tableModel.listes![index].columnName!,
            label: Center(child: Text(title, style: AppStyles.textStyle14)),
            // columnWidthMode: ColumnWidthMode.auto,
          );
        },
      ),
      GridColumn(
        // width: MediaQuery.of(context).size.width * .27,
        columnName: 'total',
        label: Center(child: Text('Total', style: AppStyles.textStyle14)),
        // columnWidthMode: ColumnWidthMode.auto,
      ),
      ...List.generate(
        widget.tableModel.dynamicList![1].length,
        (index) {
          return GridColumn(
            // width: MediaQuery.of(context).size.width * .4,
            columnName: widget.tableModel.dynamicList![1][index]['Coulumn'],
            label: Center(
                child: Text(widget.tableModel.dynamicList![1][index]['Coulumn'],
                    style: AppStyles.textStyle14)),
            // columnWidthMode: ColumnWidthMode.auto,
          );
        },
      ),
    ];
  }
}
