import 'package:erp_system/features/cashier/presentation/widgets/cashier_view_body.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../core/utils/methods.dart';
import '../../data/models/item_list_setup_model.dart';
import '../../data/models/product_model.dart';
import 'sales_alert_dialog_edit_widget.dart';

typedef OnTapAction<T> = void Function(T data);

class SalesTableAddEdit extends StatefulWidget {
  const SalesTableAddEdit({
    super.key,
    required this.listHeader,
    required this.listColumn,
    required this.onTapAction,
    required this.onTapRow,
    required this.allProductList,
  });
  final List<String> listHeader;
  final List<ItemListSetupModel> listColumn;
  final OnTapAction<List<Map<String, dynamic>>> onTapAction;
  final void Function(int selectRow) onTapRow;
  final List<ProductItem> allProductList;

  static String barcode = '';

  @override
  State<SalesTableAddEdit> createState() => _SalesTableAddEditState();
}

class _SalesTableAddEditState extends State<SalesTableAddEdit> {
  LinkedScrollControllerGroup controllerGroup = LinkedScrollControllerGroup();
  ScrollController? headerScrollController;
  ScrollController? dataScrollController;
  Map<String, dynamic> myObject = {};
  // late List<Map<String, dynamic>> tableListInAddView;
  late int customerCategoryID;
  late int productId;
  late String proName;
  late double proPrice;

  int indexSelect = -1;
  bool select = false;

  @override
  void initState() {
    // tableListInAddView = CashierViewBody.tableList;
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
    return Column(
      children: [
        Row(
          children: [
            //مكان آخر لاضافه منتج عن طريق الشاشة
            // IconButton(
            //   onPressed: () {
            //     showDialog(
            //       context: context,
            //       builder: (context) {
            //         return AlertDialog(
            //           content: SalesAlertDialogAddWidget(
            //             listColumn: widget.listColumn,
            //             onTapAdd: (data) {
            //               CashierViewBody.tableList.add(data);
            //               widget.onTapAction(CashierViewBody.tableList);
            //             },
            //           ),
            //         );
            //       },
            //     ).then((value) {
            //       setState(() {});
            //     });
            //   },
            //   icon: const Icon(
            //     Icons.add,
            //     color: Colors.white,
            //   ),
            //   style: IconButton.styleFrom(
            //     backgroundColor: AppColors.blue,
            //   ),
            // ),
            //مكان آخر لاضافه منتج عن طريق الباركود
            // IconButton(
            //   onPressed: () async {
            //     final resultScanner = await Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => const BarcodeView(),
            //         ));
            //
            //     if (!context.mounted) return;
            //
            //     getDataPro(resultScanner);
            //
            //     Map<String, dynamic> proData = {
            //       "ProductID": productId,
            //       "Qty": "1",
            //       "PriceCurrancy": "$proPrice",
            //       "systemDescription": "",
            //       "BatchNumber": "",
            //     };
            //     if (CashierViewBody.tableList.isEmpty) {
            //       CashierViewBody.tableList.add(proData);
            //       widget.onTapAction(CashierViewBody.tableList);
            //     } else {
            //       Map<String, dynamic> data =
            //           CashierViewBody.tableList.firstWhere(
            //         (element) => element['ProductID'] == proData['ProductID'],
            //         orElse: () => {},
            //       );
            //       if (data.isEmpty) {
            //         CashierViewBody.tableList.add(proData);
            //         widget.onTapAction(CashierViewBody.tableList);
            //       } else {
            //         data['Qty'] = (int.parse(data['Qty']) + 1).toString();
            //         // element['PriceCurrancy'] =
            //         //     (proPrice * int.parse(element['Qty'])).toString();
            //         widget.onTapAction(CashierViewBody.tableList);
            //       }
            //     }
            //   },
            //   icon: const Icon(
            //     Icons.barcode_reader,
            //     color: Colors.white,
            //   ),
            //   style: IconButton.styleFrom(
            //     backgroundColor: AppColors.green,
            //   ),
            // ),
            IconButton(
              onPressed: () {
                if (indexSelect != -1) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: SalesAlertDialogEditWidget(
                          listColumn: widget.listColumn,
                          onTapAdd: (data) {
                            CashierViewBody.tableList.removeAt(indexSelect);
                            CashierViewBody.tableList.insert(indexSelect, data);
                            indexSelect = -1;
                            widget.onTapAction(CashierViewBody.tableList);
                          },
                          dataOld: CashierViewBody.tableList[indexSelect],
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
                  CashierViewBody.tableList.removeAt(indexSelect);
                  widget.onTapAction(CashierViewBody.tableList);
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
                  CashierViewBody.tableList.length,
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
                                      widget.onTapRow(-1);
                                    });
                                  } else {
                                    setState(() {
                                      // widget.tableList.removeAt(index);
                                      indexSelect = index;
                                      widget.onTapRow(index);
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
                                          text: CashierViewBody.tableList[index]
                                              [widget.listColumn[i].columnName],
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
    Map<String, dynamic> dataRow = CashierViewBody.tableList[indexRow];
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
        for (var element in widget.allProductList) {
          if (element.proID.toString() == data) {
            val = element.proName ?? "";
          }
        }

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

  void getDataPro(String resultScanner) {
    productId = CashierViewBody.listBarcodeData.firstWhere(
      (element) => element['BarcodeProc'] == resultScanner /*"11961"*/,
      orElse: () => {"ProductId": -1},
    )['ProductId'];

    customerCategoryID = CashierViewBody.listCustomerAccount.firstWhere(
        (element) =>
            element['CustomerAccountID'] ==
            CashierViewBody.userId)['CategoryID'];

    double productPrice = CashierViewBody.listProductPrices.firstWhere(
          (element) =>
              element['ProductID'] == productId &&
              element['CustomerCategoryID'] == customerCategoryID,
          orElse: () => {},
        )['Price'] ??
        0.0;
    if (productPrice != 0.0) {
      proPrice = productPrice;
      proName = CashierViewBody.listProduct.firstWhere(
            (element) => element["ProID"] == productId,
            orElse: () => {},
          )['ProName'] ??
          "";
    } else {
      double price = CashierViewBody.listProduct.firstWhere(
            (element) => element["ProID"] == productId,
            orElse: () => {},
          )['ProPrice'] ??
          -1;
      if (price != -1) {
        proPrice = price;
        proName = CashierViewBody.listProduct.firstWhere(
              (element) => element["ProID"] == productId,
              orElse: () => {},
            )['ProName'] ??
            "";
      }
    }
  }
}
