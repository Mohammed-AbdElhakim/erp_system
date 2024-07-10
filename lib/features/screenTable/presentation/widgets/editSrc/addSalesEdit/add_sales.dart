import 'package:animated_custom_dropdown/custom_dropdown.dart';
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
import '../../../../../../core/models/menu_model/pages.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../data/models/dropdown_model/all_dropdown_model.dart';
import '../../../../data/models/tap_model.dart';
import '../../../manager/getTable/get_table_cubit.dart';
import '../../../views/screen_table.dart';
import '../addOrEditExcel/custom_table_add_edit_.dart';

class AddSales extends StatefulWidget {
  const AddSales(
      {super.key, required this.pageData, required this.listKey, this.tapData});
  final ListTaps? tapData;
  final Pages pageData;
  final List<dynamic> listKey;

  @override
  State<AddSales> createState() => _AddSalesState();
}

class _AddSalesState extends State<AddSales> {
  String? lang;
  GlobalKey<FormState> formKey = GlobalKey();
  Map<String, dynamic> singleObject = {};
  bool isShow = false;
  List<Map<String, dynamic>> tableList = [];
  late List<AllDropdownModel> myAllDropdownModelList;

  List<String> listHeaderSales = [
    "الاجمالى",
    "المحصل نقدا",
    "عدد الاقساط",
    "تاريخ اول قسط",
    "شهور القسط",
    "اجمالي الخصم الجزئي",
    "الخزينة",
    "ضريبة خصم منبع",
    "خصم اجنبي",
    "ضريبة القيمة المضافة",
    "اجمالي بعد الضرائب",
    "مصاريف الشحن",
    "الاجل على العميل",
  ];

  double total = 0.0;
  double deadlineClient = 0.0;
  TextEditingController cashCollectedController = TextEditingController();
  TextEditingController numberOfInstallmentsController =
      TextEditingController();
  TextEditingController installmentMonthsController = TextEditingController();
  TextEditingController discountTaxPercentController = TextEditingController();
  TextEditingController discountTaxController = TextEditingController();
  TextEditingController discountPercentController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController taxPercentController = TextEditingController();
  TextEditingController taxController = TextEditingController();
  TextEditingController totalAfterTaxController = TextEditingController();
  TextEditingController shippingPriceController = TextEditingController();

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    myAllDropdownModelList = ScreenTable.myAllDropdownModelList;
    super.initState();
  }

  @override
  void dispose() {
    // AddViewBody.tableList = [];

    super.dispose();
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
          return Padding(
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
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 8),
                                            decoration: BoxDecoration(
                                                color: AppColors.grey
                                                    .withOpacity(.4),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
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
                                child: CustomTableAddEdit(
                                  onTapAction: (data) {
                                    total = 0.0;
                                    ssetState(() {
                                      tableList = data;
                                    });

                                    if (tableList.isNotEmpty) {
                                      for (var i in tableList) {
                                        setState(() {
                                          total = total +
                                              (double.parse(
                                                      i['PriceCurrancy']) *
                                                  double.parse(
                                                      i['Qty'] ?? "1"));

                                          discountController.text = discount(
                                                  total: total,
                                                  discountPercent:
                                                      discountPercentController
                                                              .text.isEmpty
                                                          ? 0
                                                          : double.parse(
                                                              discountPercentController
                                                                  .text))
                                              .toString();
                                          discountTaxController
                                              .text = discountTax(
                                                  discountTaxPercent:
                                                      discountTaxPercentController
                                                              .text.isEmpty
                                                          ? 0
                                                          : double.parse(
                                                              discountTaxPercentController
                                                                  .text),
                                                  total: total,
                                                  discountPercent:
                                                      discountPercentController
                                                              .text.isEmpty
                                                          ? 0
                                                          : double.parse(
                                                              discountPercentController
                                                                  .text))
                                              .toString();
                                          taxController.text = tax(
                                            total: total,
                                            discountPercent:
                                                discountPercentController
                                                        .text.isEmpty
                                                    ? 0
                                                    : double.parse(
                                                        discountPercentController
                                                            .text),
                                            taxPercent: taxPercentController
                                                    .text.isEmpty
                                                ? 0
                                                : double.parse(
                                                    taxPercentController.text),
                                          ).toString();

                                          totalAfterTaxController.text =
                                              totalAfterTax(
                                            total: total,
                                            shippingPrice:
                                                shippingPriceController
                                                        .text.isEmpty
                                                    ? 0
                                                    : double.parse(
                                                        shippingPriceController
                                                            .text),
                                            discountTaxPercent:
                                                discountTaxPercentController
                                                        .text.isEmpty
                                                    ? 0
                                                    : double.parse(
                                                        discountTaxPercentController
                                                            .text),
                                            discountPercent:
                                                discountPercentController
                                                        .text.isEmpty
                                                    ? 0
                                                    : double.parse(
                                                        discountPercentController
                                                            .text),
                                            taxPercent: taxPercentController
                                                    .text.isEmpty
                                                ? 0
                                                : double.parse(
                                                    taxPercentController.text),
                                          ).toString();

                                          deadlineClient = deadlineClientValue(
                                            total: total,
                                            shippingPrice:
                                                shippingPriceController
                                                        .text.isEmpty
                                                    ? 0
                                                    : double.parse(
                                                        shippingPriceController
                                                            .text),
                                            discountTaxPercent:
                                                discountTaxPercentController
                                                        .text.isEmpty
                                                    ? 0
                                                    : double.parse(
                                                        discountTaxPercentController
                                                            .text),
                                            discountPercent:
                                                discountPercentController
                                                        .text.isEmpty
                                                    ? 0
                                                    : double.parse(
                                                        discountPercentController
                                                            .text),
                                            taxPercent: taxPercentController
                                                    .text.isEmpty
                                                ? 0
                                                : double.parse(
                                                    taxPercentController.text),
                                            cashCollected:
                                                cashCollectedController
                                                        .text.isEmpty
                                                    ? 0
                                                    : double.parse(
                                                        cashCollectedController
                                                            .text),
                                          );
                                        });
                                      }
                                    } else {
                                      setState(() {
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
                          ...List.generate(
                              listHeaderSales.length,
                              (index) => Container(
                                    decoration: BoxDecoration(
                                        border: BorderDirectional(
                                      top: const BorderSide(color: Colors.grey),
                                      start:
                                          const BorderSide(color: Colors.grey),
                                      end: const BorderSide(color: Colors.grey),
                                      bottom: index ==
                                              listHeaderSales.length - 1
                                          ? const BorderSide(color: Colors.grey)
                                          : BorderSide.none,
                                    )),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 55,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 5),
                                            decoration: BoxDecoration(
                                                border: const BorderDirectional(
                                                  end: BorderSide(
                                                      color: Colors.grey,
                                                      width: .5),
                                                ),
                                                color: listHeaderSales[index] ==
                                                            "الاجمالى" ||
                                                        listHeaderSales[
                                                                index] ==
                                                            "الاجل على العميل" ||
                                                        listHeaderSales[
                                                                index] ==
                                                            "عدد الاقساط" ||
                                                        listHeaderSales[
                                                                index] ==
                                                            "تاريخ اول قسط" ||
                                                        listHeaderSales[
                                                                index] ==
                                                            "شهور القسط"
                                                    ? Colors.cyanAccent
                                                    : null),
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(listHeaderSales[index]),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            height: 55,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 5),
                                            decoration: BoxDecoration(
                                                border: const BorderDirectional(
                                                  start: BorderSide(
                                                      color: Colors.grey,
                                                      width: .7),
                                                ),
                                                color: listHeaderSales[index] ==
                                                            "الاجمالى" ||
                                                        listHeaderSales[
                                                                index] ==
                                                            "الاجل على العميل"
                                                    ? Colors.cyanAccent
                                                    : null),
                                            alignment: Alignment.center,
                                            child: getWidgetSales(
                                                title: listHeaderSales[index],
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
                              BlocProvider.of<GetTableCubit>(context).getTable(
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
                                  isDepartment: widget.pageData.isDepartment,
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
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();

                                    BlocProvider.of<AddEditExpensesCubit>(
                                            context)
                                        .add(
                                      singleObject: singleObject,
                                      tableList: tableList,
                                    );
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
      bool condition = widget.pageData.editSrc == AppStrings.addSalesEdit
          ? item.insertVisable == true &&
              item.cvisable == false &&
              item.visible == false &&
              item.isGeneral == true
          : item.insertVisable == true &&
              item.cvisable == true &&
              item.visible == true;
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
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
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
                CustomDropdown<String>.search(
                  hintText: '',
                  decoration: CustomDropdownDecoration(
                      headerStyle:
                          AppStyles.textStyle16.copyWith(color: Colors.black),
                      closedFillColor: Colors.transparent,
                      closedBorder: Border.all(color: AppColors.blueDark)),
                  // validator: (value) {
                  //   if (value?.isEmpty ?? true) {
                  //     return S.of(context).field_is_required;
                  //   } else {
                  //     return null;
                  //   }
                  // },
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

  getWidgetSales(
      {required String title, required List<ItemListSetupModel> listSetup}) {
    switch (title) {
      case "الاجمالى":
        return Text(
          "$total",
          style: TextStyle(color: Colors.red, fontSize: 20),
        );
      case "المحصل نقدا":
        return CustomTextFormField(
          controller: cashCollectedController,
          hintText: '',
          keyboardType: TextInputType.number,
          onChanged: (value) {
            totalAfterTaxController.text = totalAfterTax(
              total: total,
              shippingPrice: shippingPriceController.text.isEmpty
                  ? 0
                  : double.parse(shippingPriceController.text),
              discountTaxPercent: discountTaxPercentController.text.isEmpty
                  ? 0
                  : double.parse(discountTaxPercentController.text),
              discountPercent: discountPercentController.text.isEmpty
                  ? 0
                  : double.parse(discountPercentController.text),
              taxPercent: taxPercentController.text.isEmpty
                  ? 0
                  : double.parse(taxPercentController.text),
            ).toString();
            deadlineClient = deadlineClientValue(
              total: total,
              shippingPrice: shippingPriceController.text.isEmpty
                  ? 0
                  : double.parse(shippingPriceController.text),
              discountTaxPercent: discountTaxPercentController.text.isEmpty
                  ? 0
                  : double.parse(discountTaxPercentController.text),
              discountPercent: discountPercentController.text.isEmpty
                  ? 0
                  : double.parse(discountPercentController.text),
              taxPercent: taxPercentController.text.isEmpty
                  ? 0
                  : double.parse(taxPercentController.text),
              cashCollected: cashCollectedController.text.isEmpty
                  ? 0
                  : double.parse(cashCollectedController.text),
            );
            setState(() {});
          },
        );
      case "عدد الاقساط":
        return CustomTextFormField(
          controller: numberOfInstallmentsController,
          hintText: '',
          keyboardType: TextInputType.number,
          onChanged: (value) {},
        );
      case "تاريخ اول قسط":
        String date = DateFormat("yyyy-MM-dd", 'en').format(DateTime.now());
        return StatefulBuilder(
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
                    date = DateFormat("yyyy-MM-dd", 'en').format(dateTime);
                  });
                }
              },
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: AppColors.blueDark)),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    date,
                    textAlign: TextAlign.center,
                    style: AppStyles.textStyle14.copyWith(color: Colors.black),
                  )),
            );
          },
        );
      case "شهور القسط":
        return CustomTextFormField(
          controller: installmentMonthsController,
          hintText: '',
          keyboardType: TextInputType.number,
          onChanged: (newValue) {},
        );
      case "اجمالي الخصم الجزئي":
        return const Text(
          "0.0",
        );
      case "الخزينة":
        ItemListSetupModel item = listSetup
            .firstWhere((element) => element.columnName == "SafeAccount");
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
      case "ضريبة خصم منبع":
        return Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                controller: discountTaxPercentController,
                hintText: '',
                keyboardType: TextInputType.number,
                onChanged: (newValue) {
                  discountTaxController.text = discountTax(
                          discountTaxPercent:
                              newValue.isEmpty ? 0 : double.parse(newValue),
                          total: total,
                          discountPercent: discountPercentController
                                  .text.isEmpty
                              ? 0
                              : double.parse(discountPercentController.text))
                      .toString();
                  totalAfterTaxController.text = totalAfterTax(
                    total: total,
                    shippingPrice: shippingPriceController.text.isEmpty
                        ? 0
                        : double.parse(shippingPriceController.text),
                    discountTaxPercent:
                        discountTaxPercentController.text.isEmpty
                            ? 0
                            : double.parse(discountTaxPercentController.text),
                    discountPercent: discountPercentController.text.isEmpty
                        ? 0
                        : double.parse(discountPercentController.text),
                    taxPercent: taxPercentController.text.isEmpty
                        ? 0
                        : double.parse(taxPercentController.text),
                  ).toString();

                  deadlineClient = deadlineClientValue(
                    total: total,
                    shippingPrice: shippingPriceController.text.isEmpty
                        ? 0
                        : double.parse(shippingPriceController.text),
                    discountTaxPercent:
                        discountTaxPercentController.text.isEmpty
                            ? 0
                            : double.parse(discountTaxPercentController.text),
                    discountPercent: discountPercentController.text.isEmpty
                        ? 0
                        : double.parse(discountPercentController.text),
                    taxPercent: taxPercentController.text.isEmpty
                        ? 0
                        : double.parse(taxPercentController.text),
                    cashCollected: cashCollectedController.text.isEmpty
                        ? 0
                        : double.parse(cashCollectedController.text),
                  );
                  setState(() {});
                },
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              flex: 2,
              child: CustomTextFormField(
                controller: discountTaxController,
                hintText: '',
                keyboardType: TextInputType.number,
                onChanged: (newValue) {
                  discountTaxPercentController.text = discountTaxPercent(
                          totalAfterDiscount: totalAfterDiscount(
                              total: total,
                              discountPercent:
                                  discountPercentController.text.isEmpty
                                      ? 0
                                      : double.parse(
                                          discountPercentController.text)),
                          discountTax:
                              newValue.isEmpty ? 0 : double.parse(newValue))
                      .toString();

                  totalAfterTaxController.text = totalAfterTax(
                    total: total,
                    shippingPrice: shippingPriceController.text.isEmpty
                        ? 0
                        : double.parse(shippingPriceController.text),
                    discountTaxPercent:
                        discountTaxPercentController.text.isEmpty
                            ? 0
                            : double.parse(discountTaxPercentController.text),
                    discountPercent: discountPercentController.text.isEmpty
                        ? 0
                        : double.parse(discountPercentController.text),
                    taxPercent: taxPercentController.text.isEmpty
                        ? 0
                        : double.parse(taxPercentController.text),
                  ).toString();

                  deadlineClient = deadlineClientValue(
                    total: total,
                    shippingPrice: shippingPriceController.text.isEmpty
                        ? 0
                        : double.parse(shippingPriceController.text),
                    discountTaxPercent:
                        discountTaxPercentController.text.isEmpty
                            ? 0
                            : double.parse(discountTaxPercentController.text),
                    discountPercent: discountPercentController.text.isEmpty
                        ? 0
                        : double.parse(discountPercentController.text),
                    taxPercent: taxPercentController.text.isEmpty
                        ? 0
                        : double.parse(taxPercentController.text),
                    cashCollected: cashCollectedController.text.isEmpty
                        ? 0
                        : double.parse(cashCollectedController.text),
                  );
                  setState(() {});
                },
              ),
            ),
          ],
        );
      case "خصم اجنبي":
        return Row(
          children: [
            Expanded(
              flex: 2,
              child: CustomTextFormField(
                controller: discountController,
                hintText: '',
                keyboardType: TextInputType.number,
                onChanged: (newValue) {
                  discountPercentController.text = discountPercent(
                    total: total,
                    discount: newValue.isEmpty ? 0 : double.parse(newValue),
                  ).toString();
                  totalAfterTaxController.text = totalAfterTax(
                    total: total,
                    shippingPrice: shippingPriceController.text.isEmpty
                        ? 0
                        : double.parse(shippingPriceController.text),
                    discountTaxPercent:
                        discountTaxPercentController.text.isEmpty
                            ? 0
                            : double.parse(discountTaxPercentController.text),
                    discountPercent: discountPercentController.text.isEmpty
                        ? 0
                        : double.parse(discountPercentController.text),
                    taxPercent: taxPercentController.text.isEmpty
                        ? 0
                        : double.parse(taxPercentController.text),
                  ).toString();

                  deadlineClient = deadlineClientValue(
                    total: total,
                    shippingPrice: shippingPriceController.text.isEmpty
                        ? 0
                        : double.parse(shippingPriceController.text),
                    discountTaxPercent:
                        discountTaxPercentController.text.isEmpty
                            ? 0
                            : double.parse(discountTaxPercentController.text),
                    discountPercent: discountPercentController.text.isEmpty
                        ? 0
                        : double.parse(discountPercentController.text),
                    taxPercent: taxPercentController.text.isEmpty
                        ? 0
                        : double.parse(taxPercentController.text),
                    cashCollected: cashCollectedController.text.isEmpty
                        ? 0
                        : double.parse(cashCollectedController.text),
                  );
                  setState(() {});
                },
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: CustomTextFormField(
                controller: discountPercentController,
                hintText: '',
                keyboardType: TextInputType.number,
                onChanged: (newValue) {
                  discountController.text = discount(
                          total: total,
                          discountPercent:
                              newValue.isEmpty ? 0 : double.parse(newValue))
                      .toString();
                  totalAfterTaxController.text = totalAfterTax(
                    total: total,
                    shippingPrice: shippingPriceController.text.isEmpty
                        ? 0
                        : double.parse(shippingPriceController.text),
                    discountTaxPercent:
                        discountTaxPercentController.text.isEmpty
                            ? 0
                            : double.parse(discountTaxPercentController.text),
                    discountPercent: discountPercentController.text.isEmpty
                        ? 0
                        : double.parse(discountPercentController.text),
                    taxPercent: taxPercentController.text.isEmpty
                        ? 0
                        : double.parse(taxPercentController.text),
                  ).toString();

                  deadlineClient = deadlineClientValue(
                    total: total,
                    shippingPrice: shippingPriceController.text.isEmpty
                        ? 0
                        : double.parse(shippingPriceController.text),
                    discountTaxPercent:
                        discountTaxPercentController.text.isEmpty
                            ? 0
                            : double.parse(discountTaxPercentController.text),
                    discountPercent: discountPercentController.text.isEmpty
                        ? 0
                        : double.parse(discountPercentController.text),
                    taxPercent: taxPercentController.text.isEmpty
                        ? 0
                        : double.parse(taxPercentController.text),
                    cashCollected: cashCollectedController.text.isEmpty
                        ? 0
                        : double.parse(cashCollectedController.text),
                  );
                  setState(() {});
                },
              ),
            ),
          ],
        );
      case "ضريبة القيمة المضافة":
        return Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                controller: taxPercentController,
                hintText: '',
                keyboardType: TextInputType.number,
                onChanged: (newValue) {
                  taxController.text = tax(
                          taxPercent:
                              newValue.isEmpty ? 0 : double.parse(newValue),
                          total: total,
                          discountPercent: discountPercentController
                                  .text.isEmpty
                              ? 0
                              : double.parse(discountPercentController.text))
                      .toString();
                  totalAfterTaxController.text = totalAfterTax(
                    total: total,
                    shippingPrice: shippingPriceController.text.isEmpty
                        ? 0
                        : double.parse(shippingPriceController.text),
                    discountTaxPercent:
                        discountTaxPercentController.text.isEmpty
                            ? 0
                            : double.parse(discountTaxPercentController.text),
                    discountPercent: discountPercentController.text.isEmpty
                        ? 0
                        : double.parse(discountPercentController.text),
                    taxPercent: taxPercentController.text.isEmpty
                        ? 0
                        : double.parse(taxPercentController.text),
                  ).toString();

                  deadlineClient = deadlineClientValue(
                    total: total,
                    shippingPrice: shippingPriceController.text.isEmpty
                        ? 0
                        : double.parse(shippingPriceController.text),
                    discountTaxPercent:
                        discountTaxPercentController.text.isEmpty
                            ? 0
                            : double.parse(discountTaxPercentController.text),
                    discountPercent: discountPercentController.text.isEmpty
                        ? 0
                        : double.parse(discountPercentController.text),
                    taxPercent: taxPercentController.text.isEmpty
                        ? 0
                        : double.parse(taxPercentController.text),
                    cashCollected: cashCollectedController.text.isEmpty
                        ? 0
                        : double.parse(cashCollectedController.text),
                  );
                  setState(() {});
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
                keyboardType: TextInputType.number,
                onChanged: (newValue) {
                  taxPercentController.text = taxPercent(
                    total: total,
                    tax: tax(
                      total: total,
                      discountPercent: discountPercentController.text.isEmpty
                          ? 0
                          : double.parse(discountPercentController.text),
                      taxPercent: newValue.isEmpty ? 0 : double.parse(newValue),
                    ),
                  ).toString();
                  totalAfterTaxController.text = totalAfterTax(
                    total: total,
                    shippingPrice: shippingPriceController.text.isEmpty
                        ? 0
                        : double.parse(shippingPriceController.text),
                    discountTaxPercent:
                        discountTaxPercentController.text.isEmpty
                            ? 0
                            : double.parse(discountTaxPercentController.text),
                    discountPercent: discountPercentController.text.isEmpty
                        ? 0
                        : double.parse(discountPercentController.text),
                    taxPercent: taxPercentController.text.isEmpty
                        ? 0
                        : double.parse(taxPercentController.text),
                  ).toString();

                  deadlineClient = deadlineClientValue(
                    total: total,
                    shippingPrice: shippingPriceController.text.isEmpty
                        ? 0
                        : double.parse(shippingPriceController.text),
                    discountTaxPercent:
                        discountTaxPercentController.text.isEmpty
                            ? 0
                            : double.parse(discountTaxPercentController.text),
                    discountPercent: discountPercentController.text.isEmpty
                        ? 0
                        : double.parse(discountPercentController.text),
                    taxPercent: taxPercentController.text.isEmpty
                        ? 0
                        : double.parse(taxPercentController.text),
                    cashCollected: cashCollectedController.text.isEmpty
                        ? 0
                        : double.parse(cashCollectedController.text),
                  );
                  setState(() {});
                },
              ),
            ),
          ],
        );
      case "اجمالي بعد الضرائب":
        return CustomTextFormField(
          controller: totalAfterTaxController,
          hintText: '',
          keyboardType: TextInputType.number,
          readOnly: true,
        );
      case "مصاريف الشحن":
        return CustomTextFormField(
          controller: shippingPriceController,
          hintText: '',
          keyboardType: TextInputType.number,
          onChanged: (newValue) {
            totalAfterTaxController.text = totalAfterTax(
              total: total,
              shippingPrice: shippingPriceController.text.isEmpty
                  ? 0
                  : double.parse(shippingPriceController.text),
              discountTaxPercent: discountTaxPercentController.text.isEmpty
                  ? 0
                  : double.parse(discountTaxPercentController.text),
              discountPercent: discountPercentController.text.isEmpty
                  ? 0
                  : double.parse(discountPercentController.text),
              taxPercent: taxPercentController.text.isEmpty
                  ? 0
                  : double.parse(taxPercentController.text),
            ).toString();

            deadlineClient = deadlineClientValue(
              total: total,
              shippingPrice: shippingPriceController.text.isEmpty
                  ? 0
                  : double.parse(shippingPriceController.text),
              discountTaxPercent: discountTaxPercentController.text.isEmpty
                  ? 0
                  : double.parse(discountTaxPercentController.text),
              discountPercent: discountPercentController.text.isEmpty
                  ? 0
                  : double.parse(discountPercentController.text),
              taxPercent: taxPercentController.text.isEmpty
                  ? 0
                  : double.parse(taxPercentController.text),
              cashCollected: cashCollectedController.text.isEmpty
                  ? 0
                  : double.parse(cashCollectedController.text),
            );
            setState(() {});
          },
        );
      case "الاجل على العميل":
        return Text(
          "$deadlineClient",
          style: TextStyle(color: Colors.red, fontSize: 20),
        );
    }
  }

  double discount({required double total, required double discountPercent}) {
    return discountPercent * total / 100;
  }

  double totalAfterDiscount(
      {required double total, required double discountPercent}) {
    return total - discount(total: total, discountPercent: discountPercent);
  }

  double discountTax(
      {required double discountTaxPercent,
      required double total,
      required double discountPercent}) {
    return discountTaxPercent *
        totalAfterDiscount(discountPercent: discountPercent, total: total) /
        100;
  }

  double tax(
      {required double total,
      required double taxPercent,
      required double discountPercent}) {
    return taxPercent *
        totalAfterDiscount(discountPercent: discountPercent, total: total) /
        100;
  }

  double totalAfterTax(
      {required double total,
      required double shippingPrice,
      required double discountTaxPercent,
      required double discountPercent,
      required double taxPercent}) {
    return total -
        discountTax(
            total: total,
            discountPercent: discountPercent,
            discountTaxPercent: discountTaxPercent) +
        tax(
            total: total,
            taxPercent: taxPercent,
            discountPercent: discountPercent) +
        shippingPrice;
  }

  double deadlineClientValue(
      {required double total,
      required double shippingPrice,
      required double discountTaxPercent,
      required double discountPercent,
      required double taxPercent,
      required double cashCollected}) {
    return totalAfterTax(
            discountPercent: discountPercent,
            total: total,
            taxPercent: taxPercent,
            discountTaxPercent: discountTaxPercent,
            shippingPrice: shippingPrice) -
        discount(total: total, discountPercent: discountPercent) -
        cashCollected;
  }

  double discountPercent({required double total, required double discount}) {
    return 100 * discount / total;
  }

  double discountTaxPercent(
      {required double totalAfterDiscount, required double discountTax}) {
    return 100 * discountTax / totalAfterDiscount;
  }

  double taxPercent({required double total, required double tax}) {
    return 100 * tax / total;
  }
}
