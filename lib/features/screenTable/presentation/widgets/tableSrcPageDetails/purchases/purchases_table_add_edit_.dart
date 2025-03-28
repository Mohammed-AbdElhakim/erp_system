import 'package:erp_system/features/screenTable/presentation/widgets/tableSrcPageDetails/purchases/add_purchases.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

import '../../../../../../core/models/menu_model/pages.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/utils/methods.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../data/models/dropdown_model/all_dropdown_model.dart';
import '../../../../data/models/item_list_setup_model.dart';
import '../../../../data/models/tap_model.dart';
import '../../../views/barcode_view.dart';
import '../../../views/screen_table.dart';
import 'edit_purchases.dart';
import 'purchases_alert_dialog_add_widget.dart';
import 'purchases_alert_dialog_edit_widget.dart';

typedef OnTapAction<T> = void Function(T data);

class PurchasesTableAddEdit extends StatefulWidget {
  const PurchasesTableAddEdit({
    super.key,
    required this.listHeader,
    required this.listKey,
    required this.listColumn,
    required this.allDropdownModelList,
    required this.pageData,
    this.tapData,
    required this.onTapAction,
    required this.oldTableList,
    required this.typeView,
  });
  final ListTaps? tapData;
  final Pages pageData;
  final List<String> listHeader;
  final List<dynamic> listKey;
  final List<ItemListSetupModel> listColumn;
  final List<AllDropdownModel> allDropdownModelList;
  final List<Map<String, dynamic>> oldTableList;
  final OnTapAction<List<Map<String, dynamic>>> onTapAction;
  final String typeView;

  static String barcode = '';

  @override
  State<PurchasesTableAddEdit> createState() => _PurchasesTableAddEditState();
}

class _PurchasesTableAddEditState extends State<PurchasesTableAddEdit> {
  LinkedScrollControllerGroup controllerGroup = LinkedScrollControllerGroup();
  ScrollController? headerScrollController;
  ScrollController? dataScrollController;
  Map<String, dynamic> myObject = {};
  List<Map<String, dynamic>> tableListInAddView = [];
  late List<Map<String, dynamic>> tableListInEditView;
  late int customerCategoryID;
  late int productId;
  late String proName;
  late double proPrice;

  int indexSelect = -1;
  bool select = false;
  @override
  void initState() {
    headerScrollController = controllerGroup.addAndGet();
    dataScrollController = controllerGroup.addAndGet();

    tableListInEditView = widget.oldTableList;

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: PurchasesAlertDialogAddWidget(
                        typeView: widget.typeView,
                        tapData: widget.tapData,
                        listKey: widget.listKey,
                        listHeader: widget.listHeader,
                        listColumn: widget.listColumn,
                        allDropdownModelList:
                            ScreenTable.myAllDropdownModelList,
                        pageData: widget.pageData,
                        onTapAdd: (data) {
                          if (widget.typeView == "Add") {
                            tableListInAddView.add(data);
                            widget.onTapAction(tableListInAddView);
                          } else if (widget.typeView == "Edit") {
                            tableListInEditView.add(data);
                            widget.onTapAction(tableListInEditView);
                          }
                        },
                      ),
                    );
                  },
                );
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
              onPressed: () async {
                final resultScanner = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BarcodeView(),
                    ));
                // result = "11961";
                if (!context.mounted) return;

                // ScaffoldMessenger.of(context)
                //   ..removeCurrentSnackBar()
                //   ..showSnackBar(SnackBar(
                //     content: Text('$resultScanner'),
                //     duration: const Duration(seconds: 2),
                //   ));

                getDataPro(widget.typeView, resultScanner);
                if (productId == -1) {
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content: Text(S.of(context).product_not_available),
                      duration: const Duration(seconds: 5),
                    ));
                } else {
                  Map<String, dynamic> proData = {
                    "ProductID": productId, //المنتج
                    "MaintemTreeId": "",
                    "ItemsTreeId": "",
                    "Quntity": "1",
                    "CostCurrancy": "$proPrice",
                    "ProfitMargin": "",
                    "SellingPrice": "",
                    "RemainingQuantity": "",
                  };
                  if (widget.typeView == "Add") {
                    if (tableListInAddView.isEmpty) {
                      tableListInAddView.add(proData);
                      widget.onTapAction(tableListInAddView);
                    } else {
                      Map<String, dynamic> data = tableListInAddView.firstWhere(
                        (element) =>
                            element['ProductID'] == proData['ProductID'],
                        orElse: () => {},
                      );
                      if (data.isEmpty) {
                        tableListInAddView.add(proData);
                        widget.onTapAction(tableListInAddView);
                      } else {
                        data['Qty'] = (int.parse(data['Qty']) + 1).toString();
                        // element['PriceCurrancy'] =
                        //     (proPrice * int.parse(element['Qty'])).toString();
                        widget.onTapAction(tableListInAddView);
                      }
                    }
                  } else if (widget.typeView == "Edit") {
                    if (tableListInEditView.isEmpty) {
                      tableListInEditView.add(proData);
                      widget.onTapAction(tableListInEditView);
                    } else {
                      Map<String, dynamic> data =
                          tableListInEditView.firstWhere(
                        (element) =>
                            element['ProductID'] == proData['ProductID'],
                        orElse: () => {},
                      );
                      if (data.isEmpty) {
                        tableListInEditView.add(proData);
                        widget.onTapAction(tableListInEditView);
                      } else {
                        data['Qty'] = (int.parse(data['Qty']) + 1).toString();
                        // element['PriceCurrancy'] =
                        //     (proPrice * int.parse(element['Qty'])).toString();
                        widget.onTapAction(tableListInEditView);
                      }
                    }
                  }
                }
              },
              icon: const Icon(
                Icons.barcode_reader,
                color: Colors.white,
              ),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.green,
              ),
            ),
            IconButton(
              onPressed: () {
                if (indexSelect != -1) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: PurchasesAlertDialogEditWidget(
                          typeView: widget.typeView,
                          tapData: widget.tapData,
                          listKey: widget.listKey,
                          listHeader: widget.listHeader,
                          listColumn: widget.listColumn,
                          allDropdownModelList:
                              ScreenTable.myAllDropdownModelList,
                          pageData: widget.pageData,
                          onTapAdd: (data) {
                            if (widget.typeView == "Add") {
                              tableListInAddView.removeAt(indexSelect);
                              tableListInAddView.insert(indexSelect, data);
                              indexSelect = -1;
                              widget.onTapAction(tableListInAddView);
                            } else if (widget.typeView == "Edit") {
                              tableListInEditView.removeAt(indexSelect);
                              tableListInEditView.insert(indexSelect, data);
                              indexSelect = -1;
                              widget.onTapAction(tableListInEditView);
                            }
                          },
                          dataOld: widget.typeView == "Add"
                              ? tableListInAddView[indexSelect]
                              : tableListInEditView[indexSelect],
                        ),
                      );
                    },
                  ).then((value) {
                    setState(() {});
                  });
                }
              },
              icon: const Icon(
                Icons.edit_note,
                color: Colors.white,
              ),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.blueGreyDark,
              ),
            ),
            IconButton(
              onPressed: () {
                if (indexSelect != -1) {
                  if (widget.typeView == "Add") {
                    tableListInAddView.removeAt(indexSelect);
                    widget.onTapAction(tableListInAddView);
                  } else if (widget.typeView == "Edit") {
                    tableListInEditView.removeAt(indexSelect);
                    widget.onTapAction(tableListInEditView);
                  }
                  // widget.typeView == "Add"
                  //     ? tableListInAddView.removeAt(indexSelect)
                  //     : tableListInEditView.removeAt(indexSelect);
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
        Stack(
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
                  widget.typeView == "Add"
                      ? tableListInAddView.length
                      : tableListInEditView.length,
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
                        ...List.generate(
                          widget.listHeader.length,
                          (i) => DataCell(
                            SizedBox(
                              width: 130,
                              child: InkWell(
                                onTap: widget.listColumn[i].insertType! !=
                                        "date"
                                    ? () {
                                        buildShowDialogText(
                                          context,
                                          text: widget.typeView == "Add"
                                              ? tableListInAddView[index][widget
                                                  .listColumn[i].columnName]
                                              : tableListInEditView[index][
                                                  widget.listColumn[i]
                                                      .columnName],
                                        );
                                      }
                                    : null,
                                child: Container(
                                  color: indexSelect == index
                                      ? AppColors.blueGreyDark
                                      : Colors.transparent,
                                  width:
                                      widget.listColumn[i].toString().length >
                                              12
                                          ? 100
                                          : null,
                                  alignment: Alignment.center,
                                  child: buildMyWidget(
                                      widget.listColumn[i], index),
                                ),
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
        ),
      ],
    );
  }

  buildMyWidget(ItemListSetupModel columnList, int indexRow) {
    String data;
    Map<String, dynamic> dataRow = widget.typeView == "Add"
        ? tableListInAddView[indexRow]
        : tableListInEditView[indexRow];
    if (dataRow.containsKey(columnList.columnName)) {
      data = dataRow[columnList.columnName].toString();
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
          style: TextStyle(
              color: indexSelect == indexRow ? Colors.white : Colors.black),
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
        List<ListDrop>? listDrop = [];
        List<ItemDrop>? myListDrop = [];

        for (var ii in widget.allDropdownModelList) {
          if (widget.tapData == null) {
            if (ii.listName == widget.pageData.listName) {
              listDrop = ii.list;
            }
          } else {
            if (ii.listName == widget.tapData!.listName) {
              listDrop = ii.list;
            }
          }
        }
        for (var ii in listDrop!) {
          if (ii.columnName == columnList.columnName &&
              ii.nameAr == columnList.arColumnLabel) {
            myListDrop = ii.list;
          }
        }
        for (var element in myListDrop!) {
          if (element.id.toString() == data) {
            val = element.text ?? "";
          }
        }
        // if (widget.typeView == "Add") {
        //   for (var element in AddPurchases.listProduct) {
        //     if (element['ProID'].toString() == data) {
        //       val = element['ProName'] ?? "";
        //     }
        //   }
        // } else {
        //   for (var element in EditPurchases.listProduct) {
        //     if (element['ProID'].toString() == data) {
        //       val = element['ProName'] ?? "";
        //     }
        //   }
        // }

        return Text(
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          val,
          style: TextStyle(
              color: indexSelect == indexRow ? Colors.white : Colors.black),
        );
      default:
        return Text(
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          data,
          style: TextStyle(
              color: indexSelect == indexRow ? Colors.white : Colors.black),
        );
    }
  }

  void getDataPro(String type, String resultScanner) {
    if (type == "Add") {
      productId = AddPurchases.listBarcodeData.firstWhere(
        (element) => element['BarcodeProc'] == resultScanner /*"11961"*/,
        orElse: () => {"ProductId": -1},
      )['ProductId'];

      double price = AddPurchases.listProduct.firstWhere(
            (element) => element["ProID"] == productId,
            orElse: () => {},
          )['ProPrice'] ??
          -1;
      if (price != -1) {
        proPrice = price;
        proName = AddPurchases.listProduct.firstWhere(
              (element) => element["ProID"] == productId,
              orElse: () => {},
            )['ProName'] ??
            "";
      }
    } else {
      productId = EditPurchases.listBarcodeData.firstWhere(
        (element) => element['BarcodeProc'] == resultScanner,
        orElse: () => {"ProductId": -1},
      )['ProductId'];

      double price = EditPurchases.listProduct.firstWhere(
            (element) => element["ProID"] == productId,
            orElse: () => {},
          )['ProPrice'] ??
          -1;
      if (price != -1) {
        proPrice = price;
        proName = EditPurchases.listProduct.firstWhere(
              (element) => element["ProID"] == productId,
              orElse: () => {},
            )['ProName'] ??
            "";
      }
    }
  }
}
