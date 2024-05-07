import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/methods.dart';
import '../../../../core/utils/service_locator.dart';
import '../../data/models/dropdown_model/dropdown_model.dart';
import '../../data/models/screen_model.dart';
import '../../data/repositories/screen_repo_impl.dart';
import '../manager/getDropdownList/get_dropdown_list_cubit.dart';

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
    this.listSum,
  });
  final List<String> listHeader;
  final List<dynamic> listData;
  final List<dynamic>? listSum;
  final List<dynamic> listKey;
  final List<ColumnList> listColumn;
  final Widget paginationWidget;
  final OnTapHeader<String> onTapHeader;
  final OnTapRow<List<Map<String, dynamic>>> onTapRow;

  @override
  State<CustomTable> createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  LinkedScrollControllerGroup controllerGroup = LinkedScrollControllerGroup();
  ScrollController? headerScrollController;
  ScrollController? dataScrollController;
  ScrollController? sumScrollController;
  // int? indexColorRow;
  List<bool> selectedRows = [];
  List<Map<String, dynamic>> rowsData = [];

  @override
  void initState() {
    headerScrollController = controllerGroup.addAndGet();
    dataScrollController = controllerGroup.addAndGet();
    sumScrollController = controllerGroup.addAndGet();
    for (int i = 0; i < widget.listData.length; i++) {
      selectedRows.add(false); // Initialize selectedRows with false
    }
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
                    horizontalMargin: 15,
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
                    ),
                    rows: List.generate(
                      widget.listData.length,
                      (index) => DataRow(
                        // onLongPress: () {
                        //   if (indexColorRow == index) {
                        //     setState(() {
                        //       indexColorRow = -1;
                        //     });
                        //
                        //     widget.onTapRow({});
                        //   } else {
                        //     setState(() {
                        //       indexColorRow = index;
                        //     });
                        //
                        //     widget.onTapRow(widget.listData[index]);
                        //   }
                        // },
                        selected: selectedRows[index],
                        onSelectChanged: (value) {
                          setState(() {
                            selectedRows[index] =
                                value ?? false; // Update selectedRows list
                          });
                          if (selectedRows[index] == true) {
                            rowsData.add(widget.listData[index]);

                            widget.onTapRow(rowsData);
                          } else {
                            rowsData.remove(widget.listData[index]);

                            widget.onTapRow(rowsData);
                          }
                        },
                        cells: List.generate(
                          widget.listHeader.length,
                          (i) => DataCell(
                            SizedBox(
                              width: 130,
                              child: InkWell(
                                onTap:
                                    widget.listColumn[i].insertType! != "date"
                                        ? widget.listData[index]
                                                        ['${widget.listKey[i]}']
                                                    .toString()
                                                    .length >
                                                12
                                            ? () {
                                                buildShowDialog(context,
                                                    text:
                                                        "${widget.listData[index][widget.listKey[i]]}");
                                              }
                                            : null
                                        : null,
                                child: Container(
                                  color: selectedRows[index] == true
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
                                      widget.listColumn[i],
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
                //TODO:Sum
                if (widget.listSum!.isNotEmpty)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: sumScrollController,
                    child: DataTable(
                      columnSpacing: 0,
                      horizontalMargin: 48,
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
                                if (widget.listSum![0][widget.listKey[index]]
                                        .toString()
                                        .length >
                                    12) {
                                  buildShowDialog(context,
                                      text: widget.listSum![0]
                                              [widget.listKey[index]]
                                          .toString());
                                }
                              },
                              child: SizedBox(
                                width: 130,
                                child: Text(
                                  widget.listSum![0][widget.listKey[index]] ==
                                          null
                                      ? ""
                                      : widget.listSum![0]
                                              [widget.listKey[index]]
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
              horizontalMargin: 48,
              dataRowMinHeight: 50,
              dataRowMaxHeight: 50,
              headingRowHeight: 35,
              headingRowColor: MaterialStateProperty.all(AppColors.blueLight),
              columns: List.generate(
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
              ),
              rows: const [],
            ),
          )
        ],
      ),
    );
  }

  buildMyWidget(String value, ColumnList columnList, int indexRow) {
    switch (columnList.insertType) {
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
              color:
                  selectedRows[indexRow] == true ? Colors.white : Colors.black),
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

        return BlocProvider(
          create: (context) => GetDropdownListCubit(getIt.get<ScreenRepoImpl>())
            ..getDropdownList(
              droModel: columnList.droModel ?? "",
              droValue: columnList.droValue ?? "",
              droText: columnList.droText ?? "",
              droCondition: columnList.droCondition ?? "",
              droCompany: columnList.droCompany ?? "",
            ),
          child: BlocBuilder<GetDropdownListCubit, GetDropdownListState>(
            builder: (context, state) {
              if (state is GetDropdownListSuccess) {
                List<ListDropdownModel> dropListData = [];
                dropListData.addAll(state.dropdownModel.list!);
                for (var item in dropListData) {
                  if (item.value.toString() == value) {
                    val = item.text ?? "";
                  }
                }
                return Text(
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  val,
                  style: TextStyle(
                      color: selectedRows[indexRow] == true
                          ? Colors.white
                          : Colors.black),
                );
              } else {
                return Text(
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  '',
                  style: TextStyle(
                      color: selectedRows[indexRow] == true
                          ? Colors.white
                          : Colors.black),
                );
              }
            },
          ),
        );
      default:
        return Text(
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          value,
          style: TextStyle(
              color:
                  selectedRows[indexRow] == true ? Colors.white : Colors.black),
        );
    }
  }
}
