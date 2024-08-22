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

class SalesFastAlertDialogAddWidget extends StatefulWidget {
  const SalesFastAlertDialogAddWidget({
    super.key,
    required this.listColumn,
    required this.onTapAdd,
    required this.proName,
    this.proId,
  });
  final List<ItemListSetupModel> listColumn;
  final OnTapAdd<Map<String, dynamic>> onTapAdd;
  final String? proName;
  final int? proId;

  @override
  State<SalesFastAlertDialogAddWidget> createState() =>
      _SalesFastAlertDialogAddWidgetState();
}

class _SalesFastAlertDialogAddWidgetState
    extends State<SalesFastAlertDialogAddWidget> {
  String? lang;
  GlobalKey<FormState> formKey = GlobalKey();
  Map<String, dynamic> newRowData = {};
  TextEditingController priceController = TextEditingController();
  late int customerCategoryID;

  @override
  void initState() {
    customerCategoryID = CashierViewBody.listCustomerAccount.firstWhere(
          (element) => element['CustomerAccountID'] == CashierViewBody.userId,
          orElse: () => {"CategoryID": -1},
        )['CategoryID'] ??
        -1;

    saveProIfo();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
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
                            controller: TextEditingController(text: "1"),
                            isValidator: widget.listColumn[0].isRquired!,
                            keyboardType: TextInputType.number,
                            onSaved: (newValue) {
                              // if (newValue!.isNotEmpty) {
                              setState(() {
                                newRowData.addAll({
                                  widget.listColumn[0].columnName!.toString():
                                      newValue!.isEmpty ? "1" : newValue
                                });
                              });
                              // }
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
                                setState(() {
                                  newRowData.addAll({
                                    widget.listColumn[1].columnName!.toString():
                                        newValue
                                  });
                                });
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
                            isValidator: widget.listColumn[2].isRquired!,
                            keyboardType: TextInputType.text,
                            onSaved: (newValue) {
                              // if (newValue!.isNotEmpty) {
                              setState(() {
                                newRowData.addAll({
                                  widget.listColumn[2].columnName!.toString():
                                      newValue!.isEmpty ? "" : newValue
                                });
                              });
                              // }
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
                          Text(
                            lang == AppStrings.arLangKey
                                ? widget.listColumn[3].arColumnLabel!
                                : widget.listColumn[3].enColumnLabel!,
                            style: AppStyles.textStyle14
                                .copyWith(color: Colors.grey),
                          ),
                          Container(
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.blueDark)),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              widget.proName!,
                              textAlign: TextAlign.center,
                              style: AppStyles.textStyle14
                                  .copyWith(color: Colors.black),
                            ),
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
                            isValidator: widget.listColumn[4].isRquired!,
                            keyboardType: TextInputType.text,
                            onSaved: (newValue) {
                              // if (newValue!.isNotEmpty) {
                              setState(() {
                                newRowData.addAll({
                                  widget.listColumn[4].columnName!.toString():
                                      newValue!.isEmpty ? "" : newValue
                                });
                              });
                              // }
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
                    text: S.of(context).btn_add,
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

  void saveProIfo() {
    int proID = CashierViewBody.listProduct
        .firstWhere((element) => element['ProName'] == widget.proName)['ProID'];
    double productPrice = CashierViewBody.listProductPrices.firstWhere(
          (element) =>
              element['ProductID'] == proID &&
              element['CustomerCategoryID'] == customerCategoryID,
          orElse: () => {},
        )['Price'] ??
        0.0;
    if (productPrice != 0.0) {
      priceController.text = productPrice.toString();
    } else {
      double price = CashierViewBody.listProduct.firstWhere(
            (element) => element["ProID"] == proID,
            orElse: () => {},
          )['ProPrice'] ??
          -1;
      if (price != -1) {
        priceController.text = price.toString();
      } else {
        priceController.text = "";
      }
    }

    newRowData.addAll({widget.listColumn[3].searchName!.toString(): proID});
  }
}
