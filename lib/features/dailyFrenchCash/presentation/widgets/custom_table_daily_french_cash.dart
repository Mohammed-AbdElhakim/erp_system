import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../data/models/daily_french_cash_model.dart';
import 'data_source_daily_french_cash.dart';

class CustomTableDailyFrenchCash extends StatefulWidget {
  const CustomTableDailyFrenchCash(
      {super.key, required this.dailyFrenchCashModel, required this.creditOrDepit});
  final DailyFrenchCashModel dailyFrenchCashModel;
  final bool creditOrDepit;

  @override
  State<CustomTableDailyFrenchCash> createState() => _CustomTableDailyFrenchCashState();
}

class _CustomTableDailyFrenchCashState extends State<CustomTableDailyFrenchCash> {
  ScrollController verticalScrollController = ScrollController();
  ScrollController horizontalScrollController = ScrollController();
  String? lang;
  late List<Columns> columns1;
  late List<Columns> columns2;
  late DataSourceDailyFrenchCash dataSourceDailyFrenchCash;
  final DataGridController controller = DataGridController();

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    columns1 = widget.dailyFrenchCashModel.columns!
        .where(
          (element) => element.creditORDepit == widget.creditOrDepit,
        )
        .toList();
    columns2 = widget.dailyFrenchCashModel.columns!
        .where(
          (element) => element.creditORDepit == !(widget.creditOrDepit),
        )
        .toList();
    dataSourceDailyFrenchCash = DataSourceDailyFrenchCash(
      dataList: widget.dailyFrenchCashModel.list!,
      columns1: columns1,
      columns2: columns2,
      totalAll: widget.dailyFrenchCashModel.totalAll!,
      totalEntry: widget.dailyFrenchCashModel.totalEntry!,
      totalAccount: widget.dailyFrenchCashModel.totalAccount!,
      itemList: widget.dailyFrenchCashModel.toJson()['list'],
      controller: controller,
      context: context,
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
          selectionColor: AppColors.blueGreyDark.withAlpha(90),
          // indentColumnWidth: 0,
        ),
        child: SfDataGrid(
          source: dataSourceDailyFrenchCash,
          headerRowHeight: 35,
          rowHeight: 35,
          selectionMode: SelectionMode.singleDeselect,
          verticalScrollController: verticalScrollController,
          horizontalScrollController: horizontalScrollController,
          gridLinesVisibility: GridLinesVisibility.both,
          headerGridLinesVisibility: GridLinesVisibility.both,
          columnWidthMode: ColumnWidthMode.auto,
          isScrollbarAlwaysShown: true,
          controller: controller,
          columns: buildColumns(),
          onCellLongPress: (DataGridCellLongPressDetails details) {
            onLongPressOnCell(details, context);
          },
          stackedHeaderRows: <StackedHeaderRow>[buildCustomStackedHeaderRow()],
          tableSummaryRows: buildTableSummaryRows(),
        ),
      ),
    );
  }

  List<GridTableSummaryRow> buildTableSummaryRows() {
    return [
      GridTableSummaryRow(
        showSummaryInRow: false,
        columns: [
          const GridSummaryColumn(
            name: 'Sum Date',
            columnName: "EDate",
            summaryType: GridSummaryType.sum,
          ),
          const GridSummaryColumn(
            name: 'Sum Description',
            columnName: "EDescription",
            summaryType: GridSummaryType.sum,
          ),
          const GridSummaryColumn(
            name: 'Sum Total',
            columnName: "ETotal",
            summaryType: GridSummaryType.sum,
          ),
          ...List.generate(
            columns1.length,
            (index) {
              String columnName =
                  "${columns1[index].acName} ${columns1[index].accountID} ${columns1[index].creditORDepit}";

              return GridSummaryColumn(
                name: 'Sum $columnName',
                columnName: columnName,
                summaryType: GridSummaryType.sum,
              );
            },
          ),
          const GridSummaryColumn(
            name: 'Sum Space',
            columnName: "space",
            summaryType: GridSummaryType.sum,
          ),
          ...List.generate(
            columns2.length,
            (index) {
              String columnName =
                  "${columns2[index].acName} ${columns2[index].accountID} ${columns2[index].creditORDepit}";

              return GridSummaryColumn(
                name: 'Sum $columnName',
                columnName: columnName,
                summaryType: GridSummaryType.sum,
              );
            },
          ),
        ],
        position: GridTableSummaryRowPosition.bottom,
      ),
    ];
  }

  void onLongPressOnCell(DataGridCellLongPressDetails details, BuildContext context) {
    final String text = dataSourceDailyFrenchCash
        .effectiveRows[details.rowColumnIndex.rowIndex - 2]
        .getCells()[details.rowColumnIndex.columnIndex]
        .value
        .toString();

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
  }

  List<GridColumn> buildColumns() {
    return [
      GridColumn(
        minimumWidth: 120,
        maximumWidth: 320,
        columnName: "EDate",
        label: ColoredBox(
          color: AppColors.blue,
          child: const Center(
            child: Text(
              "التاريخ",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      GridColumn(
        minimumWidth: 120,
        maximumWidth: 320,
        columnName: "EDescription",
        label: ColoredBox(
          color: AppColors.blue,
          child: const Center(
            child: Text(
              "البيان",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      GridColumn(
        minimumWidth: 120,
        maximumWidth: 320,
        columnName: "ETotal",
        label: ColoredBox(
          color: AppColors.blue,
          child: const Center(
            child: Text(
              "الاجمالي",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      ...List.generate(
        columns1.length,
        (index) {
          String columnName =
              "${columns1[index].acName} ${columns1[index].accountID} ${columns1[index].creditORDepit}";
          String title = columns1[index].acName!;
          return GridColumn(
            minimumWidth: 120,
            maximumWidth: 320,
            columnName: columnName,
            label: ColoredBox(
              color: AppColors.blueLight,
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
      GridColumn(
          width: 20,
          columnName: "space",
          label: ColoredBox(color: Colors.grey.shade300, child: const SizedBox())),
      ...List.generate(
        columns2.length,
        (index) {
          String columnName =
              "${columns2[index].acName} ${columns2[index].accountID} ${columns2[index].creditORDepit}";
          String title = columns2[index].acName!;
          return GridColumn(
            minimumWidth: 120,
            maximumWidth: 320,
            columnName: columnName,
            label: ColoredBox(
              color: AppColors.blueGreyDark,
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      )
    ];
  }

  buildCustomStackedHeaderRow() {
    return StackedHeaderRow(cells: [
      StackedHeaderCell(
          columnNames: columns1
              .map((item) => "${item.acName} ${item.accountID} ${item.creditORDepit}")
              .toList(),
          child: Container(
              color: Colors.yellowAccent,
              alignment: AlignmentDirectional.centerStart,
              padding: const EdgeInsetsDirectional.only(start: 12),
              child: Text(widget.creditOrDepit ? 'من مذكورين' : 'الى مذكورين',
                  style: AppStyles.textStyle14.copyWith(color: Colors.black)))),
      StackedHeaderCell(
          columnNames: ["space"],
          child: ColoredBox(color: Colors.grey.shade300, child: const SizedBox())),
      StackedHeaderCell(
          columnNames: columns2
              .map((item) => "${item.acName} ${item.accountID} ${item.creditORDepit}")
              .toList(),
          child: Container(
              color: Colors.yellowAccent,
              alignment: AlignmentDirectional.centerStart,
              padding: const EdgeInsetsDirectional.only(start: 12),
              child: Text(widget.creditOrDepit ? 'من مذكورين' : 'الى مذكورين',
                  style: AppStyles.textStyle14.copyWith(color: Colors.black)))),
    ]);
  }
}
