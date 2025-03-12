import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/constants.dart';
import '../../data/models/report_model.dart';
import '../../data/models/table_model.dart';
import '../../data/models/xy.dart';
import '../manager/tableReport/table_report_cubit.dart';
import 'area_chart.dart';
import 'bar_chart.dart';
import 'column_chart.dart';
import 'doughnut_chart.dart';
import 'line_chart.dart';
import 'pagination_widget.dart';
import 'pie_chart.dart';
import 'radial_bar_chart.dart';
import 'report_data_source.dart';

class TableReportsViewBody extends StatefulWidget {
  const TableReportsViewBody(
      {super.key,
      required this.tableModel,
      required this.pageData,
      required this.reportModel});
  final TableModel tableModel;
  final Pages pageData;
  final ReportModel reportModel;
  static SfDataGrid? mySfDataGrid;

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
  late List<XY> dataList;
  int dropdownValue = 10;
  int numberPage = 1;
  bool isChart = false;
  ChartType chartType = ChartType.column;
  late List listDataShow;

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
      numberPage: numberPage,
      context: context,
      pageData: widget.pageData,
      title:
          lang == AppStrings.enLangKey ? widget.pageData.nameEn : widget.pageData.nameAr,
    );
    listDataShow = removeDuplicates(
        originalList: widget.tableModel.dynamicList[0],
        keys: widget.tableModel.listes.map((item) => item.columnName as String).toList());
    allPages = (listDataShow.length % dropdownValue) == 0
        ? (listDataShow.length ~/ dropdownValue)
        : (listDataShow.length ~/ dropdownValue) + 1;
    dataList = getDataList(widget.tableModel);
  }

  @override
  Widget build(BuildContext context) {
    TableReportsViewBody.mySfDataGrid = SfDataGrid(
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
      stackedHeaderRows: <StackedHeaderRow>[buildCustomStackedHeaderRow()],
      onCellLongPress: (DataGridCellLongPressDetails details) {
        final String value = reportDataSource
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
      tableSummaryRows: [
        GridTableSummaryRow(
          showSummaryInRow: false,
          color: Colors.blue,
          columns: [
            if (widget.tableModel.data!.sowHSum == true)
              ...List.generate(
                widget.tableModel.arabicLableAggrigate.length,
                (index) {
                  return GridSummaryColumn(
                    name:
                        'Sum ${widget.tableModel.arabicLableAggrigate[index].columnName!}',
                    columnName: widget.tableModel.arabicLableAggrigate[index].columnName!,
                    summaryType: GridSummaryType.sum,
                  );
                },
              ),
            ...List.generate(
              widget.tableModel.dynamicList[1].length *
                  widget.tableModel.arabicLableAggrigate.length,
              (index) {
                return GridSummaryColumn(
                  name: 'Sum ${getTitle(
                    index: index,
                    dynamicList: widget.tableModel.dynamicList[1],
                    arabicLableAggrigate: widget.tableModel.arabicLableAggrigate,
                  )}',
                  columnName: getTitle(
                      index: index,
                      dynamicList: widget.tableModel.dynamicList[1],
                      arabicLableAggrigate: widget.tableModel.arabicLableAggrigate),
                  summaryType: GridSummaryType.sum,
                );
              },
            )
          ],
          position: GridTableSummaryRowPosition.bottom,
        ),
      ],
    );
    return Expanded(
      child: Scaffold(
        body: isChart == false ? buildTableWidget(context) : buildChartWidget(),
        floatingActionButton: SpeedDial(
          backgroundColor: AppColors.blueLight,
          overlayOpacity: 0.5,
          activeIcon: Icons.close,
          iconTheme: IconThemeData(color: AppColors.white),
          buttonSize: const Size(50, 50),
          curve: Curves.easeIn,
          childrenButtonSize: const Size(50, 50),
          children: [
            SpeedDialChild(
                elevation: 0,
                backgroundColor: AppColors.orange,
                shape: const CircleBorder(),
                child: Icon(
                  Icons.refresh,
                  color: AppColors.white,
                ),
                onTap: () {
                  BlocProvider.of<TableReportCubit>(context)
                      .getTableReport(reportId: widget.reportModel.id!);
                }),
            SpeedDialChild(
                elevation: 0,
                backgroundColor: AppColors.blueLight,
                shape: const CircleBorder(),
                child: Icon(
                  isChart == false ? Icons.stacked_bar_chart : Icons.table_view,
                  color: AppColors.white,
                ),
                onTap: () {
                  setState(() {
                    isChart = !isChart;
                  });
                })
          ],
          child: Icon(
            Icons.settings,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  Column buildTableWidget(BuildContext context) {
    return Column(
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
            child: TableReportsViewBody.mySfDataGrid!,
          ),
        ),
        PaginationWidget(
          allPages: allPages,
          dropdownValue: dropdownValue,
          listNumberItemInList: const [10, 25, 50, 100],
          myPage: numberPage,
          numberOfRecords: listDataShow.length,
          onChangeLimit: (limit) {
            setState(() {
              dropdownValue = limit;
              numberPage = 1;
              allPages = (listDataShow.length % dropdownValue) == 0
                  ? (listDataShow.length ~/ dropdownValue)
                  : (listDataShow.length ~/ dropdownValue) + 1;
              reportDataSource = ReportDataSource(
                tableModel: widget.tableModel,
                itemsInPage: dropdownValue,
                numberPage: numberPage,
                context: context,
                pageData: widget.pageData,
                title: lang == AppStrings.enLangKey
                    ? widget.pageData.nameEn
                    : widget.pageData.nameAr,
              );
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
                numberPage: numberPage,
                context: context,
                pageData: widget.pageData,
                title: lang == AppStrings.enLangKey
                    ? widget.pageData.nameEn
                    : widget.pageData.nameAr,
              );
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
                numberPage: numberPage,
                context: context,
                pageData: widget.pageData,
                title: lang == AppStrings.enLangKey
                    ? widget.pageData.nameEn
                    : widget.pageData.nameAr,
              );
              horizontalScrollController.jumpTo(0.0);
              verticalScrollController.jumpTo(0.0);
            });
          },
        )
      ],
    );
  }

  Card buildChartWidget() {
    return Card(
      color: Colors.grey.shade200,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Row(
                children: [
                  Text(widget.tableModel.data!.reportName!),
                  const Spacer(),
                  PopupMenuButton(
                    onSelected: (value) {
                      setState(() {
                        chartType = value;
                      });
                    },
                    itemBuilder: (BuildContext context) => listMenu,
                  ),
                ],
              ),
            ),
            if (chartType == ChartType.column)
              ColumnChart(
                dataList: dataList,
                title: widget.tableModel.data!.reportName!,
              ),
            if (chartType == ChartType.bar)
              BarChart(
                dataList: dataList,
                title: widget.tableModel.data!.reportName!,
              ),
            if (chartType == ChartType.area)
              AreaChart(
                dataList: dataList,
                title: widget.tableModel.data!.reportName!,
              ),
            if (chartType == ChartType.line)
              LineChart(
                dataList: dataList,
                title: widget.tableModel.data!.reportName!,
              ),
            if (chartType == ChartType.pie)
              PieChart(
                dataList: dataList,
              ),
            if (chartType == ChartType.doughnut)
              DoughnutChart(
                dataList: dataList,
              ),
            if (chartType == ChartType.radialBar)
              RadialBarChart(
                dataList: dataList,
              ),
          ],
        ),
      ),
    );
  }

  buildColumnsTable() {
    return [
      ...List.generate(
        widget.tableModel.listes.length,
        (index) {
          String title = lang == AppStrings.enLangKey
              ? widget.tableModel.listes[index].enColumnLabel!
              : widget.tableModel.listes[index].arColumnLabel!;
          return GridColumn(
            // width: MediaQuery.of(context).size.width * .4,
            columnName: widget.tableModel.listes[index].columnName!,
            label: GestureDetector(
                onLongPress: () {
                  if (title.isNotEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text(
                            title,
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    );
                  }
                },
                child: Center(child: Text(title, style: AppStyles.textStyle14))),
            // columnWidthMode: ColumnWidthMode.auto,
          );
        },
      ),
      if (widget.tableModel.data!.sowHSum == true)
        ...List.generate(
          widget.tableModel.arabicLableAggrigate.length,
          (index) {
            String title = lang == AppStrings.enLangKey
                ? widget.tableModel.arabicLableAggrigate[index].enColumnLabel!
                : widget.tableModel.arabicLableAggrigate[index].arColumnLabel!;
            return GridColumn(
              // width: MediaQuery.of(context).size.width * .27,
              // maximumWidth: 100,
              minimumWidth: 90,
              columnName: widget.tableModel.arabicLableAggrigate[index].columnName!,
              label: GestureDetector(
                  onLongPress: () {
                    if (title.isNotEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text(
                              title,
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                      );
                    }
                  },
                  child: Center(child: Text(title, style: AppStyles.textStyle14))),
              // columnWidthMode: ColumnWidthMode.auto,
            );
          },
        ),
      ...List.generate(
        widget.tableModel.dynamicList[1].length *
            widget.tableModel.arabicLableAggrigate.length,
        (index) {
          String title = lang == AppStrings.enLangKey
              ? widget
                  .tableModel
                  .arabicLableAggrigate[getIndex(
                      index: index,
                      arabicLableAggrigate: widget.tableModel.arabicLableAggrigate)]
                  .enColumnLabel!
              : widget
                  .tableModel
                  .arabicLableAggrigate[getIndex(
                      index: index,
                      arabicLableAggrigate: widget.tableModel.arabicLableAggrigate)]
                  .arColumnLabel!;
          return GridColumn(
            // width: MediaQuery.of(context).size.width * .27,
            // width: 30,
            maximumWidth: 150,
            minimumWidth: 90,

            columnName: getTitle(
                index: index,
                dynamicList: widget.tableModel.dynamicList[1],
                arabicLableAggrigate: widget.tableModel.arabicLableAggrigate),
            label: GestureDetector(
                onLongPress: () {
                  if (title.isNotEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text(
                            title,
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    );
                  }
                },
                child: Center(child: Text(title, style: AppStyles.textStyle14))),
            // columnWidthMode: ColumnWidthMode.auto,
          );
        },
      ),
    ];
  }

  List<PopupMenuEntry<ChartType>> listMenu = const [
    PopupMenuItem(
      value: ChartType.column,
      child: Text("Column"),
    ),
    PopupMenuItem(
      value: ChartType.bar,
      child: Text("Bar"),
    ),
    PopupMenuItem(
      value: ChartType.area,
      child: Text("Area"),
    ),
    PopupMenuItem(
      value: ChartType.line,
      child: Text("Line"),
    ),
    PopupMenuItem(
      value: ChartType.pie,
      child: Text("Pie"),
    ),
    PopupMenuItem(
      value: ChartType.doughnut,
      child: Text("Doughnut"),
    ),
    PopupMenuItem(
      value: ChartType.radialBar,
      child: Text("Radial bar"),
    ),
  ];

  List<XY> getDataList(TableModel tableModel) {
    List<XY> data = [];
    for (Map<String, dynamic> i in tableModel.dynamicList[1]) {
      for (Map<String, dynamic> j in tableModel.dynamicList[0]) {
        if (j[i["Coulumn"]] != null) {
          data.add(XY(x: i["Coulumn"], y: j[i["Coulumn"]]));
        } else {
          data.add(XY(x: i["Coulumn"], y: 0));
        }
      }
    }
    return data;
  }

  getTitle(
      {required int index,
      required List dynamicList,
      required List<ArabicLableAggrigate> arabicLableAggrigate}) {
    String title1 = dynamicList[(index ~/ arabicLableAggrigate.length)]['Coulumn'];
    String title2 =
        arabicLableAggrigate[(index % arabicLableAggrigate.length)].columnName!;
    return "$title1$spaceBetweenWords$title2";
  }

  getIndex(
      {required int index, required List<ArabicLableAggrigate> arabicLableAggrigate}) {
    return (index % arabicLableAggrigate.length);
  }

  StackedHeaderRow buildCustomStackedHeaderRow() {
    return StackedHeaderRow(cells: [
      if (widget.tableModel.data!.sowHSum == true)
        StackedHeaderCell(
            columnNames: widget.tableModel.arabicLableAggrigate
                .map((item) => item.columnName as String)
                .toList(),
            text: 'Total',
            child: Center(child: Text('Total', style: AppStyles.textStyle14))),
      ...List.generate(
        widget.tableModel.dynamicList[1].length,
        (index) {
          return StackedHeaderCell(
              columnNames: getTitleForStackedHeader(
                  index: index,
                  dynamicList: widget.tableModel.dynamicList[1],
                  arabicLableAggrigate: widget.tableModel.arabicLableAggrigate),
              text: widget.tableModel.dynamicList[1][index]['Coulumn'],
              child: GestureDetector(
                onLongPress: () {
                  if (widget.tableModel.dynamicList[1][index]['Coulumn'].isNotEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text(
                            widget.tableModel.dynamicList[1][index]['Coulumn'],
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    );
                  }
                },
                child: Center(
                    child: Text(widget.tableModel.dynamicList[1][index]['Coulumn'],
                        style: AppStyles.textStyle14)),
              ));
        },
      ),
    ]);
  }

  getTitleForStackedHeader(
      {required int index,
      required List dynamicList,
      required List<ArabicLableAggrigate> arabicLableAggrigate}) {
    List<String> list = [];

    for (var i2 in arabicLableAggrigate) {
      list.add('${dynamicList[index]['Coulumn']}$spaceBetweenWords${i2.columnName}');
    }

    return list;
  }

  List removeDuplicates({required List originalList, required List<String> keys}) {
    final uniqueItems = <String, Map<String, dynamic>>{};

    for (var item in originalList) {
      // نكوّن المفتاح بناءً على القيم لكل مفتاح موجود في القائمة keys
      String key = keys.map((k) => item[k].toString()).join('_');

      if (!uniqueItems.containsKey(key)) {
        uniqueItems[key] = item;
      }
    }

    return uniqueItems.values.toList();
  }
}

enum ChartType { column, bar, area, line, pie, doughnut, radialBar }
