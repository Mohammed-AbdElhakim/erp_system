import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../data/models/screen_model.dart';

typedef OnTapHeader<String> = void Function(String titleHeader);
typedef OnTapRow<T> = void Function(T rowData);

class CustomTable extends StatefulWidget {
  const CustomTable({
    super.key,
    required this.listHeader,
    required this.listData,
    required this.listKey,
    required this.paginationWidget,
    required this.onTapHeader,
    required this.listColumn,
    required this.onTapRow,
  });
  final List<String> listHeader;
  final List<dynamic> listData;
  final List<dynamic> listKey;
  final List<ColumnList> listColumn;
  final Widget paginationWidget;
  final OnTapHeader<String> onTapHeader;
  final OnTapRow<Map<String, dynamic>> onTapRow;

  @override
  State<CustomTable> createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  LinkedScrollControllerGroup controllerGroup = LinkedScrollControllerGroup();
  ScrollController? headerScrollController;
  ScrollController? dataScrollController;
  int? indexColorRow;

  @override
  void initState() {
    headerScrollController = controllerGroup.addAndGet();
    dataScrollController = controllerGroup.addAndGet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          //TODO:data
          SingleChildScrollView(
            child: Column(
              children: [
                //TODO:data rows
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: dataScrollController,
                  child: DataTable(
                    columnSpacing: 0,
                    horizontalMargin: 0,
                    dataRowMinHeight: 35,
                    dataRowMaxHeight: 35,
                    headingRowHeight: 35,
                    headingRowColor:
                        MaterialStateProperty.all(AppColors.blueLight),
                    columns: List.generate(
                      widget.listHeader.length,
                      (index) {
                        return DataColumn(
                          label: Expanded(
                            child: SizedBox(
                              width: 100,
                              child: Text(
                                widget.listHeader[index],
                                textAlign: TextAlign.center,
                                style: AppStyles.textStyle14,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    rows: List.generate(
                      widget.listData.length,
                      (index) => DataRow(
                        onLongPress: () {
                          if (indexColorRow == index) {
                            setState(() {
                              indexColorRow = -1;
                            });

                            widget.onTapRow({});
                          } else {
                            setState(() {
                              indexColorRow = index;
                            });

                            widget.onTapRow(widget.listData[index]);
                          }
                        },
                        cells: List.generate(
                          widget.listHeader.length,
                          (i) => DataCell(
                            SizedBox(
                              width: 120,
                              child: InkWell(
                                onTap: widget.listColumn[i].insertType! !=
                                        "date"
                                    ? widget.listData[index]
                                                    ['${widget.listKey[i]}']
                                                .toString()
                                                .length >
                                            12
                                        ? () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => Dialog(
                                                child: InkWell(
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .symmetric(
                                                            horizontal: 16,
                                                            vertical: 32),
                                                    child: Text(
                                                        textAlign:
                                                            TextAlign.center,
                                                        "${widget.listData[index][widget.listKey[i]]}"),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                        : null
                                    : null,
                                child: Container(
                                  color: index == indexColorRow
                                      ? AppColors.blueGreyDark
                                      : Colors.transparent,
                                  width: widget.listData[index]
                                                  ['${widget.listKey[i]}']
                                              .toString()
                                              .length >
                                          12
                                      ? 100
                                      : null,
                                  alignment: Alignment.center,
                                  child: buildMyWidget(
                                      "${widget.listData[index][widget.listKey[i]]}",
                                      widget.listColumn[i].insertType!,
                                      index),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                //TODO:pages
                widget.paginationWidget,
              ],
            ),
          ),
          //TODO:header
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: headerScrollController,
            child: DataTable(
              columnSpacing: 0,
              horizontalMargin: 0,
              dataRowMinHeight: 50,
              dataRowMaxHeight: 50,
              headingRowHeight: 35,
              headingRowColor: MaterialStateProperty.all(AppColors.blueLight),
              columns: List.generate(
                widget.listHeader.length,
                (index) {
                  return DataColumn(
                    label: InkWell(
                      onTap: () {
                        widget
                            .onTapHeader(widget.listColumn[index].columnName!);
                      },
                      child: SizedBox(
                        width: 120,
                        child: Text(
                          widget.listHeader[index],
                          textAlign: TextAlign.center,
                          style: AppStyles.textStyle14,
                        ),
                      ),
                    ),
                  );
                },
              ),
              rows: const [],
            ),
          )
        ],
      ),
    );
  }

  buildMyWidget(String value, String insertType, int indexRow) {
    switch (insertType) {
      case "date":
        String date = value.isNotEmpty
            ? DateFormat("yyyy-MM-dd", 'en').format(DateTime.parse(value))
            : '';
        return Text(
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          date == "0001-12-31" || date == "0000-12-31" ? '' : date,
          style: TextStyle(
              color: indexRow == indexColorRow ? Colors.white : Colors.black),
        );
      case "checkbox":
        if (value == "true") {
          return const Icon(
            Icons.check,
            size: 20,
            color: Colors.green,
          );
        } else if (value == "false") {
          return const Icon(
            Icons.close,
            size: 20,
            color: Colors.red,
          );
        }

      default:
        return Text(
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          value,
          style: TextStyle(
              color: indexRow == indexColorRow ? Colors.white : Colors.black),
        );
    }
  }
}
