import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../data/models/dropdown_model/all_dropdown_model.dart';
import '../../data/models/item_list_setup_model.dart';
import 'add_view_body.dart';

class CustomTableAdd extends StatefulWidget {
  const CustomTableAdd({
    super.key,
    required this.listHeader,
    required this.listKey,
    required this.listColumn,
    required this.allDropdownModelList,
    required this.pageData,
    required this.tableList,
  });
  final Pages pageData;
  final List<String> listHeader;
  final List<dynamic> listKey;
  final List<ItemListSetupModel> listColumn;
  final List<AllDropdownModel> allDropdownModelList;
  final List<Map<String, dynamic>> tableList;

  @override
  State<CustomTableAdd> createState() => _CustomTableAddState();
}

class _CustomTableAddState extends State<CustomTableAdd> {
  LinkedScrollControllerGroup controllerGroup = LinkedScrollControllerGroup();
  ScrollController? headerScrollController;
  ScrollController? dataScrollController;
  Map<String, dynamic> myObject = {};

  @override
  void initState() {
    headerScrollController = controllerGroup.addAndGet();
    dataScrollController = controllerGroup.addAndGet();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        //*********************** data **************************
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: dataScrollController,
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
              AddViewBody.tableList.length,
              (index) {
                return DataRow(
                  // selected: selectedRows[index],
                  // onSelectChanged: (value) {
                  //   setState(() {
                  //     selectedRows[index] =
                  //         value ?? false; // Update selectedRows list
                  //   });
                  //   if (selectedRows[index] == true) {
                  //     rowsData.add(AddViewBody.tableList[index]);
                  //   } else {
                  //     rowsData.remove(AddViewBody.tableList[index]);
                  //   }
                  // },
                  cells: [
                    ...List.generate(
                      widget.listHeader.length,
                      (i) => DataCell(
                        SizedBox(
                            width: 130,
                            child: buildMyWidget(widget.listColumn[i], index)),
                      ),
                    )
                  ],
                );
              },
            ),
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
                      onTap: () {},
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

  buildMyWidget(ItemListSetupModel columnList, int indexRow) {
    String data;
    Map<String, dynamic> dataRow = AddViewBody.tableList[indexRow];
    if (dataRow.containsKey(columnList.columnName)) {
      data = dataRow[columnList.columnName];
    } else {
      data = '';
    }

    switch (columnList.insertType) {
      case "date":
        String date = data.isNotEmpty
            ? DateFormat("yyyy-MM-dd", "en")
                .format(DateTime.parse(data).toLocal())
            : '';
        return Text(
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          date == "0001-12-31" || date == "0000-12-31" ? '' : date,
        );
      case "checkbox":
        if (data == "true") {
          return const Icon(
            Icons.check,
            size: 20,
            color: Colors.green,
          );
        } else if (data == "false") {
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
            if (item.listName == widget.pageData.listName) {
              listDrop = item.list;
            }
          }

          for (var item in listDrop!) {
            if (item.columnName == columnList.columnName) {
              myListDrop = item.list;
            }
          }
          for (var item in myListDrop!) {
            if (item.id.toString() == data) {
              val = item.text ?? "";
            }
          }
        } else {
          val = data;
        }
        return Text(
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          val,
        );
      default:
        return Text(
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          data,
        );
    }
  }
}
