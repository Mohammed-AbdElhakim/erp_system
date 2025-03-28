import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:erp_system/features/cashier/presentation/widgets/cashier_view_body.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../../generated/l10n.dart';
import '../../data/models/item_list_setup_model.dart';

typedef OnTapAdd<T> = void Function(T data);

class SalesAlertDialogEditWidget extends StatefulWidget {
  const SalesAlertDialogEditWidget({
    super.key,
    required this.listColumn,
    required this.onTapAdd,
    required this.dataOld,
  });
  final List<ItemListSetupModel> listColumn;
  final OnTapAdd<Map<String, dynamic>> onTapAdd;
  final Map<String, dynamic> dataOld;

  @override
  State<SalesAlertDialogEditWidget> createState() =>
      _SalesAlertDialogEditWidgetState();
}

class _SalesAlertDialogEditWidgetState
    extends State<SalesAlertDialogEditWidget> {
  String? lang;
  GlobalKey<FormState> formKey = GlobalKey();
  Map<String, dynamic> newRowData = {};
  TextEditingController qtyController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController numController = TextEditingController();
  late int customerCategoryID;
  String? dropValue;

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    customerCategoryID = CashierViewBody.listCustomerAccount.firstWhere(
        (element) =>
            element['CustomerAccountID'] ==
            CashierViewBody.userId)['CategoryID'];
    qtyController.text =
        widget.dataOld[widget.listColumn[0].columnName].toString() == "null"
            ? ''
            : widget.dataOld[widget.listColumn[0].columnName].toString();
    priceController.text =
        widget.dataOld[widget.listColumn[1].columnName].toString() == "null"
            ? ''
            : widget.dataOld[widget.listColumn[1].columnName].toString();
    desController.text =
        widget.dataOld[widget.listColumn[2].columnName].toString() == "null"
            ? ''
            : widget.dataOld[widget.listColumn[2].columnName].toString();
    numController.text =
        widget.dataOld[widget.listColumn[4].columnName].toString() == "null"
            ? ''
            : widget.dataOld[widget.listColumn[4].columnName].toString();
    for (var i in CashierViewBody.listProduct) {
      if (i['ProID'].toString() ==
          widget.dataOld[widget.listColumn[3].searchName].toString()) {
        dropValue = i['ProName'] ?? '';
      }
      if (i['ProID'].toString() ==
          widget.dataOld[widget.listColumn[3].searchName].toString()) {
        dropValue = i['ProName'] ?? '';
      }
      if (i['ProID'].toString() ==
          widget.dataOld[widget.listColumn[3].columnName].toString()) {
        dropValue = i['ProName'] ?? '';
      }
      if (i['ProID'].toString() ==
          widget.dataOld[widget.listColumn[3].columnName].toString()) {
        dropValue = i['ProName'] ?? '';
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .75,
      child: Form(
        key: formKey,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //الكمية
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                lang == AppStrings.arLangKey
                                    ? widget.listColumn[0].arColumnLabel!
                                    : widget.listColumn[0].enColumnLabel!,
                                style: AppStyles.textStyle14
                                    .copyWith(color: Colors.grey),
                              ),
                              if (widget.listColumn[0].isRquired! == true)
                                const Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 10,
                                )
                            ],
                          ),
                          CustomTextFormField(
                            hintText: '',
                            controller: qtyController,
                            isValidator: widget.listColumn[0].isRquired!,
                            keyboardType: TextInputType.number,
                            onSaved: (newValue) {
                              if (newValue!.isNotEmpty) {
                                if (widget.dataOld.containsKey(
                                    widget.listColumn[0].columnName)) {
                                  setState(() {
                                    widget.dataOld.updateAll((key, value) =>
                                        key ==
                                                widget.listColumn[0].columnName!
                                                    .toString()
                                            ? value = qtyController.text
                                            : value);
                                    newRowData = widget.dataOld;
                                  });
                                } else {
                                  setState(() {
                                    widget.dataOld[widget
                                        .listColumn[0].columnName!
                                        .toString()] = newValue;
                                    newRowData = widget.dataOld;
                                    // newRowData
                                    //     .addAll({item.columnName!.toString(): newValue});
                                  });
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    //السعر
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                lang == AppStrings.arLangKey
                                    ? widget.listColumn[1].arColumnLabel!
                                    : widget.listColumn[1].enColumnLabel!,
                                style: AppStyles.textStyle14
                                    .copyWith(color: Colors.grey),
                              ),
                              if (widget.listColumn[1].isRquired! == true)
                                const Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 10,
                                )
                            ],
                          ),
                          CustomTextFormField(
                            hintText: '',
                            controller: priceController,
                            isValidator: widget.listColumn[1].isRquired!,
                            keyboardType: TextInputType.number,
                            onSaved: (newValue) {
                              if (newValue!.isNotEmpty) {
                                if (widget.dataOld.containsKey(
                                    widget.listColumn[1].columnName)) {
                                  setState(() {
                                    widget.dataOld.updateAll((key, value) =>
                                        key ==
                                                widget.listColumn[1].columnName!
                                                    .toString()
                                            ? value = priceController.text
                                            : value);
                                    newRowData = widget.dataOld;
                                  });
                                } else {
                                  setState(() {
                                    widget.dataOld[widget
                                        .listColumn[1].columnName!
                                        .toString()] = newValue;
                                    newRowData = widget.dataOld;
                                    // newRowData
                                    //     .addAll({item.columnName!.toString(): newValue});
                                  });
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    //الوصف
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                lang == AppStrings.arLangKey
                                    ? widget.listColumn[2].arColumnLabel!
                                    : widget.listColumn[2].enColumnLabel!,
                                style: AppStyles.textStyle14
                                    .copyWith(color: Colors.grey),
                              ),
                              if (widget.listColumn[2].isRquired! == true)
                                const Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 10,
                                )
                            ],
                          ),
                          CustomTextFormField(
                            hintText: '',
                            controller: desController,
                            isValidator: widget.listColumn[2].isRquired!,
                            keyboardType: TextInputType.text,
                            onSaved: (newValue) {
                              if (newValue!.isNotEmpty) {
                                if (widget.dataOld.containsKey(
                                    widget.listColumn[2].columnName)) {
                                  setState(() {
                                    widget.dataOld.updateAll((key, value) =>
                                        key ==
                                                widget.listColumn[2].columnName!
                                                    .toString()
                                            ? value = desController.text
                                            : value);
                                    newRowData = widget.dataOld;
                                  });
                                } else {
                                  setState(() {
                                    widget.dataOld[widget
                                        .listColumn[2].columnName!
                                        .toString()] = newValue;
                                    newRowData = widget.dataOld;
                                    // newRowData
                                    //     .addAll({item.columnName!.toString(): newValue});
                                  });
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    //المنتج
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                lang == AppStrings.arLangKey
                                    ? widget.listColumn[3].arColumnLabel!
                                    : widget.listColumn[3].enColumnLabel!,
                                style: AppStyles.textStyle14
                                    .copyWith(color: Colors.grey),
                              ),
                              if (widget.listColumn[3].isRquired == true)
                                const Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 10,
                                )
                            ],
                          ),
                          CustomDropdown<String>.search(
                            hintText: '',
                            initialItem: dropValue,
                            closedHeaderPadding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            decoration: CustomDropdownDecoration(
                                headerStyle: AppStyles.textStyle16
                                    .copyWith(color: Colors.black),
                                closedFillColor: Colors.transparent,
                                closedBorder:
                                    Border.all(color: AppColors.blueDark)),
                            items: CashierViewBody.listProduct.isEmpty
                                ? [""]
                                : List.generate(
                                    CashierViewBody.listProduct.length,
                                    (index) =>
                                        CashierViewBody.listProduct[index]
                                            ['ProName'] ??
                                        ''),
                            onChanged: (value) {
                              int proID = CashierViewBody.listProduct
                                  .firstWhere((element) =>
                                      element['ProName'] == value)['ProID'];
                              double productPrice =
                                  CashierViewBody.listProductPrices.firstWhere(
                                        (element) =>
                                            element['ProductID'] == proID &&
                                            element['CustomerCategoryID'] ==
                                                customerCategoryID,
                                        orElse: () => {},
                                      )['Price'] ??
                                      0.0;
                              if (productPrice != 0.0) {
                                priceController.text = productPrice.toString();
                              } else {
                                double price =
                                    CashierViewBody.listProduct.firstWhere(
                                          (element) =>
                                              element["ProID"] == proID,
                                          orElse: () => {},
                                        )['ProPrice'] ??
                                        -1;
                                if (price != -1) {
                                  priceController.text = price.toString();
                                } else {
                                  priceController.text = "";
                                }
                              }

                              newRowData.addAll({
                                widget.listColumn[3].searchName!.toString():
                                    proID
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    //رقم الباتش
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                lang == AppStrings.arLangKey
                                    ? widget.listColumn[4].arColumnLabel!
                                    : widget.listColumn[4].enColumnLabel!,
                                style: AppStyles.textStyle14
                                    .copyWith(color: Colors.grey),
                              ),
                              if (widget.listColumn[4].isRquired! == true)
                                const Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 10,
                                )
                            ],
                          ),
                          CustomTextFormField(
                            hintText: '',
                            controller: numController,
                            isValidator: widget.listColumn[4].isRquired!,
                            keyboardType: TextInputType.text,
                            onSaved: (newValue) {
                              if (newValue!.isNotEmpty) {
                                if (widget.dataOld.containsKey(
                                    widget.listColumn[4].columnName)) {
                                  setState(() {
                                    widget.dataOld.updateAll((key, value) =>
                                        key ==
                                                widget.listColumn[4].columnName!
                                                    .toString()
                                            ? value = numController.text
                                            : value);
                                    newRowData = widget.dataOld;
                                  });
                                } else {
                                  setState(() {
                                    widget.dataOld[widget
                                        .listColumn[4].columnName!
                                        .toString()] = newValue;
                                    newRowData = widget.dataOld;
                                    // newRowData
                                    //     .addAll({item.columnName!.toString(): newValue});
                                  });
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),

                    // ...getMyWidgetList(columnList: widget.listColumn),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                    text: S.of(context).cancel,
                    width: 80,
                    noGradient: true,
                    color: Colors.transparent,
                    noShadow: true,
                    textStyle:
                        AppStyles.textStyle16.copyWith(color: Colors.grey),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  CustomButton(
                    text: S.of(context).btn_edit,
                    width: 80,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();

                        widget.onTapAdd(newRowData);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
