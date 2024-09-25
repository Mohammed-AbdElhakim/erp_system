import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:erp_system/features/screenTable/presentation/widgets/tableSrcPageDetails/purchases/add_purchases.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/models/menu_model/pages.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../data/models/dropdown_model/all_dropdown_model.dart';
import '../../../../data/models/item_list_setup_model.dart';
import '../../../../data/models/tap_model.dart';

typedef OnTapAdd<T> = void Function(T data);

class PurchasesAlertDialogEditWidget extends StatefulWidget {
  const PurchasesAlertDialogEditWidget({
    super.key,
    required this.listHeader,
    required this.listKey,
    required this.listColumn,
    required this.allDropdownModelList,
    required this.pageData,
    this.tapData,
    required this.onTapAdd,
    required this.dataOld,
    required this.typeView,
  });
  final ListTaps? tapData;
  final List<String> listHeader;
  final List<dynamic> listKey;
  final List<ItemListSetupModel> listColumn;
  final List<AllDropdownModel> allDropdownModelList;
  final Pages pageData;
  final OnTapAdd<Map<String, dynamic>> onTapAdd;
  final Map<String, dynamic> dataOld;
  final String typeView;

  @override
  State<PurchasesAlertDialogEditWidget> createState() =>
      _PurchasesAlertDialogEditWidgetState();
}

class _PurchasesAlertDialogEditWidgetState
    extends State<PurchasesAlertDialogEditWidget> {
  String? lang;
  GlobalKey<FormState> formKey = GlobalKey();
  Map<String, dynamic> newRowData = {};
  late List<AllDropdownModel> myAllDropdownModelList;
  late List<ItemDrop>? myListDrop6;
  late List<ItemDrop>? myListDrop7;
  TextEditingController qtyController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController marginController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController qtyBillController = TextEditingController();
  String? dropValue0;
  String? dropValue6;
  String? dropValue7;

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    myAllDropdownModelList = widget.allDropdownModelList;
    myListDrop6 = getDropdownList(widget.listColumn[6]);
    myListDrop7 = getDropdownList(widget.listColumn[7]);
    qtyController.text =
        widget.dataOld[widget.listColumn[1].columnName].toString() == "null"
            ? ''
            : widget.dataOld[widget.listColumn[1].columnName].toString();

    costController.text =
        widget.dataOld[widget.listColumn[2].columnName].toString() == "null"
            ? ''
            : widget.dataOld[widget.listColumn[2].columnName].toString();

    marginController.text =
        widget.dataOld[widget.listColumn[3].columnName].toString() == "null"
            ? ''
            : widget.dataOld[widget.listColumn[3].columnName].toString();

    priceController.text =
        widget.dataOld[widget.listColumn[4].columnName].toString() == "null"
            ? ''
            : widget.dataOld[widget.listColumn[4].columnName].toString();

    qtyBillController.text =
        widget.dataOld[widget.listColumn[5].columnName].toString() == "null"
            ? ''
            : widget.dataOld[widget.listColumn[5].columnName].toString();

    for (var i in AddPurchases.listProduct) {
      if (i['ProID'].toString() ==
          widget.dataOld[widget.listColumn[0].searchName].toString()) {
        dropValue0 = i['ProName'] ?? '';
      }
      if (i['ProID'].toString() ==
          widget.dataOld[widget.listColumn[0].columnName].toString()) {
        dropValue0 = i['ProName'] ?? '';
      }
    }

    for (var i in myListDrop6!) {
      if (i.id == widget.dataOld[widget.listColumn[6].searchName].toString()) {
        dropValue6 = i.text ?? '';
      }
      if (i.id == widget.dataOld[widget.listColumn[6].columnName].toString()) {
        dropValue6 = i.text ?? '';
      }
    }

    for (var i in myListDrop7!) {
      if (i.id == widget.dataOld[widget.listColumn[7].searchName].toString()) {
        dropValue7 = i.text ?? '';
      }
      if (i.id == widget.dataOld[widget.listColumn[7].columnName].toString()) {
        dropValue7 = i.text ?? '';
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
                                    ? widget.listColumn[0].arColumnLabel!
                                    : widget.listColumn[0].enColumnLabel!,
                                style: AppStyles.textStyle14
                                    .copyWith(color: Colors.grey),
                              ),
                              if (widget.listColumn[0].isRquired == true)
                                const Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 10,
                                )
                            ],
                          ),
                          CustomDropdown<String>.search(
                            hintText: '',
                            initialItem: dropValue0,
                            closedHeaderPadding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            decoration: CustomDropdownDecoration(
                                headerStyle: AppStyles.textStyle16
                                    .copyWith(color: Colors.black),
                                closedFillColor: Colors.transparent,
                                closedBorder:
                                    Border.all(color: AppColors.blueDark)),
                            items: AddPurchases.listProduct.isEmpty
                                ? [""]
                                : List.generate(
                                    AddPurchases.listProduct.length,
                                    (index) =>
                                        AddPurchases.listProduct[index]
                                            ['ProName'] ??
                                        ''),
                            onChanged: (value) {
                              if (value!.isNotEmpty) {
                                int proID = AddPurchases.listProduct.firstWhere(
                                    (element) =>
                                        element['ProName'] == value)['ProID'];

                                double price =
                                    AddPurchases.listProduct.firstWhere(
                                          (element) =>
                                              element["ProID"] == proID,
                                          orElse: () => {},
                                        )['ProPrice'] ??
                                        -1;
                                if (price != -1) {
                                  costController.text = price.toString();
                                } else {
                                  costController.text = "";
                                }
                                if (widget.dataOld.containsKey(
                                    widget.listColumn[0].searchName)) {
                                  // setState(() {
                                  widget.dataOld.updateAll((key, value) =>
                                      key ==
                                              widget.listColumn[0].searchName!
                                                  .toString()
                                          ? value = proID
                                          : value);
                                  newRowData = widget.dataOld;
                                  // });
                                } else {
                                  // setState(() {
                                  widget.dataOld[widget
                                      .listColumn[0].columnName!
                                      .toString()] = proID;
                                  newRowData = widget.dataOld;
                                  // });
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
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
                            controller: qtyController,
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
                                            ? value = qtyController.text
                                            : value);
                                    newRowData = widget.dataOld;
                                  });
                                } else {
                                  setState(() {
                                    widget.dataOld[widget
                                        .listColumn[1].columnName!
                                        .toString()] = newValue;
                                    newRowData = widget.dataOld;
                                  });
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    //التكلفة
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
                            controller: costController,
                            isValidator: widget.listColumn[2].isRquired!,
                            keyboardType: TextInputType.number,
                            onSaved: (newValue) {
                              if (newValue!.isNotEmpty) {
                                if (widget.dataOld.containsKey(
                                    widget.listColumn[2].columnName)) {
                                  setState(() {
                                    widget.dataOld.updateAll((key, value) =>
                                        key ==
                                                widget.listColumn[2].columnName!
                                                    .toString()
                                            ? value = costController.text
                                            : value);
                                    newRowData = widget.dataOld;
                                  });
                                } else {
                                  setState(() {
                                    widget.dataOld[widget
                                        .listColumn[2].columnName!
                                        .toString()] = newValue;
                                    newRowData = widget.dataOld;
                                  });
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),

                    //هامش الربح
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
                              if (widget.listColumn[3].isRquired! == true)
                                const Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 10,
                                )
                            ],
                          ),
                          CustomTextFormField(
                            hintText: '',
                            controller: marginController,
                            isValidator: widget.listColumn[3].isRquired!,
                            keyboardType: TextInputType.number,
                            onSaved: (newValue) {
                              if (newValue!.isNotEmpty) {
                                if (widget.dataOld.containsKey(
                                    widget.listColumn[3].columnName)) {
                                  setState(() {
                                    widget.dataOld.updateAll((key, value) =>
                                        key ==
                                                widget.listColumn[3].columnName!
                                                    .toString()
                                            ? value = marginController.text
                                            : value);
                                    newRowData = widget.dataOld;
                                  });
                                } else {
                                  setState(() {
                                    widget.dataOld[widget
                                        .listColumn[3].columnName!
                                        .toString()] = newValue;
                                    newRowData = widget.dataOld;
                                  });
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    //سعر البيع
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
                            controller: priceController,
                            isValidator: widget.listColumn[4].isRquired!,
                            keyboardType: TextInputType.number,
                            onSaved: (newValue) {
                              if (newValue!.isNotEmpty) {
                                if (widget.dataOld.containsKey(
                                    widget.listColumn[4].columnName)) {
                                  setState(() {
                                    widget.dataOld.updateAll((key, value) =>
                                        key ==
                                                widget.listColumn[4].columnName!
                                                    .toString()
                                            ? value = priceController.text
                                            : value);
                                    newRowData = widget.dataOld;
                                  });
                                } else {
                                  setState(() {
                                    widget.dataOld[widget
                                        .listColumn[4].columnName!
                                        .toString()] = newValue;
                                    newRowData = widget.dataOld;
                                  });
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    //الكمية المتبيقه فى الفاتورة
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                lang == AppStrings.arLangKey
                                    ? widget.listColumn[5].arColumnLabel!
                                    : widget.listColumn[5].enColumnLabel!,
                                style: AppStyles.textStyle14
                                    .copyWith(color: Colors.grey),
                              ),
                              if (widget.listColumn[5].isRquired! == true)
                                const Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 10,
                                )
                            ],
                          ),
                          CustomTextFormField(
                            hintText: '',
                            controller: qtyBillController,
                            isValidator: widget.listColumn[5].isRquired!,
                            keyboardType: TextInputType.number,
                            onSaved: (newValue) {
                              if (newValue!.isNotEmpty) {
                                if (widget.dataOld.containsKey(
                                    widget.listColumn[5].columnName)) {
                                  setState(() {
                                    widget.dataOld.updateAll((key, value) =>
                                        key ==
                                                widget.listColumn[5].columnName!
                                                    .toString()
                                            ? value = qtyBillController.text
                                            : value);
                                    newRowData = widget.dataOld;
                                  });
                                } else {
                                  setState(() {
                                    widget.dataOld[widget
                                        .listColumn[5].columnName!
                                        .toString()] = newValue;
                                    newRowData = widget.dataOld;
                                  });
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),

                    //البند الأساسى
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                lang == AppStrings.arLangKey
                                    ? widget.listColumn[6].arColumnLabel!
                                    : widget.listColumn[6].enColumnLabel!,
                                style: AppStyles.textStyle14
                                    .copyWith(color: Colors.grey),
                              ),
                              if (widget.listColumn[6].isRquired == true)
                                const Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 10,
                                )
                            ],
                          ),
                          CustomDropdown<String>.search(
                            hintText: '',
                            initialItem: dropValue6,
                            closedHeaderPadding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            decoration: CustomDropdownDecoration(
                                headerStyle: AppStyles.textStyle16
                                    .copyWith(color: Colors.black),
                                closedFillColor: Colors.transparent,
                                closedBorder:
                                    Border.all(color: AppColors.blueDark)),
                            items: myListDrop6!.isEmpty
                                ? [""]
                                : List.generate(myListDrop6!.length,
                                    (index) => myListDrop6![index].text ?? ''),
                            onChanged: (value) {
                              if (value!.isNotEmpty) {
                                ItemDrop ii = myListDrop6!.firstWhere(
                                    (element) => element.text == value);
                                if (widget.dataOld.containsKey(
                                    widget.listColumn[6].searchName)) {
                                  // setState(() {
                                  widget.dataOld.updateAll((key, value) =>
                                      key ==
                                              widget.listColumn[6].searchName!
                                                  .toString()
                                          ? value = ii.id
                                          : value);
                                  newRowData = widget.dataOld;
                                  // });
                                } else {
                                  // setState(() {
                                  widget.dataOld[widget
                                      .listColumn[6].columnName!
                                      .toString()] = ii.id;
                                  newRowData = widget.dataOld;
                                  // });
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    //البند
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                lang == AppStrings.arLangKey
                                    ? widget.listColumn[7].arColumnLabel!
                                    : widget.listColumn[7].enColumnLabel!,
                                style: AppStyles.textStyle14
                                    .copyWith(color: Colors.grey),
                              ),
                              if (widget.listColumn[7].isRquired == true)
                                const Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size: 10,
                                )
                            ],
                          ),
                          CustomDropdown<String>.search(
                            hintText: '',
                            initialItem: dropValue7,
                            closedHeaderPadding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            decoration: CustomDropdownDecoration(
                                headerStyle: AppStyles.textStyle16
                                    .copyWith(color: Colors.black),
                                closedFillColor: Colors.transparent,
                                closedBorder:
                                    Border.all(color: AppColors.blueDark)),
                            items: myListDrop7!.isEmpty
                                ? [""]
                                : List.generate(myListDrop7!.length,
                                    (index) => myListDrop7![index].text ?? ''),
                            onChanged: (value) {
                              if (value!.isNotEmpty) {
                                ItemDrop ii = myListDrop7!.firstWhere(
                                    (element) => element.text == value);
                                if (widget.dataOld.containsKey(
                                    widget.listColumn[7].searchName)) {
                                  // setState(() {
                                  widget.dataOld.updateAll((key, value) =>
                                      key ==
                                              widget.listColumn[7].searchName!
                                                  .toString()
                                          ? value = ii.id
                                          : value);
                                  newRowData = widget.dataOld;
                                  // });
                                } else {
                                  // setState(() {
                                  widget.dataOld[widget
                                      .listColumn[7].columnName!
                                      .toString()] = ii.id;
                                  newRowData = widget.dataOld;
                                  // });
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
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

  List<ItemDrop>? getDropdownList(ItemListSetupModel listColumn) {
    List<ListDrop>? listDrop = [];
    List<ItemDrop>? myListDrop = [];

    for (var ii in myAllDropdownModelList) {
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
      if (ii.columnName == listColumn.columnName) {
        myListDrop = ii.list;
      }
    }
    return myListDrop;
  }
}
