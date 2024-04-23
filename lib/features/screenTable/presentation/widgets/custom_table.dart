import 'package:flutter/material.dart';
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
                    columnSpacing: 30,
                    horizontalMargin: 20,
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
                          widget.onTapRow(widget.listData[index]);
                        },
                        cells: List.generate(
                          widget.listHeader.length,
                          (i) => DataCell(
                            SizedBox(
                              width: 100,
                              child: InkWell(
                                onTap: widget.listData[index]
                                                ['${widget.listKey[i]}']
                                            .toString()
                                            .length >
                                        10
                                    ? () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => Dialog(
                                            child: Container(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .symmetric(
                                                      horizontal: 16,
                                                      vertical: 32),
                                              child: Text(
                                                  "${widget.listData[index][widget.listKey[i]]}"),
                                            ),
                                          ),
                                        );
                                      }
                                    : null,
                                child: Container(
                                  width: widget.listData[index]
                                                  ['${widget.listKey[i]}']
                                              .toString()
                                              .length >
                                          10
                                      ? 100
                                      : null,
                                  alignment: Alignment.center,
                                  child: Text(
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      "${widget.listData[index][widget.listKey[i]]}"),
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
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: headerScrollController,
              child: DataTable(
                columnSpacing: 30,
                horizontalMargin: 20,
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
                          widget.onTapHeader(
                              widget.listColumn[index].columnName!);
                        },
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
                rows: const [],
              ),
            ),
          )
        ],
      ),
    );
  }

  // onTapHeader(ColumnList? value, int numberPage, int limit) {
  //   widget.onTapHeader!(value, numberPage, limit);
  // }
  //
  // onTapAdd(int? value, int limit) {
  //   widget.onTapAdd!(value, limit);
  // }
  //
  // onTapDecrease(int? value, int limit) {
  //   widget.onTapDecrease!(value, limit);
  // }
}
