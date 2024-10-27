import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

import '../../../../../../../core/utils/app_colors.dart';
import '../../../../../../../core/utils/app_styles.dart';
import '../../../../../../../core/utils/methods.dart';
import '../../../../../../../core/widgets/custom_button.dart';
import '../../../../../../../generated/l10n.dart';
import '../../../../../data/models/dropdown_model/all_dropdown_model.dart';
import '../add_extraction_supplier_table.dart';
import 'tab1_add.dart';

class Tab1 extends StatefulWidget {
  const Tab1(
      {super.key,
      required this.myAllDropdownModelList,
      required this.onTapAction,
      required this.oldData});
  final List<AllDropdownModel> myAllDropdownModelList;
  final void Function(List<Map<String, dynamic>> data) onTapAction;
  final List<Map<String, dynamic>> oldData;

  @override
  State<Tab1> createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
  LinkedScrollControllerGroup controllerGroup = LinkedScrollControllerGroup();
  ScrollController? headerScrollController;
  ScrollController? dataScrollController;
  late List<Map<String, dynamic>> tableListInAddView;
  int indexSelect = -1;
  bool select = false;
  List<String> listHeader = [
    "Product",
    "الكمية",
    "Price",
    "Ratio",
    "Total",
    "Unit",
    "Category",
    "Description"
  ];
  @override
  void initState() {
    headerScrollController = controllerGroup.addAndGet();
    dataScrollController = controllerGroup.addAndGet();
    tableListInAddView = widget.oldData;
    // tableListInEditView = widget.oldTableList;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("التشوينات"),
        Row(
          children: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Tab1Add(
                        myAllDropdownModelList: widget.myAllDropdownModelList,
                        onTapAdd: (newRowData) {
                          tableListInAddView.add(newRowData);
                        },
                      ),
                    );
                  },
                ).then((value) {
                  setState(() {});
                });
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.blue,
              ),
            ),
            IconButton(
              onPressed: () {
                if (indexSelect != -1) {
                  tableListInAddView.removeAt(indexSelect);
                  // widget.onTapAction(tableListInAddView);

                  indexSelect = -1;
                  setState(() {});
                }
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.red,
              ),
            ),
          ],
        ),
        Expanded(
          child: Stack(
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
                  headingRowColor: WidgetStateProperty.all(AppColors.blueLight),
                  columns: [
                    DataColumn(
                      label: Expanded(
                        child: SizedBox(
                          width: 35,
                          child: Text(
                            '',
                            textAlign: TextAlign.center,
                            style: AppStyles.textStyle14,
                          ),
                        ),
                      ),
                    ),
                    ...List.generate(
                      listHeader.length,
                      (index) {
                        return DataColumn(
                          label: Expanded(
                            child: SizedBox(
                              width: 130,
                              child: Text(
                                listHeader[index],
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
                    tableListInAddView.length,
                    (index) {
                      return DataRow(
                        cells: [
                          DataCell(
                            SizedBox(
                                width: 35,
                                child: Checkbox(
                                  value: indexSelect == index ? select : false,
                                  onChanged: (val) {
                                    setState(() {
                                      select = val!;
                                    });
                                    if (indexSelect == index) {
                                      setState(() {
                                        // widget.tableList.removeAt(index);
                                        indexSelect = -1;
                                      });
                                    } else {
                                      setState(() {
                                        // widget.tableList.removeAt(index);
                                        indexSelect = index;
                                      });
                                    }
                                  },
                                )),
                          ),
                          DataCell(
                            SizedBox(
                              width: 130,
                              child: Container(
                                color: indexSelect == index
                                    ? AppColors.blueGreyDark
                                    : Colors.transparent,
                                width: tableListInAddView[index]['Product']
                                            .toString()
                                            .length >
                                        12
                                    ? 100
                                    : null,
                                alignment: Alignment.center,
                                child:
                                    buildMyWidget("dropdown", "Product", index),
                              ),
                            ),
                          ),
                          DataCell(
                            SizedBox(
                              width: 130,
                              child: InkWell(
                                onTap: () {
                                  buildShowDialogText(
                                    context,
                                    text: tableListInAddView[index]['Quantity'],
                                  );
                                },
                                child: Container(
                                  color: indexSelect == index
                                      ? AppColors.blueGreyDark
                                      : Colors.transparent,
                                  width: tableListInAddView[index]['Quantity']
                                              .toString()
                                              .length >
                                          12
                                      ? 100
                                      : null,
                                  alignment: Alignment.center,
                                  child: buildMyWidget(
                                      "number", "Quantity", index),
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            SizedBox(
                              width: 130,
                              child: InkWell(
                                onTap: () {
                                  buildShowDialogText(
                                    context,
                                    text: tableListInAddView[index]['Price'],
                                  );
                                },
                                child: Container(
                                  color: indexSelect == index
                                      ? AppColors.blueGreyDark
                                      : Colors.transparent,
                                  width: tableListInAddView[index]['Price']
                                              .toString()
                                              .length >
                                          12
                                      ? 100
                                      : null,
                                  alignment: Alignment.center,
                                  child:
                                      buildMyWidget("number", "Price", index),
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            SizedBox(
                              width: 130,
                              child: InkWell(
                                onTap: () {
                                  buildShowDialogText(
                                    context,
                                    text: tableListInAddView[index]['Ratio'],
                                  );
                                },
                                child: Container(
                                  color: indexSelect == index
                                      ? AppColors.blueGreyDark
                                      : Colors.transparent,
                                  width: tableListInAddView[index]['Ratio']
                                              .toString()
                                              .length >
                                          12
                                      ? 100
                                      : null,
                                  alignment: Alignment.center,
                                  child:
                                      buildMyWidget("number", "Ratio", index),
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            SizedBox(
                              width: 130,
                              child: InkWell(
                                onTap: () {
                                  buildShowDialogText(
                                    context,
                                    text: tableListInAddView[index]['Total'],
                                  );
                                },
                                child: Container(
                                  color: indexSelect == index
                                      ? AppColors.blueGreyDark
                                      : Colors.transparent,
                                  width: tableListInAddView[index]['Total']
                                              .toString()
                                              .length >
                                          12
                                      ? 100
                                      : null,
                                  alignment: Alignment.center,
                                  child:
                                      buildMyWidget("number", "Total", index),
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            SizedBox(
                              width: 130,
                              child: InkWell(
                                onTap: () {
                                  buildShowDialogText(
                                    context,
                                    text: tableListInAddView[index]['Unit'],
                                  );
                                },
                                child: Container(
                                  color: indexSelect == index
                                      ? AppColors.blueGreyDark
                                      : Colors.transparent,
                                  width: tableListInAddView[index]['Unit']
                                              .toString()
                                              .length >
                                          12
                                      ? 100
                                      : null,
                                  alignment: Alignment.center,
                                  child:
                                      buildMyWidget("dropdown", "Unit", index),
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            SizedBox(
                              width: 130,
                              child: InkWell(
                                onTap: () {
                                  buildShowDialogText(
                                    context,
                                    text: tableListInAddView[index]['Category'],
                                  );
                                },
                                child: Container(
                                  color: indexSelect == index
                                      ? AppColors.blueGreyDark
                                      : Colors.transparent,
                                  width: tableListInAddView[index]['Category']
                                              .toString()
                                              .length >
                                          12
                                      ? 100
                                      : null,
                                  alignment: Alignment.center,
                                  child:
                                      buildMyWidget("text", "Category", index),
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            SizedBox(
                              width: 130,
                              child: InkWell(
                                onTap: () {
                                  buildShowDialogText(
                                    context,
                                    text: tableListInAddView[index]
                                        ['Description'],
                                  );
                                },
                                child: Container(
                                  color: indexSelect == index
                                      ? AppColors.blueGreyDark
                                      : Colors.transparent,
                                  width: tableListInAddView[index]
                                                  ['Description']
                                              .toString()
                                              .length >
                                          12
                                      ? 100
                                      : null,
                                  alignment: Alignment.center,
                                  child: buildMyWidget(
                                      "text", "Description", index),
                                ),
                              ),
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
                  headingRowColor: WidgetStateProperty.all(AppColors.blueLight),
                  columns: [
                    DataColumn(
                      label: Expanded(
                        child: SizedBox(
                          width: 35,
                          child: Text(
                            '',
                            textAlign: TextAlign.center,
                            style: AppStyles.textStyle14,
                          ),
                        ),
                      ),
                    ),
                    ...List.generate(
                      listHeader.length,
                      (index) {
                        return DataColumn(
                          label: InkWell(
                            onTap: () {},
                            child: SizedBox(
                              width: 130,
                              child: Text(
                                listHeader[index],
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
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomButton(
              text: S.of(context).cancel,
              width: 80,
              noGradient: true,
              color: Colors.transparent,
              noShadow: true,
              textStyle: AppStyles.textStyle16.copyWith(color: Colors.grey),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(
              width: 50,
            ),
            CustomButton(
              text: S.of(context).btn_add,
              width: 80,
              onTap: () {
                widget.onTapAction(tableListInAddView);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ],
    );
  }

  buildMyWidget(String type, String key, int indexRow) {
    String data;
    Map<String, dynamic> dataRow = tableListInAddView[indexRow];
    if (dataRow.containsKey(key)) {
      data = dataRow[key].toString();
    } else {
      data = '';
    }

    switch (type) {
      case "date":
        String date = data.isNotEmpty
            ? DateFormat("yyyy-MM-dd", "en")
                .format(DateTime.parse(data).toLocal())
            : '';
        return InkWell(
          onTap: () {
            buildShowDialogText(
              context,
              text: data,
            );
          },
          child: Text(
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            date == "0001-12-31" || date == "0000-12-31" ? '' : date,
            style: TextStyle(
                color: indexSelect == indexRow ? Colors.white : Colors.black),
          ),
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

        if (key == "Product") {
          val = AddExtractionSupplierTable.listProduct.firstWhere(
              (element) => element['ProID'].toString() == data)['ProName'];
        } else if (key == "Unit") {
          for (var i in widget.myAllDropdownModelList[0].list![0].list!) {
            if (i.id.toString() == data) {
              val = i.text ?? '';
            }
          }
        }

        return InkWell(
          onTap: () {
            buildShowDialogText(
              context,
              text: val,
            );
          },
          child: Text(
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            val,
            style: TextStyle(
                color: indexSelect == indexRow ? Colors.white : Colors.black),
          ),
        );
      default:
        return InkWell(
          onTap: () {
            buildShowDialogText(
              context,
              text: data,
            );
          },
          child: Text(
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            data,
            style: TextStyle(
                color: indexSelect == indexRow ? Colors.white : Colors.black),
          ),
        );
    }
  }
}
