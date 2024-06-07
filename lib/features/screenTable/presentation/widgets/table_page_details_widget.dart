import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/methods.dart';
import '../../data/models/dropdown_model/all_dropdown_model.dart';
import '../../data/models/screen_model.dart';
import '../../data/models/tap_model.dart';

typedef OnTapHeader<String> = void Function(String titleHeader);

// typedef OnTapRow<T> = void Function(T rowData);
class TablePageDetailsWidget extends StatefulWidget {
  const TablePageDetailsWidget({
    super.key,
    required this.listHeader,
    required this.listData,
    this.listSum,
    required this.listKey,
    required this.listColumn,
    required this.allDropdownModelList,
    required this.tap,
    required this.paginationWidget,
    required this.onTapHeader,
  });
  final Widget paginationWidget;
  final ListTaps tap;
  final List<String> listHeader;
  final List<dynamic> listData;
  final List<dynamic>? listSum;
  final List<dynamic> listKey;
  final List<ColumnList> listColumn;
  final List<AllDropdownModel> allDropdownModelList;
  final OnTapHeader<String> onTapHeader;
  // final OnTapRow<List<Map<String, dynamic>>> onTapRow;

  @override
  State<TablePageDetailsWidget> createState() => _TablePageDetailsWidgetState();
}

class _TablePageDetailsWidgetState extends State<TablePageDetailsWidget> {
  LinkedScrollControllerGroup controllerGroup = LinkedScrollControllerGroup();
  ScrollController? headerScrollController;
  ScrollController? dataScrollController;
  ScrollController? sumScrollController;

  @override
  void initState() {
    headerScrollController = controllerGroup.addAndGet();
    dataScrollController = controllerGroup.addAndGet();
    sumScrollController = controllerGroup.addAndGet();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        //*********************** data **************************
        SingleChildScrollView(
          child: Column(
            children: [
              //********************** data rows ********************
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: dataScrollController,
                child: DataTable(
                  columnSpacing: 0,
                  horizontalMargin: 15,
                  dataRowMinHeight: 35,
                  dataRowMaxHeight: 35,
                  headingRowHeight: 35,
                  headingRowColor:
                      MaterialStateProperty.all(AppColors.blueLight),
                  columns: [
                    ...List.generate(
                      widget.listHeader.length,
                      (index) {
                        return DataColumn(
                          label: Expanded(
                            child: SizedBox(
                              width: 130,
                              child: Text(
                                widget.listHeader[index],
                                textAlign: TextAlign.center,
                                style: AppStyles.textStyle14,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                  rows: List.generate(
                    widget.listData.length,
                    (index) => DataRow(
                      cells: [
                        ...List.generate(
                          widget.listHeader.length,
                          (i) => DataCell(
                            SizedBox(
                              width: 130,
                              child: InkWell(
                                onTap:
                                    widget.listColumn[i].insertType! != "date"
                                        ? () {
                                            buildShowDialog(
                                              context,
                                              text:
                                                  "${widget.listData[index][widget.listKey[i]]}",
                                              listName: widget.tap.listName,
                                              columnList: widget.listColumn[i],
                                              allDropdownModelList:
                                                  widget.allDropdownModelList,
                                            );
                                          }
                                        : null,
                                child: Container(
                                  color: Colors.transparent,
                                  width: widget.listData[index]
                                                  ['${widget.listKey[i]}']
                                              .toString()
                                              .length >
                                          12
                                      ? 100
                                      : null,
                                  alignment: Alignment.center,
                                  child: buildMyWidget(
                                      "${widget.listData[index][widget.listKey[i]] ?? ""}",
                                      widget.listColumn[i],
                                      index),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              //********************* Sum ***********************
              if (widget.listSum!.isNotEmpty)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: sumScrollController,
                  child: DataTable(
                    columnSpacing: 0,
                    horizontalMargin: 15,
                    dataRowMinHeight: 50,
                    dataRowMaxHeight: 50,
                    headingRowHeight: 35,
                    headingRowColor:
                        MaterialStateProperty.all(AppColors.blueLight),
                    columns: List.generate(
                      widget.listHeader.length,
                      (index) {
                        return DataColumn(
                          label: InkWell(
                            onTap: () {
                              buildShowDialog(
                                context,
                                text: widget.listSum![0][widget.listKey[index]]
                                    .toString(),
                                allDropdownModelList:
                                    widget.allDropdownModelList,
                                listName: widget.tap.listName,
                              );
                            },
                            child: SizedBox(
                              width: 130,
                              child: Text(
                                widget.listSum![0][widget.listKey[index]] ==
                                        null
                                    ? ""
                                    : widget.listSum![0][widget.listKey[index]]
                                        .toString(),
                                // widget.listHeader[index],
                                textAlign: TextAlign.center,
                                style: AppStyles.textStyle14,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    rows: const [],
                  ),
                ),
              //********************* pages *********************
              widget.paginationWidget,
            ],
          ),
        ),
        //********************* header **********************
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: headerScrollController,
          child: DataTable(
            columnSpacing: 0,
            horizontalMargin: 15,
            dataRowMinHeight: 50,
            dataRowMaxHeight: 50,
            headingRowHeight: 35,
            headingRowColor: MaterialStateProperty.all(AppColors.blueLight),
            columns: [
              ...List.generate(
                widget.listHeader.length,
                (index) {
                  return DataColumn(
                    label: InkWell(
                      onTap: () {
                        widget
                            .onTapHeader(widget.listColumn[index].columnName!);
                      },
                      child: SizedBox(
                        width: 130,
                        child: Text(
                          widget.listHeader[index],
                          textAlign: TextAlign.center,
                          style: AppStyles.textStyle14,
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
            rows: const [],
          ),
        )
      ],
    );
  }

  buildMyWidget(String value, ColumnList columnList, int indexRow) {
    switch (columnList.insertType) {
      case "date":
        String date = value.isNotEmpty
            ? DateFormat("yyyy-MM-dd", "en")
                .format(DateTime.parse(value).toLocal())
            : '';
        return Text(
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          date == "0001-12-31" || date == "0000-12-31" ? '' : date,
          style: const TextStyle(color: Colors.black),
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
      case "dropdown":
        String val = '';
        if (columnList.columnName == columnList.searchName) {
          List<ListDrop>? listDrop = [];
          List<ItemDrop>? myListDrop = [];
          for (var item in widget.allDropdownModelList) {
            if (item.listName == widget.tap.listName) {
              listDrop = item.list;
            }
          }

          for (var item in listDrop!) {
            if (item.columnName == columnList.columnName) {
              myListDrop = item.list;
            }
          }
          for (var item in myListDrop!) {
            if (item.id.toString() == value) {
              val = item.text ?? "";
            }
          }
        } else {
          val = value;
        }
        return Text(
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          val,
          style: const TextStyle(color: Colors.black),
        );
      default:
        return Text(
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          value,
          style: const TextStyle(color: Colors.black),
        );
    }
  }
}
