import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_dropdown_list.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/confirm_attendance_model.dart';
import '../../data/models/project_model.dart';

typedef OnTapRow<T> = void Function(T rowData);

class CustomTableWidget extends StatefulWidget {
  const CustomTableWidget({
    super.key,
    required this.listData,
    required this.listProjects,
    required this.onTapRow,
  });

  final List<ConfirmAttendanceModel> listData;
  final List<ProjectItem> listProjects;

  final OnTapRow<List<Map<String, dynamic>>> onTapRow;

  @override
  State<CustomTableWidget> createState() => _CustomTableWidgetState();
}

class _CustomTableWidgetState extends State<CustomTableWidget> {
  LinkedScrollControllerGroup controllerGroup = LinkedScrollControllerGroup();
  ScrollController? headerScrollController;
  ScrollController? dataScrollController;
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
  void initState() {
    headerScrollController = controllerGroup.addAndGet();
    dataScrollController = controllerGroup.addAndGet();
    for (int i = 0; i < widget.listData.length; i++) {
      selectedRows.add(false); // Initialize selectedRows with false
    }

    tableDataSource = TableDataSource(
      lang: lang,
      data: widget.listData,
      context: context,
      listProjects: widget.listProjects,
      onUpdateSelection: () {
        setState(() {
          rowsData.clear();

          for (var row in dataGridController.selectedRows) {
            final int index = tableDataSource.dataGridRows.indexOf(row);
            if (index >= 0) {
              final model = tableDataSource.data[index];
              final dataMap = {
                "employee": model.employeeNameA,
                "startTime": model.startTime,
                "endTime": model.endTime,
                "project": model.selectedProject?.mID,
                "model": model,
              };

              final existingIndex = rowsData.indexWhere((e) => e["model"] == model);
              if (existingIndex != -1) {
                rowsData[existingIndex] = dataMap;
              } else {
                rowsData.add(dataMap);
              }
            }
          }

          widget.onTapRow(rowsData);
        });
      },
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
            rowHeight: 67,
            controller: dataGridController,
            selectionMode: SelectionMode.multiple,
            verticalScrollController: verticalScrollController,
            horizontalScrollController: horizontalScrollController,
            gridLinesVisibility: GridLinesVisibility.both,
            headerGridLinesVisibility: GridLinesVisibility.both,
            columnWidthMode: ColumnWidthMode.auto,
            isScrollbarAlwaysShown: true,
            footerFrozenRowsCount: 0,
            autoExpandGroups: false,
            columns: [
              GridColumn(
                minimumWidth: 120,
                maximumWidth: 320,
                columnName: "employee",
                label: Center(
                  child: Text(
                    S.of(context).employee,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              GridColumn(
                minimumWidth: 120,
                maximumWidth: 320,
                columnName: "startTime",
                label: Center(
                  child: Text(
                    S.of(context).start_time,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              GridColumn(
                minimumWidth: 120,
                maximumWidth: 320,
                columnName: "endTime",
                label: Center(
                  child: Text(
                    S.of(context).end_time,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              GridColumn(
                width: 200,
                columnName: "project",
                label: Center(
                  child: Text(
                    S.of(context).project,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
            onCellLongPress: (DataGridCellLongPressDetails details) {
              final String columnName = tableDataSource.effectiveRows[details.rowColumnIndex.rowIndex - 1]
                  .getCells()[details.rowColumnIndex.columnIndex]
                  .columnName;

              if (columnName == "employee") {
                final String text = tableDataSource.effectiveRows[details.rowColumnIndex.rowIndex - 1]
                    .getCells()[details.rowColumnIndex.columnIndex]
                    .value;
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
            },
            onSelectionChanged: (addedRows, removedRows) {
              // إزالة الصفوف اللي اتشالت
              for (var row in removedRows) {
                final int index = tableDataSource.dataGridRows.indexOf(row);
                if (index >= 0) {
                  final model = tableDataSource.data[index];
                  rowsData.removeWhere((e) => e["model"] == model);
                }
              }

              // إضافة أو تحديث الصفوف الجديدة
              for (var row in addedRows) {
                final int index = tableDataSource.dataGridRows.indexOf(row);
                if (index >= 0) {
                  final model = tableDataSource.data[index];
                  final dataMap = {
                    "employee": model.employeeNameA,
                    "startTime": model.startTime,
                    "endTime": model.endTime,
                    "project": model.selectedProject?.mID,
                    "model": model,
                  };

                  final existingIndex = rowsData.indexWhere((e) => e["model"] == model);
                  if (existingIndex != -1) {
                    rowsData[existingIndex] = dataMap;
                  } else {
                    rowsData.add(dataMap);
                  }
                }
              }

              widget.onTapRow(rowsData);
            }

            // onSelectionChanged: (addedRows, removedRows) {
            //   rowsData.clear();
            //
            //   for (var row in dataGridController.selectedRows) {
            //     final int index = tableDataSource.dataGridRows.indexOf(row);
            //     if (index >= 0) {
            //       final ConfirmAttendanceModel model = tableDataSource.data[index];
            //
            //       rowsData.add({
            //         "employee": model.employeeNameA,
            //         "startTime": model.startTime,
            //         "endTime": model.endTime,
            //         "project": model.selectedProject?.mID,
            //         "model": model,
            //       });
            //     }
            //   }
            //
            //   widget.onTapRow(rowsData);
            // },
            ),
      ),
    );
  }
}

class TableDataSource extends DataGridSource {
  final BuildContext context;
  final List<ConfirmAttendanceModel> data;
  final String? lang;
  final List<ProjectItem> listProjects;
  final void Function()? onUpdateSelection;

  TableDataSource(
      {required this.context,
      required this.data,
      required this.lang,
      required this.listProjects,
      required this.onUpdateSelection}) {
    dataGridRows = data.asMap().entries.map<DataGridRow>((entry) {
      final e = entry.value;

      return DataGridRow(cells: [
        DataGridCell<String>(columnName: "employee", value: e.employeeNameA),
        DataGridCell<String>(columnName: "startTime", value: e.startTime!),
        DataGridCell<String>(columnName: "endTime", value: e.endTime!),
        DataGridCell<ProjectItem?>(columnName: "project", value: e.selectedProject),
      ]);
    }).toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final int rowIndex = dataGridRows.indexOf(row);
    final model = data[rowIndex];

    TimeOfDay startTime = parseTimeOfDay(row.getCells()[1].value);
    TimeOfDay endTime = parseTimeOfDay(row.getCells()[2].value);
    ProjectItem? selectedProject = row.getCells()[3].value;

    return DataGridRowAdapter(cells: [
      _cell(Text(model.employeeNameA ?? '')),
      _cell(
        StatefulBuilder(
          builder: (context, setState) => GestureDetector(
            onTap: () async {
              final picked = await showTimePicker(
                context: context,
                initialTime: startTime,
              );
              if (picked != null) {
                setState(() {
                  startTime = picked;
                  model.startTime = formatTimeOfDayToFullString(picked);
                  row.getCells()[1] = DataGridCell(columnName: "startTime", value: formatTimeOfDayToFullString(picked));
                });
                onUpdateSelection?.call();
              }
            },
            child: _timeContainer(startTime.format(context)),
          ),
        ),
      ),
      _cell(
        StatefulBuilder(
          builder: (context, setState) => GestureDetector(
            onTap: () async {
              final picked = await showTimePicker(
                context: context,
                initialTime: endTime,
              );
              if (picked != null) {
                setState(() {
                  endTime = picked;
                  model.endTime = formatTimeOfDayToFullString(picked);
                  row.getCells()[2] = DataGridCell(columnName: "endTime", value: formatTimeOfDayToFullString(picked));
                });
                onUpdateSelection?.call();
              }
            },
            child: _timeContainer(endTime.format(context)),
          ),
        ),
      ),
      _cell(
        StatefulBuilder(
          builder: (context, setState) => CustomDropdownList<ProjectItem>(
            listData: listProjects,
            initialDropValue: selectedProject,
            onChanged: (value) {
              setState(() {
                selectedProject = value;
                model.selectedProject = value;
                row.getCells()[3] = DataGridCell(columnName: "project", value: value);
              });
              onUpdateSelection?.call();
            },
          ),
        ),
      ),
    ]);
  }
}

Widget _cell(Widget child) => Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      child: child,
    );

Widget _timeContainer(String text) => Container(
      width: 80,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.blueLight),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(text),
    );

TimeOfDay parseTimeOfDay(String timeString) {
  final parts = timeString.split(':');
  final hour = int.parse(parts[0]);
  final minute = int.parse(parts[1]);
  return TimeOfDay(hour: hour, minute: minute);
}

String formatTimeOfDayToFullString(TimeOfDay time) {
  final now = DateTime.now();
  final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
  return "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:00";
}
