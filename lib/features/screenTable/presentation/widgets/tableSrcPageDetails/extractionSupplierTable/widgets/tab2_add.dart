import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/utils/app_colors.dart';
import '../../../../../../../core/utils/app_styles.dart';
import '../../../../../../../core/widgets/custom_button.dart';
import '../../../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../../../generated/l10n.dart';
import '../../../../../data/models/dropdown_model/all_dropdown_model.dart';

class Tab2Add extends StatefulWidget {
  const Tab2Add(
      {super.key,
      required this.myAllDropdownModelList,
      required this.onTapAdd});
  final List<AllDropdownModel> myAllDropdownModelList;
  final void Function(Map<String, dynamic> newRowData) onTapAdd;
  @override
  State<Tab2Add> createState() => _Tab2AddState();
}

class _Tab2AddState extends State<Tab2Add> {
  GlobalKey<FormState> formKey = GlobalKey();
  Map<String, dynamic> newRowData = {};
  late List<AllDropdownModel> myAllDropdownModelList;

  TextEditingController qtyController = TextEditingController();
  TextEditingController addsValueController = TextEditingController();
  TextEditingController totalController = TextEditingController();

  @override
  void initState() {
    myAllDropdownModelList = widget.myAllDropdownModelList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .65,
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
                    //البند
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "اسم البند",
                            style: AppStyles.textStyle14
                                .copyWith(color: Colors.grey),
                          ),
                          CustomDropdown<String>.search(
                            hintText: '',
                            closedHeaderPadding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            decoration: CustomDropdownDecoration(
                                headerStyle: AppStyles.textStyle16
                                    .copyWith(color: Colors.black),
                                closedFillColor: Colors.transparent,
                                closedBorder:
                                    Border.all(color: AppColors.blueDark)),
                            items: widget.myAllDropdownModelList[0].list![8]
                                    .list!.isEmpty
                                ? [""]
                                : List.generate(
                                    widget.myAllDropdownModelList[0].list![8]
                                        .list!.length,
                                    (index) =>
                                        widget.myAllDropdownModelList[0]
                                            .list![8].list![index].text ??
                                        ''),
                            onChanged: (value) {
                              String proID = widget
                                  .myAllDropdownModelList[0].list![8].list!
                                  .firstWhere(
                                      (element) => element.text == value)
                                  .id!;

                              newRowData.addAll({"PantName": proID});
                            },
                          ),
                        ],
                      ),
                    ),
                    //AddsValue
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "addsValue",
                            style: AppStyles.textStyle14
                                .copyWith(color: Colors.grey),
                          ),
                          CustomTextFormField(
                            hintText: '',
                            keyboardType: TextInputType.number,
                            controller: addsValueController,
                            isValidator: false,
                            onChanged: (newValue) {
                              setState(() {
                                totalController.text = (double.parse(
                                            newValue.isEmpty ? "0" : newValue) *
                                        double.parse(qtyController.text.isEmpty
                                            ? "0"
                                            : qtyController.text))
                                    .toString();
                              });
                            },
                            onSaved: (newValue) {
                              // if (newValue!.isNotEmpty) {
                              setState(() {
                                newRowData.addAll({
                                  "AddsValue": newValue!.isEmpty ? "" : newValue
                                });
                              });
                              // }
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
                          Text(
                            "الكمية",
                            style: AppStyles.textStyle14
                                .copyWith(color: Colors.grey),
                          ),
                          CustomTextFormField(
                            hintText: '',
                            keyboardType: TextInputType.number,
                            controller: qtyController,
                            isValidator: false,
                            onChanged: (newValue) {
                              setState(() {
                                totalController.text = (double.parse(
                                            newValue.isEmpty ? "0" : newValue) *
                                        double.parse(
                                            addsValueController.text.isEmpty
                                                ? "0"
                                                : addsValueController.text))
                                    .toString();
                              });
                            },
                            onSaved: (newValue) {
                              // if (newValue!.isNotEmpty) {
                              setState(() {
                                newRowData.addAll({
                                  "Quantity": newValue!.isEmpty ? "" : newValue
                                });
                              });
                              // }
                            },
                          ),
                        ],
                      ),
                    ),

                    //Ratio
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ratio",
                            style: AppStyles.textStyle14
                                .copyWith(color: Colors.grey),
                          ),
                          CustomTextFormField(
                            hintText: '',
                            keyboardType: TextInputType.number,
                            isValidator: false,
                            onSaved: (newValue) {
                              // if (newValue!.isNotEmpty) {
                              setState(() {
                                newRowData.addAll({
                                  "Ratio": newValue!.isEmpty ? "" : newValue
                                });
                              });
                              // }
                            },
                          ),
                        ],
                      ),
                    ),
                    //Total
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total",
                            style: AppStyles.textStyle14
                                .copyWith(color: Colors.grey),
                          ),
                          CustomTextFormField(
                            hintText: '',
                            readOnly: true,
                            isBorder: false,
                            isValidator: false,
                            controller: totalController,
                            onSaved: (newValue) {
                              // if (newValue!.isNotEmpty) {
                              setState(() {
                                newRowData.addAll({
                                  "Total": newValue!.isEmpty ? "" : newValue
                                });
                              });
                              // }
                            },
                          ),
                        ],
                      ),
                    ),
                    //الوحده
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Unit",
                            style: AppStyles.textStyle14
                                .copyWith(color: Colors.grey),
                          ),
                          CustomDropdown<String>.search(
                            hintText: '',
                            closedHeaderPadding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            decoration: CustomDropdownDecoration(
                                headerStyle: AppStyles.textStyle16
                                    .copyWith(color: Colors.black),
                                closedFillColor: Colors.transparent,
                                closedBorder:
                                    Border.all(color: AppColors.blueDark)),
                            items: widget.myAllDropdownModelList[0].list![0]
                                    .list!.isEmpty
                                ? [""]
                                : List.generate(
                                    widget.myAllDropdownModelList[0].list![0]
                                        .list!.length,
                                    (index) =>
                                        widget.myAllDropdownModelList[0]
                                            .list![0].list![index].text ??
                                        ''),
                            onChanged: (value) {
                              String proID = widget
                                  .myAllDropdownModelList[0].list![0].list!
                                  .firstWhere(
                                      (element) => element.text == value)
                                  .id!;

                              newRowData.addAll({"Unit": proID});
                            },
                          ),
                        ],
                      ),
                    ),
                    //Description
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Description",
                            style: AppStyles.textStyle14
                                .copyWith(color: Colors.grey),
                          ),
                          CustomTextFormField(
                            hintText: '',
                            isValidator: false,
                            onSaved: (newValue) {
                              // if (newValue!.isNotEmpty) {
                              setState(() {
                                newRowData.addAll({
                                  "Description":
                                      newValue!.isEmpty ? "" : newValue
                                });
                              });
                              // }
                            },
                          ),
                        ],
                      ),
                    ),
                    //Category
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Category",
                            style: AppStyles.textStyle14
                                .copyWith(color: Colors.grey),
                          ),
                          CustomTextFormField(
                            hintText: '',
                            isValidator: false,
                            onSaved: (newValue) {
                              // if (newValue!.isNotEmpty) {
                              setState(() {
                                newRowData.addAll({
                                  "Category": newValue!.isEmpty ? "" : newValue
                                });
                              });
                              // }
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
}
