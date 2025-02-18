import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dio/dio.dart';
import 'package:erp_system/core/widgets/custom_error_massage.dart';
import 'package:erp_system/core/widgets/custom_loading_widget.dart';
import 'package:erp_system/features/screenTable/data/models/item_list_setup_model.dart';
import 'package:erp_system/features/screenTable/presentation/manager/addEditExpenses/add_edit_expenses_cubit.dart';
import 'package:erp_system/features/screenTable/presentation/manager/getListSetups/get_list_setups_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../../../core/helper/AlertDialog/custom_alert_dialog.dart';
import '../../../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../../../core/models/menu_model/pages.dart';
import '../../../../../../core/utils/api_service.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../home/presentation/widgets/home_view_body.dart';
import '../../../../data/models/dropdown_model/all_dropdown_model.dart';
import '../../../../data/models/permission_model.dart';
import '../../../../data/models/screen_model.dart';
import '../../../../data/models/tap_model.dart';
import '../../../manager/getTable/get_table_cubit.dart';
import '../../../views/screen_table.dart';
import '../build_alert_add_in_dropdown.dart';
import 'purchases_table_add_edit_.dart';

class AddPurchases extends StatefulWidget {
  const AddPurchases(
      {super.key, required this.pageData, required this.listKey, this.tapData});
  final ListTaps? tapData;
  final Pages pageData;
  final List<dynamic> listKey;
  static List<dynamic> listBarcodeData = [];
  static List<dynamic> listProduct = [];

  @override
  State<AddPurchases> createState() => _AddPurchasesState();
}

class _AddPurchasesState extends State<AddPurchases> {
  String? lang;
  GlobalKey<FormState> formKey = GlobalKey();
  Map<String, dynamic> singleObject = {};
  List<Map<String, dynamic>> tableList = [];
  late List<AllDropdownModel> myAllDropdownModelList;

  List<String> listHeaderPurchases = [
    "الاجمالى",
    "الخزينة",
    "ضريبة القيمة المضافة",
    "ضريبة خصم منبع",
    "المبلغ المدفوع",
    "الخصم",
    "الاجل للمورد",
  ];
  double total = 0.0;
  TextEditingController cashPaidController = TextEditingController();
  TextEditingController valueAddedTaxController = TextEditingController();
  TextEditingController rateValueAddedTaxController = TextEditingController();
  TextEditingController taxController = TextEditingController();
  TextEditingController rateTaxController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController deadlineSupplierController = TextEditingController();
  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    myAllDropdownModelList = ScreenTable.myAllDropdownModelList;
    getDataList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetListSetupsCubit, GetListSetupsState>(
      builder: (context, state) {
        if (state is GetListSetupsSuccess) {
          List<ItemListSetupModel> listSetup = state.listSetupModel;
          List<ItemListSetupModel> listColumn = [];
          List<dynamic> listKey = [];
          List<String> category = [];
          List<String> listHeader = [];

          for (var item in state.listSetupModel) {
            category.add(item.categoryTitle ?? '');
            if (item.insertVisable == true &&
                item.cvisable == true &&
                item.visible == true &&
                item.isGeneral != true) {
              listColumn.add(item);
              listKey.add(item.columnName);
              listHeader.add(lang == AppStrings.enLangKey
                  ? item.enColumnLabel!
                  : item.arColumnLabel!);
            }
          }
          List<String> categoryList = category.toSet().toList();
          return StatefulBuilder(
            builder: (context, salessetState) => Padding(
              padding: const EdgeInsets.all(12.0),
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
                            ...List.generate(categoryList.length, (index) {
                              String categoryName = categoryList[index];
                              List<Widget> widgetList = getMyWidgetList(
                                listData: listSetup,
                                categoryName: categoryName,
                              );
                              return widgetList.isNotEmpty
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 8),
                                              decoration: BoxDecoration(
                                                  // color: AppColors.grey.withOpacity(.4),
                                                  color: AppColors.grey
                                                      .withAlpha(102),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Text(
                                                categoryName,
                                                style: AppStyles.textStyle18
                                                    .copyWith(
                                                        color: Colors.black),
                                              )),
                                          ...widgetList,
                                        ],
                                      ),
                                    )
                                  : const SizedBox();
                            }),
                            StatefulBuilder(
                              builder: (context, ssetState) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: PurchasesTableAddEdit(
                                    onTapAction: (data) {
                                      total = 0.0;
                                      ssetState(() {
                                        tableList = data;
                                      });
                                      if (tableList.isNotEmpty) {
                                        for (var i in tableList) {
                                          salessetState(() {
                                            total = total +
                                                (double.parse(
                                                        i['CostCurrancy']) *
                                                    double.parse(
                                                        i['Quntity'] ?? "1"));
                                            valueAddedTaxController.text =
                                                valueFromRate(
                                              totalValue: totalAfterDiscount(
                                                total: total.toString(),
                                                discount:
                                                    discountController.text,
                                              ),
                                              valueRate:
                                                  rateValueAddedTaxController
                                                      .text,
                                            );
                                            taxController.text = valueFromRate(
                                              totalValue: totalAfterDiscount(
                                                total: total.toString(),
                                                discount:
                                                    discountController.text,
                                              ),
                                              valueRate: taxController.text,
                                            );
                                            deadlineSupplierController.text =
                                                deadlineSupplier(
                                              total: total.toString(),
                                              valueAddedTax:
                                                  valueAddedTaxController.text,
                                              tax: taxController.text,
                                              discount: discountController.text,
                                              cashPaid: cashPaidController.text,
                                            );
                                          });
                                        }
                                      } else {
                                        salessetState(() {
                                          total = 0.0;
                                        });
                                      }
                                    },
                                    oldTableList: const [],
                                    tapData: widget.tapData,
                                    pageData: widget.pageData,
                                    listKey: listKey,
                                    listHeader: listHeader,
                                    listColumn: listColumn,
                                    allDropdownModelList:
                                        ScreenTable.myAllDropdownModelList,
                                    typeView: "Add",
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            // createForm(listSetup),
                            // const SizedBox(
                            //   height: 24,
                            // ),
                            ...List.generate(
                                listHeaderPurchases.length,
                                (index) => Container(
                                      decoration: BoxDecoration(
                                          border: BorderDirectional(
                                        top: const BorderSide(
                                            color: Colors.grey),
                                        start: const BorderSide(
                                            color: Colors.grey),
                                        end: const BorderSide(
                                            color: Colors.grey),
                                        bottom: index ==
                                                listHeaderPurchases.length - 1
                                            ? const BorderSide(
                                                color: Colors.grey)
                                            : BorderSide.none,
                                      )),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: 55,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 5),
                                              decoration: BoxDecoration(
                                                  border:
                                                      const BorderDirectional(
                                                    end: BorderSide(
                                                        color: Colors.grey,
                                                        width: .5),
                                                  ),
                                                  color: listHeaderPurchases[
                                                                  index] ==
                                                              "الاجمالى" ||
                                                          listHeaderPurchases[
                                                                  index] ==
                                                              "الاجل للمورد"
                                                      ? Colors.cyanAccent
                                                      : null),
                                              alignment: AlignmentDirectional
                                                  .centerStart,
                                              child: Text(
                                                  listHeaderPurchases[index]),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              height: 55,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 5),
                                              decoration: BoxDecoration(
                                                  border:
                                                      const BorderDirectional(
                                                    start: BorderSide(
                                                        color: Colors.grey,
                                                        width: .7),
                                                  ),
                                                  color: listHeaderPurchases[
                                                                  index] ==
                                                              "الاجمالى" ||
                                                          listHeaderPurchases[
                                                                  index] ==
                                                              "الاجل للمورد"
                                                      ? Colors.cyanAccent
                                                      : null),
                                              alignment: Alignment.center,
                                              child: getWidgetPurchases(
                                                  title: listHeaderPurchases[
                                                      index],
                                                  listSetup: listSetup),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                            const SizedBox(
                              height: 24,
                            )
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
                            textStyle: AppStyles.textStyle16
                                .copyWith(color: Colors.grey),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          BlocConsumer<AddEditExpensesCubit,
                              AddEditExpensesState>(
                            listener: (context, state) {
                              if (state is AddEditExpensesSuccess) {
                                BlocProvider.of<GetTableCubit>(context)
                                    .getTable(
                                        pageId: widget.pageData.pageId,
                                        employee: false,
                                        isdesc: widget.pageData.isDesc,
                                        limit: 10,
                                        offset: 0,
                                        orderby: widget.pageData.orderBy,
                                        statment: '',
                                        selectcolumns: '',
                                        departmentName:
                                            widget.pageData.departmentName,
                                        isDepartment:
                                            widget.pageData.isDepartment,
                                        authorizationID:
                                            widget.pageData.authorizationID,
                                        viewEmployeeColumn:
                                            widget.pageData.viewEmployeeColumn,
                                        numberOfPage: 1,
                                        dropdownValueOfLimit: 10);
                                Navigator.pop(context);
                              } else if (state is AddEditExpensesFailure) {
                                CustomAlertDialog.alertWithButton(
                                    context: context,
                                    type: AlertType.error,
                                    title: S.of(context).error,
                                    desc: state.errorMassage);
                              }
                            },
                            builder: (context, state) {
                              if (state is AddEditExpensesLoading) {
                                return const CustomLoadingWidget();
                              } else {
                                return CustomButton(
                                  text: S.of(context).btn_add,
                                  width: 80,
                                  onTap: () async {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      singleObject.addAll({
                                        "TotalCurrancy": total,
                                        "Tax": double.parse(
                                            valueAddedTaxController.text
                                                    .trim()
                                                    .isEmpty
                                                ? "0"
                                                : valueAddedTaxController.text
                                                    .trim()),
                                        "AddTax": double.parse(
                                            taxController.text.trim().isEmpty
                                                ? "0"
                                                : taxController.text.trim()),
                                        "POPaidCurrancy": double.parse(
                                            cashPaidController.text
                                                    .trim()
                                                    .isEmpty
                                                ? "0"
                                                : cashPaidController.text
                                                    .trim()),
                                        "DiscountCurrancy": double.parse(
                                            discountController.text
                                                    .trim()
                                                    .isEmpty
                                                ? "0"
                                                : discountController.text
                                                    .trim()),
                                        "RemindCurrancy": double.parse(
                                            deadlineSupplierController.text
                                                    .trim()
                                                    .isEmpty
                                                ? "0"
                                                : deadlineSupplierController
                                                    .text
                                                    .trim()),
                                      });

                                      BlocProvider.of<AddEditExpensesCubit>(
                                              context)
                                          .add(
                                              singleObject: singleObject,
                                              tableList: tableList,
                                              controllerName: widget
                                                  .tapData!.controllerName);
                                    }
                                  },
                                );
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
          );
        } else if (state is GetListSetupsFailure) {
          return CustomErrorMassage(errorMassage: state.errorMassage);
        } else {
          return const CustomLoadingWidget();
        }
      },
    );
  }

  List<Widget> getMyWidgetList({
    required List<ItemListSetupModel> listData,
    required String categoryName,
    // required bool show,
  }) {
    List<Widget> list = [];

    for (var item in listData) {
      String title = lang == AppStrings.arLangKey
          ? item.arColumnLabel!
          : item.enColumnLabel!;
      bool condition = item.insertVisable == true &&
          item.cvisable == false &&
          item.visible == false &&
          item.isGeneral == true;

      //text
      if (item.insertType == "text" &&
          item.categoryTitle == categoryName &&
          condition) {
        list.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: AppStyles.textStyle14.copyWith(color: Colors.grey),
                    ),
                    if (item.isRquired! == true)
                      const Icon(
                        Icons.star,
                        color: Colors.red,
                        size: 10,
                      )
                  ],
                ),
                CustomTextFormField(
                  hintText: '',
                  isValidator: item.isRquired!,
                  keyboardType: TextInputType.text,
                  onSaved: (newValue) {
                    if (newValue!.isNotEmpty) {
                      setState(() {
                        singleObject
                            .addAll({item.columnName!.toString(): newValue});
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        );
      }
      //number
      if (item.insertType == "number" &&
          item.categoryTitle == categoryName &&
          condition) {
        list.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: AppStyles.textStyle14.copyWith(color: Colors.grey),
                    ),
                    if (item.isRquired! == true)
                      const Icon(
                        Icons.star,
                        color: Colors.red,
                        size: 10,
                      )
                  ],
                ),
                CustomTextFormField(
                  hintText: '',
                  isValidator: item.isRquired!,
                  keyboardType: TextInputType.number,
                  onSaved: (newValue) {
                    if (newValue!.isNotEmpty) {
                      setState(() {
                        singleObject
                            .addAll({item.columnName!.toString(): newValue});
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        );
      }
      //Date
      if (item.insertType == "date" &&
          item.categoryTitle == categoryName &&
          condition) {
        String date = '';
        list.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: AppStyles.textStyle14.copyWith(color: Colors.grey),
                    ),
                    if (item.isRquired == true)
                      const Icon(
                        Icons.star,
                        color: Colors.red,
                        size: 10,
                      )
                  ],
                ),
                StatefulBuilder(
                  builder: (context, dsetState) {
                    return InkWell(
                      onTap: () async {
                        DateTime? dateTime = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1980),
                          lastDate: DateTime(2100),
                        );
                        if (dateTime != null) {
                          dsetState(() {
                            date =
                                DateFormat("yyyy-MM-dd", 'en').format(dateTime);
                          });

                          dsetState(() {
                            singleObject.addAll({
                              item.columnName!.toString(): dateTime.toString()
                            });
                          });
                        }
                      },
                      child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.blueDark)),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            date,
                            textAlign: TextAlign.center,
                            style: AppStyles.textStyle14
                                .copyWith(color: Colors.black),
                          )),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }

      //dropdown
      if (item.insertType == "dropdown" &&
          item.categoryTitle == categoryName &&
          condition) {
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
          if (ii.columnName == item.columnName) {
            myListDrop = ii.list;
          }
        }

        Pages? dropPage = getDropPage(item.pageId);
        list.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: AppStyles.textStyle14.copyWith(color: Colors.grey),
                    ),
                    if (item.isRquired == true)
                      const Icon(
                        Icons.star,
                        color: Colors.red,
                        size: 10,
                      ),
                    const SizedBox(
                      width: 12,
                    ),
                    if (dropPage != null)
                      InkWell(
                        onTap: () async {
                          bool canAdd = await getPermissions(item.pageId);
                          if (canAdd == true) {
                            getColumnListAndAdd(dropPage);
                          } else {
                            CustomAlertDialog.alertWithButton(
                                context: context,
                                type: AlertType.error,
                                title: S.of(context).error,
                                desc: S.of(context).massage_no_permission);
                          }
                        },
                        child: const Icon(
                          Icons.add,
                          color: Colors.blue,
                          size: 24,
                        ),
                      ),
                    const SizedBox(
                      width: 5,
                    ),
                    // if (dropPage != null)
                    InkWell(
                      onTap: () async {
                        getDropdownList(widget.pageData.pageId);
                      },
                      child: const Icon(
                        Icons.refresh,
                        color: Colors.green,
                        size: 24,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                  child: CustomDropdown<String>.search(
                    hintText: '',
                    closedHeaderPadding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: CustomDropdownDecoration(
                      headerStyle:
                          AppStyles.textStyle16.copyWith(color: Colors.black),
                      closedFillColor: Colors.transparent,
                      closedBorder: Border.all(color: AppColors.blueDark),
                    ),
                    items: myListDrop!.isEmpty
                        ? [""]
                        : List.generate(myListDrop.length,
                            (index) => myListDrop![index].text ?? ''),
                    onChanged: (value) {
                      ItemDrop ii = myListDrop!
                          .firstWhere((element) => element.text == value);
                      singleObject.addAll({item.searchName!.toString(): ii.id});
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }
      //checkbox
      if (item.insertType == "checkbox" &&
          item.categoryTitle == categoryName &&
          condition) {
        bool checkboxValue = false;
        list.add(
          StatefulBuilder(
            builder: (context, csetState) {
              return CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: checkboxValue,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Row(
                    children: [
                      Text(
                        title,
                        style:
                            AppStyles.textStyle14.copyWith(color: Colors.black),
                      ),
                      if (item.isRquired == true)
                        const Icon(
                          Icons.star,
                          color: Colors.red,
                          size: 10,
                        )
                    ],
                  ),
                  onChanged: (newValue) {
                    csetState(() {
                      checkboxValue = !checkboxValue;
                    });
                    csetState(() {
                      singleObject
                          .addAll({item.columnName!.toString(): checkboxValue});
                    });
                  });
            },
          ),
        );
      }
    }
    return list;
  }

  getWidgetPurchases({
    required String title,
    required List<ItemListSetupModel> listSetup,
  }) {
    switch (title) {
      case "الاجمالى":
        return Text(
          "$total",
          style: const TextStyle(color: Colors.red, fontSize: 20),
        );
      case "الخزينة":
        ItemListSetupModel item = listSetup
            .firstWhere((element) => element.columnName == "SafeAccounId");
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
          if (ii.columnName == item.columnName) {
            myListDrop = ii.list;
          }
        }
        return CustomDropdown<String>.search(
          hintText: '',
          closedHeaderPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: CustomDropdownDecoration(
              headerStyle: AppStyles.textStyle16.copyWith(color: Colors.black),
              closedFillColor: Colors.transparent,
              closedBorder: Border.all(color: AppColors.blueDark)),
          items: myListDrop!.isEmpty
              ? [""]
              : List.generate(
                  myListDrop.length, (index) => myListDrop![index].text ?? ''),
          onChanged: (value) {},
        );
      case "ضريبة القيمة المضافة":
        return StatefulBuilder(
          builder: (context, wsetState) => Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  controller: rateValueAddedTaxController,
                  hintText: '',
                  isValidator: false,
                  keyboardType: TextInputType.number,
                  onChanged: (newValue) {
                    valueAddedTaxController.text = valueFromRate(
                        totalValue: totalAfterDiscount(
                            total: total.toString(),
                            discount: discountController.text),
                        valueRate: newValue);
                    deadlineSupplierController.text = deadlineSupplier(
                        total: total.toString(),
                        valueAddedTax: valueAddedTaxController.text,
                        tax: taxController.text,
                        discount: discountController.text,
                        cashPaid: cashPaidController.text);

                    wsetState(() {});
                  },
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 2,
                child: CustomTextFormField(
                  controller: valueAddedTaxController,
                  hintText: '',
                  isValidator: false,
                  keyboardType: TextInputType.number,
                  onChanged: (newValue) {
                    rateValueAddedTaxController.text = rate(
                        totalValue: totalAfterDiscount(
                            total: total.toString(),
                            discount: discountController.text),
                        value: newValue);
                    deadlineSupplierController.text = deadlineSupplier(
                        total: total.toString(),
                        valueAddedTax: newValue,
                        tax: taxController.text,
                        discount: discountController.text,
                        cashPaid: cashPaidController.text);

                    wsetState(() {});
                  },
                ),
              ),
            ],
          ),
        );
      case "ضريبة خصم منبع":
        return StatefulBuilder(
          builder: (context, wsetState) => Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  controller: rateTaxController,
                  hintText: '',
                  isValidator: false,
                  keyboardType: TextInputType.number,
                  onChanged: (newValue) {
                    taxController.text = valueFromRate(
                        totalValue: totalAfterDiscount(
                            total: total.toString(),
                            discount: discountController.text),
                        valueRate: newValue);
                    deadlineSupplierController.text = deadlineSupplier(
                        total: total.toString(),
                        valueAddedTax: valueAddedTaxController.text,
                        tax: taxController.text,
                        discount: discountController.text,
                        cashPaid: cashPaidController.text);
                    wsetState(() {});
                  },
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 2,
                child: CustomTextFormField(
                  controller: taxController,
                  hintText: '',
                  isValidator: false,
                  keyboardType: TextInputType.number,
                  onChanged: (newValue) {
                    rateTaxController.text = rate(
                        totalValue: totalAfterDiscount(
                            total: total.toString(),
                            discount: discountController.text),
                        value: newValue);
                    deadlineSupplierController.text = deadlineSupplier(
                        total: total.toString(),
                        valueAddedTax: valueAddedTaxController.text,
                        tax: newValue,
                        discount: discountController.text,
                        cashPaid: cashPaidController.text);
                    wsetState(() {});
                  },
                ),
              ),
            ],
          ),
        );
      case "المبلغ المدفوع":
        return StatefulBuilder(
          builder: (context, wsetState) => CustomTextFormField(
            controller: cashPaidController,
            hintText: '',
            isValidator: false,
            keyboardType: TextInputType.number,
            onChanged: (newValue) {
              deadlineSupplierController.text = deadlineSupplier(
                  total: total.toString(),
                  valueAddedTax: valueAddedTaxController.text,
                  tax: taxController.text,
                  discount: discountController.text,
                  cashPaid: newValue);
              wsetState(() {});
            },
          ),
        );
      case "الخصم":
        return StatefulBuilder(
          builder: (context, wsetState) => CustomTextFormField(
            controller: discountController,
            hintText: '',
            isValidator: false,
            keyboardType: TextInputType.number,
            onChanged: (newValue) {
              valueAddedTaxController.text = valueFromRate(
                  totalValue: totalAfterDiscount(
                      total: total.toString(), discount: newValue),
                  valueRate: rateValueAddedTaxController.text);
              taxController.text = valueFromRate(
                  totalValue: totalAfterDiscount(
                      total: total.toString(), discount: newValue),
                  valueRate: rateTaxController.text);
              deadlineSupplierController.text = deadlineSupplier(
                  total: total.toString(),
                  valueAddedTax: valueAddedTaxController.text,
                  tax: taxController.text,
                  discount: newValue,
                  cashPaid: cashPaidController.text);
              wsetState(() {});
            },
          ),
        );
      case "الاجل للمورد":
        return CustomTextFormField(
          controller: deadlineSupplierController,
          hintText: '',
          isBorder: false,
          readOnly: true,
          isValidator: false,
          keyboardType: TextInputType.number,
          textStyle: const TextStyle(color: Colors.red, fontSize: 20),
        );
    }
  }

  String deadlineSupplier({
    required String total,
    required String valueAddedTax,
    required String tax,
    required String discount,
    required String cashPaid,
  }) {
    double result = double.parse(total == "" ? "0" : total) -
        double.parse(tax == "" ? "0" : tax) +
        double.parse(valueAddedTax == "" ? "0" : valueAddedTax) -
        double.parse(discount == "" ? "0" : discount) -
        double.parse(cashPaid == "" ? "0" : cashPaid);
    return result.toString();
  }

  String rate({
    required String totalValue,
    required String value,
  }) {
    double result = double.parse(value == "" ? "0" : value) /
        double.parse(totalValue == "" ? "0" : totalValue) *
        100;
    return result.toString();
  }

  String valueFromRate({
    required String totalValue,
    required String valueRate,
  }) {
    double result = double.parse(valueRate == "" ? "0" : valueRate) *
        double.parse(totalValue == "" ? "0" : totalValue) /
        100;
    return result.toString();
  }

  String totalAfterDiscount({
    required String total,
    required String discount,
  }) {
    double result = double.parse(total == "" ? "0" : total) -
        double.parse(discount == "" ? "0" : discount);
    return result.toString();
  }

  void getDataList() async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ??
              "";
      String token =
          await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      Map<String, dynamic> dataProduct = await ApiService(Dio()).post(
        endPoint: "web/Structure/getDataGlobal",
        data: {"TableName": "Product"},
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );

      Map<String, dynamic> barcodeData = await ApiService(Dio()).post(
        endPoint: "web/Structure/getDataGlobal",
        data: {"TableName": "BarcodeData"},
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );

      AddPurchases.listProduct = dataProduct['dynamicList'];
      AddPurchases.listBarcodeData = barcodeData['dynamicList'];
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // Future<void> getLocation() async {
  //   setState(() {
  //     isGetLocationAndListLocation = true;
  //   });
  //   Location location = Location();
  //
  //   var serviceEnabled = await location.serviceEnabled();
  //   if (!serviceEnabled) {
  //     serviceEnabled = await location.requestService();
  //     if (!serviceEnabled) {
  //       return;
  //     }
  //   }
  //
  //   var permissionGranted = await location.hasPermission();
  //   if (permissionGranted == PermissionStatus.denied) {
  //     permissionGranted = await location.requestPermission();
  //     if (permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }
  //
  //   var locationData = await location.getLocation();
  //   setState(() {
  //     lat = locationData.latitude;
  //     long = locationData.longitude;
  //     isGetLocationAndListLocation = false;
  //   });
  // }

  void getColumnListAndAdd(Pages page) async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ??
              "";
      String token =
          await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      Map<String, dynamic> data = await ApiService(Dio()).post(
        endPoint: "home/getGeneralTable",
        data: {
          "pageId": page.pageId,
          "employee": false,
          "isdesc": page.isDesc,
          "limit": 10,
          "offset": 0,
          "orderby": page.orderBy,
          "statment": '',
          "selectcolumns": '',
          "IsDepartment": page.isDepartment,
          "DepartmentName": page.departmentName,
          "AuthorizationID": page.authorizationID,
          "ViewEmployeeColumn": page.viewEmployeeColumn
        },
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      ScreenModel screenModel = ScreenModel.fromJson(data);

      List<ColumnList>? columnList = screenModel.columnList;
      CustomAlertDialog.alertWithCustomContent(
        context: context,
        title: S.of(context).btn_add,
        isOverlayTapDismiss: false,
        isCloseButton: false,
        content: BuildAlertAddInDropdown(
          columnList: columnList!,
          pageData: page,
          onTapBtn: (val) {
            getDropdownList(widget.pageData.pageId);
          },
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Pages? getDropPage(int? pageId) {
    for (var page in HomeViewBody.pagesList) {
      if (page.pageId == pageId) {
        return page;
      }
    }
    return null;
  }

  Future<bool> getPermissions(int? pageId) async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ??
              "";
      String token =
          await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      Map<String, dynamic> data = await ApiService(Dio()).get(
        endPoint: "home/GetPagePermissions?pageId=$pageId",
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      PermissionModel permissionModel = PermissionModel.fromJson(data);
      return permissionModel.showNew;
    } catch (e) {
      return false;
    }
  }

  void getDropdownList(int pageId) async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ??
              "";
      String token =
          await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      List<dynamic> data = await ApiService(Dio()).get(
        endPoint: "home/GetPageDropDown?pageId=$pageId",
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );

      List<AllDropdownModel> dataList = [];
      for (var i in data) {
        dataList.add(AllDropdownModel.fromJson(i));
      }

      setState(() {
        myAllDropdownModelList = dataList;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // bool? getCustomer(int userId) {
  //   for (var item in AddSales.listCustomerAccount) {
  //     if (item['CustomerAccountID'] == userId) {
  //       return item['Closelocation'];
  //     }
  //   }
  //   return null;
  // }

  // Future<void> getCustomerLocation(int userId) async {
  //   setState(() {
  //     isGetLocationAndListLocation = true;
  //   });
  //   try {
  //     String companyKey =
  //         await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ??
  //             "";
  //     String token =
  //         await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
  //     Map<String, dynamic> customerAccountLocation =
  //         await ApiService(Dio()).post(
  //       endPoint: "web/Structure/getDataGlobal",
  //       data: {
  //         "TableName": "CustomerAccountLocation",
  //         "TailCondition": "CustomerID= $userId"
  //       },
  //       headers: {
  //         "Authorization": "Bearer $token",
  //         "CompanyKey": companyKey,
  //       },
  //     );
  //     AddSales.listCustomerAccountLocation =
  //         customerAccountLocation['dynamicList'];
  //     setState(() {
  //       isGetLocationAndListLocation = false;
  //     });
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }
  //
  // void checkLocation() async {
  //   await getLocation();
  //   await getCustomerLocation(AddSales.userId);
  //   double distance;
  //   for (var location in AddSales.listCustomerAccountLocation) {
  //     distance = (Geolocator.distanceBetween(
  //           lat ?? 0.0,
  //           long ?? 0.0,
  //           location['LocationLat'],
  //           location['LocationLong'],
  //         )) /
  //         1000;
  //     // radius.add(distance);
  //     if (distance == location['Radius'] ||
  //         distance < location['Radius'] ||
  //         distance == 0.0) {
  //       BlocProvider.of<AddEditExpensesCubit>(context).add(
  //           singleObject: singleObject,
  //           tableList: tableList,
  //           controllerName: widget.tapData!.controllerName);
  //     } else {
  //       CustomAlertDialog.alertWithButton(
  //           context: context,
  //           type: AlertType.error,
  //           isCloseButton: false,
  //           isOverlayTapDismiss: false,
  //           title: S.of(context).error,
  //           desc: S.of(context).no_location,
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           });
  //     }
  //   }
  // }
}
