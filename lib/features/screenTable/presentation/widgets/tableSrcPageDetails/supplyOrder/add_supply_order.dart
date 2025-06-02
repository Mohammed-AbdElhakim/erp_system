import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dio/dio.dart';
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
import '../../../../../../core/widgets/custom_error_massage.dart';
import '../../../../../../core/widgets/custom_loading_widget.dart';
import '../../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../home/presentation/widgets/home_view_body.dart';
import '../../../../data/models/item_list_setup_model.dart';
import '../../../../data/models/tap_model.dart';
import '../../../manager/getTable/get_table_cubit.dart';
import '../../../../data/models/dropdown_model/all_dropdown_model.dart';
import '../../../manager/addEditExpenses/add_edit_expenses_cubit.dart';
import '../../../manager/getListSetups/get_list_setups_cubit.dart';
import '../../../views/screen_table.dart';
import '../../../../data/models/permission_model.dart';
import '../../../../data/models/screen_model.dart';
import '../build_alert_add_in_dropdown.dart';
import 'supply_order_table_add_edit_.dart';

class AddSupplyOrder extends StatefulWidget {
  const AddSupplyOrder({super.key, this.tapData, required this.pageData, required this.listKey});

  final ListTaps? tapData;
  final Pages pageData;
  final List<dynamic> listKey;
  static List<dynamic> listBarcodeData = [];
  static List<dynamic> listProduct = [];

  @override
  State<AddSupplyOrder> createState() => _AddSupplyOrderState();
}

class _AddSupplyOrderState extends State<AddSupplyOrder> {
  String? lang;
  GlobalKey<FormState> formKey = GlobalKey();
  Map<String, dynamic> singleObject = {};
  List<Map<String, dynamic>> tableList = [];
  late List<AllDropdownModel> myAllDropdownModelList;

  List<String> listHeaderSupplyOrder = [
    "الاجمالى",
    "طريقة الشراء",
    "الضريبة",
    "المتبقي",
    "الاجمالي بعد الضريبة",
    "الدفعة",
  ];

  int purchaseTypeId = -1;
  double total = 0.0;
  double taxPercent = 0.0;
  double rest = 0.0;
  double totalAfterTax = 0.0;
  TextEditingController paidController = TextEditingController();
  TextEditingController ratePaidController = TextEditingController();

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
            if (item.insertVisable == true && item.cvisable == true && item.visible == true && item.isGeneral != true) {
              listColumn.add(item);
              listKey.add(item.columnName);
              listHeader.add(lang == AppStrings.enLangKey ? item.enColumnLabel! : item.arColumnLabel!);
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
                                      padding: const EdgeInsets.only(bottom: 16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                              decoration: BoxDecoration(
                                                  // color: AppColors.grey.withOpacity(.4),
                                                  color: AppColors.grey.withAlpha(102),
                                                  borderRadius: BorderRadius.circular(15)),
                                              child: Text(
                                                categoryName,
                                                style: AppStyles.textStyle18.copyWith(color: Colors.black),
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
                                  child: SupplyOrderTableAddEdit(
                                    onTapAction: (data) {
                                      total = 0.0;
                                      totalAfterTax = 0.0;
                                      rest = 0.0;
                                      ssetState(() {
                                        tableList = data;
                                      });
                                      if (tableList.isNotEmpty) {
                                        for (var i in tableList) {
                                          salessetState(() {
                                            total = total +
                                                (double.parse(i['DetailValue']) * double.parse(i['DetailQuantity'] ?? "1"));
                                            totalAfterTax = calculateTotalAfterTax(total: total, taxPercent: taxPercent);
                                            rest = calculateRemaining(
                                                totalAfterTax: totalAfterTax,
                                                paidValue:
                                                    double.parse(paidController.text.isEmpty ? "0" : paidController.text.trim()));
                                          });
                                        }
                                      } else {
                                        salessetState(() {
                                          total = 0.0;
                                          totalAfterTax = 0.0;
                                          rest = 0.0;
                                        });
                                      }
                                    },
                                    oldTableList: const [],
                                    tapData: widget.tapData,
                                    pageData: widget.pageData,
                                    listKey: listKey,
                                    listHeader: listHeader,
                                    listColumn: listColumn,
                                    allDropdownModelList: ScreenTable.myAllDropdownModelList,
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
                                listHeaderSupplyOrder.length,
                                (index) => Container(
                                      decoration: BoxDecoration(
                                          border: BorderDirectional(
                                        top: const BorderSide(color: Colors.grey),
                                        start: const BorderSide(color: Colors.grey),
                                        end: const BorderSide(color: Colors.grey),
                                        bottom: index == listHeaderSupplyOrder.length - 1
                                            ? const BorderSide(color: Colors.grey)
                                            : BorderSide.none,
                                      )),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: 55,
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                              decoration: BoxDecoration(
                                                  border: const BorderDirectional(
                                                    end: BorderSide(color: Colors.grey, width: .5),
                                                  ),
                                                  color: listHeaderSupplyOrder[index] == "الاجمالى" ||
                                                          listHeaderSupplyOrder[index] == "المتبقي" ||
                                                          listHeaderSupplyOrder[index] == "الاجمالي بعد الضريبة"
                                                      ? Colors.cyanAccent
                                                      : null),
                                              alignment: AlignmentDirectional.centerStart,
                                              child: Text(listHeaderSupplyOrder[index]),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              height: 55,
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                              decoration: BoxDecoration(
                                                  border: const BorderDirectional(
                                                    start: BorderSide(color: Colors.grey, width: .7),
                                                  ),
                                                  color: listHeaderSupplyOrder[index] == "الاجمالى" ||
                                                          listHeaderSupplyOrder[index] == "المتبقي" ||
                                                          listHeaderSupplyOrder[index] == "الاجمالي بعد الضريبة"
                                                      ? Colors.cyanAccent
                                                      : null),
                                              alignment: Alignment.center,
                                              child:
                                                  getWidgetSupplyOrder(title: listHeaderSupplyOrder[index], listSetup: listSetup),
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
                            textStyle: AppStyles.textStyle16.copyWith(color: Colors.grey),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          BlocConsumer<AddEditExpensesCubit, AddEditExpensesState>(
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
                                    departmentName: widget.pageData.departmentName,
                                    isDepartment: widget.pageData.isDepartment,
                                    authorizationID: widget.pageData.authorizationID,
                                    viewEmployeeColumn: widget.pageData.viewEmployeeColumn,
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
                                        "TotalOrder": total,
                                        "finalTotal": totalAfterTax,
                                        "purchaseTypeId": purchaseTypeId,
                                        "Tax": taxPercent,
                                        "Supplieremind": rest,
                                        "POPaid":
                                            double.parse(paidController.text.trim().isEmpty ? "0" : paidController.text.trim()),
                                      });

                                      BlocProvider.of<AddEditExpensesCubit>(context).add(
                                          singleObject: singleObject,
                                          tableList: tableList,
                                          controllerName: widget.tapData!.controllerName);
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
      String title = lang == AppStrings.arLangKey ? item.arColumnLabel! : item.enColumnLabel!;
      bool condition = item.insertVisable == true && item.cvisable == false && item.visible == false && item.isGeneral == true;

      //text
      if (item.insertType == "text" && item.categoryTitle == categoryName && condition) {
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
                        singleObject.addAll({item.columnName!.toString(): newValue});
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
      if (item.insertType == "number" && item.categoryTitle == categoryName && condition) {
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
                        singleObject.addAll({item.columnName!.toString(): newValue});
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
      if (item.insertType == "date" && item.categoryTitle == categoryName && condition) {
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
                            date = DateFormat("yyyy-MM-dd", 'en').format(dateTime);
                            singleObject[item.columnName!.toString()] = dateTime.toString();
                          });
                        }
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.blueDark),
                        ),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              date.isNotEmpty ? date : "",
                              textAlign: TextAlign.center,
                              style: AppStyles.textStyle14.copyWith(color: Colors.black),
                            ),
                            if (date.isNotEmpty)
                              GestureDetector(
                                onTap: () {
                                  dsetState(() {
                                    date = '';
                                    singleObject[item.columnName!.toString()] = null;
                                  });
                                },
                                child: const Icon(Icons.close, color: Colors.blue, size: 18),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }
      /*if (item.insertType == "date" && item.categoryTitle == categoryName && condition) {
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
                            date = DateFormat("yyyy-MM-dd", 'en').format(dateTime);
                          });

                          dsetState(() {
                            singleObject.addAll({item.columnName!.toString(): dateTime.toString()});
                          });
                        }
                      },
                      child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.blueDark)),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            date,
                            textAlign: TextAlign.center,
                            style: AppStyles.textStyle14.copyWith(color: Colors.black),
                          )),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }*/

      //dropdown
      if (item.insertType == "dropdown" && item.categoryTitle == categoryName && condition) {
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
          if (ii.columnName == item.columnName && ii.nameAr == item.arColumnLabel) {
            myListDrop = ii.list;
          }
        }
        Pages? dropPage = getDropPage(item.pageId);

        String? selectedValue = singleObject[item.searchName!.toString()] != null
            ? myListDrop!
                .firstWhere(
                  (e) => e.id.toString() == singleObject[item.searchName!.toString()].toString(),
                  orElse: () => ItemDrop(id: '', text: ''),
                )
                .text
            : null;

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
                    const SizedBox(width: 12),
                    if (dropPage != null)
                      InkWell(
                        onTap: () async {
                          bool canAdd = await getPermissions(item.pageId);
                          if (canAdd) {
                            getColumnListAndAdd(dropPage);
                          } else {
                            CustomAlertDialog.alertWithButton(
                              context: context,
                              type: AlertType.error,
                              title: S.of(context).error,
                              desc: S.of(context).massage_no_permission,
                            );
                          }
                        },
                        child: const Icon(Icons.add, color: Colors.blue, size: 24),
                      ),
                    const SizedBox(width: 5),
                    InkWell(
                      onTap: () async {
                        getDropdownList(widget.pageData.pageId);
                      },
                      child: const Icon(Icons.refresh, color: Colors.green, size: 24),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomDropdown<String>.search(
                        hintText: '',
                        closedHeaderPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        decoration: CustomDropdownDecoration(
                          headerStyle: AppStyles.textStyle16.copyWith(color: Colors.black),
                          closedFillColor: Colors.transparent,
                          closedBorder: Border.all(color: AppColors.blueDark),
                        ),
                        initialItem: selectedValue,
                        items: myListDrop!.isEmpty
                            ? [""]
                            : List.generate(myListDrop.length, (index) => myListDrop![index].text ?? ''),
                        onChanged: (value) {
                          if (value != null && value.isNotEmpty) {
                            ItemDrop ii = myListDrop!.firstWhere((element) => element.text == value);
                            setState(() {
                              singleObject[item.searchName!.toString()] = ii.id;
                            });
                          }
                        },
                      ),
                    ),
                    if (selectedValue != null && selectedValue.isNotEmpty)
                      InkWell(
                        onTap: () {
                          setState(() {
                            singleObject.remove(item.searchName!.toString());
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsetsDirectional.only(start: 8),
                          child: Icon(Icons.close, color: Colors.red, size: 18),
                        ),
                      )
                  ],
                )
              ],
            ),
          ),
        );
      }
      /*if (item.insertType == "dropdown" && item.categoryTitle == categoryName && condition) {
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
                    closedHeaderPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: CustomDropdownDecoration(
                      headerStyle: AppStyles.textStyle16.copyWith(color: Colors.black),
                      closedFillColor: Colors.transparent,
                      closedBorder: Border.all(color: AppColors.blueDark),
                    ),
                    items:
                        myListDrop!.isEmpty ? [""] : List.generate(myListDrop.length, (index) => myListDrop![index].text ?? ''),
                    onChanged: (value) {
                      ItemDrop ii = myListDrop!.firstWhere((element) => element.text == value);
                      singleObject.addAll({item.searchName!.toString(): ii.id});
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }*/
      //checkbox
      if (item.insertType == "checkbox" && item.categoryTitle == categoryName && condition) {
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
                        style: AppStyles.textStyle14.copyWith(color: Colors.black),
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
                      singleObject.addAll({item.columnName!.toString(): checkboxValue});
                    });
                  });
            },
          ),
        );
      }
    }
    return list;
  }

  void getDataList() async {
    try {
      String companyKey = await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
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

      AddSupplyOrder.listProduct = dataProduct['dynamicList'];
      AddSupplyOrder.listBarcodeData = barcodeData['dynamicList'];
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
      String companyKey = await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
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

  void getColumnListAndAdd(Pages page) async {
    try {
      String companyKey = await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
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

  void getDropdownList(int pageId) async {
    try {
      String companyKey = await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
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

  getWidgetSupplyOrder({
    required String title,
    required List<ItemListSetupModel> listSetup,
  }) {
    switch (title) {
      case "الاجمالى":
        return Text(
          "$total",
          style: const TextStyle(color: Colors.red, fontSize: 20),
        );
      case "طريقة الشراء":
        ItemListSetupModel item = listSetup.firstWhere((element) => element.columnName == "purchaseTypeId");
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
          closedHeaderPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: CustomDropdownDecoration(
              headerStyle: AppStyles.textStyle16.copyWith(color: Colors.black),
              closedFillColor: Colors.transparent,
              closedBorder: Border.all(color: AppColors.blueDark)),
          items: myListDrop!.isEmpty ? [""] : List.generate(myListDrop.length, (index) => myListDrop![index].text ?? ''),
          onChanged: (value) {
            purchaseTypeId = int.parse(myListDrop!
                .firstWhere(
                  (element) => element.text == value!,
                )
                .id!);
            setState(() {});
          },
        );
      case "الضريبة":
        ItemListSetupModel item = listSetup.firstWhere((element) => element.columnName == "Tax");
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
          closedHeaderPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: CustomDropdownDecoration(
              headerStyle: AppStyles.textStyle16.copyWith(color: Colors.black),
              closedFillColor: Colors.transparent,
              closedBorder: Border.all(color: AppColors.blueDark)),
          items: myListDrop!.isEmpty ? [""] : List.generate(myListDrop.length, (index) => myListDrop![index].text ?? ''),
          onChanged: (value) {
            totalAfterTax = calculateTotalAfterTax(total: total, taxPercent: double.parse(value!));
            rest = calculateRemaining(
                totalAfterTax: totalAfterTax,
                paidValue: double.parse(paidController.text.isEmpty ? "0" : paidController.text.trim()));
            setState(() {});
          },
        );
      case "المتبقي":
        return Text(
          "$rest",
          style: const TextStyle(color: Colors.red, fontSize: 20),
        );

      case "الاجمالي بعد الضريبة":
        return Text(
          "$totalAfterTax",
          style: const TextStyle(color: Colors.red, fontSize: 20),
        );
      case "الدفعة":
        return Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                controller: ratePaidController,
                hintText: '',
                isValidator: false,
                keyboardType: TextInputType.number,
                onChanged: (newValue) {
                  paidController.text =
                      calculatePaid(totalAfterTax: totalAfterTax, paidPercent: newValue.isEmpty ? 0 : double.parse(newValue))
                          .toString();
                  rest = calculateRemaining(totalAfterTax: totalAfterTax, paidValue: double.parse(paidController.text));
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
                controller: paidController,
                hintText: '',
                isValidator: false,
                keyboardType: TextInputType.number,
                onChanged: (newValue) {
                  ratePaidController.text =
                      calculatePaidPercent(totalAfterTax: totalAfterTax, paid: newValue.isEmpty ? 0 : double.parse(newValue))
                          .toString();
                  rest =
                      calculateRemaining(totalAfterTax: totalAfterTax, paidValue: newValue.isEmpty ? 0 : double.parse(newValue));
                  setState(() {});
                },
              ),
            ),
          ],
        );
    }
  }

  double calculateTotalAfterTax({
    required double total,
    required double taxPercent,
  }) {
    double taxValue = total * taxPercent / 100;
    double totalAfterTax = total + taxValue;
    return totalAfterTax;
  }

  double calculateRemaining({
    required double totalAfterTax,
    required double paidValue,
  }) {
    double remaining = totalAfterTax - paidValue;
    return remaining;
  }

  double calculatePaidPercent({
    required double totalAfterTax,
    required double paid,
  }) {
    double paidPercent = (paid / totalAfterTax) * 100;
    return paidPercent;
  }

  double calculatePaid({
    required double totalAfterTax,
    required double paidPercent,
  }) {
    double paid = totalAfterTax * paidPercent / 100;
    return paid;
  }

// Map<String, dynamic> calculateInvoice({
//   required double total,
//   required double taxPercent,
//   required double paidInput,
//   required bool isPaidPercentage,
// }) {
//   double taxValue = total * taxPercent / 100;
//   double totalAfterTax = total + taxValue;
//
//   double paidValue;
//   double paidPercent;
//
//   if (isPaidPercentage) {
//     paidValue = totalAfterTax * paidInput / 100;
//     paidPercent = paidInput;
//   } else {
//     paidValue = paidInput;
//     paidPercent = (paidValue / totalAfterTax) * 100;
//   }
//
//   double remaining = totalAfterTax - paidValue;
//
//   return {
//     'taxValue': taxValue,
//     'totalAfterTax': totalAfterTax,
//     'paidValue': paidValue,
//     'paidPercent': paidPercent,
//     'remaining': remaining,
//   };
// }
}
