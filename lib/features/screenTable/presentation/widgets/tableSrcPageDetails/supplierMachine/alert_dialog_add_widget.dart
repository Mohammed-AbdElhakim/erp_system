import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dio/dio.dart';
import 'package:erp_system/features/screenTable/presentation/widgets/tableSrcPageDetails/machineWork/add_machine_work.dart';
import 'package:flutter/material.dart';
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
import '../../../../data/models/item_list_setup_model.dart';
import '../../../../data/models/permission_model.dart';
import '../../../../data/models/screen_model.dart';
import '../../../../data/models/tap_model.dart';
import '../build_alert_add_in_dropdown.dart';

typedef OnTapAdd<T> = void Function(T data);

class AlertDialogAddWidget extends StatefulWidget {
  const AlertDialogAddWidget({
    super.key,
    required this.listHeader,
    required this.listKey,
    required this.listColumn,
    required this.allDropdownModelList,
    required this.pageData,
    this.tapData,
    required this.onTapAdd,
  });

  final ListTaps? tapData;
  final List<String> listHeader;
  final List<dynamic> listKey;
  final List<ItemListSetupModel> listColumn;
  final List<AllDropdownModel> allDropdownModelList;
  final Pages pageData;
  final OnTapAdd<Map<String, dynamic>> onTapAdd;

  @override
  State<AlertDialogAddWidget> createState() => _AlertDialogAddWidgetState();
}

class _AlertDialogAddWidgetState extends State<AlertDialogAddWidget> {
  String? lang;
  GlobalKey<FormState> formKey = GlobalKey();
  Map<String, dynamic> newRowData = {};
  late List<AllDropdownModel> myAllDropdownModelList;

  Map<String, dynamic> fieldValues = {};
  Map<String, TextEditingController> controllers = {};

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    myAllDropdownModelList = widget.allDropdownModelList;
    for (var item in widget.listColumn) {
      controllers[item.columnName!] = TextEditingController(text: fieldValues[item.columnName] ?? '');
    }
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
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
                    ...getMyWidgetList(columnList: widget.listColumn, show: true),
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
                  CustomButton(
                    text: S.of(context).btn_add,
                    width: 80,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        widget.onTapAdd(newRowData);
                        // AddViewBody.tableList.add(newRowData);
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

  List<Widget> getMyWidgetList({
    required List<ItemListSetupModel> columnList,
    required bool show,
  }) {
    List<Widget> list = [];

    for (var item in columnList) {
      String title = lang == AppStrings.arLangKey ? item.arColumnLabel! : item.enColumnLabel!;

      // Text Field
      if (item.insertType == "text") {
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
                CustomTextFormField(
                  hintText: '',
                  isValidator: item.isRquired!,
                  keyboardType: TextInputType.text,
                  controller: controllers[item.columnName],
                  onChanged: (newValue) {
                    setState(() {
                      fieldValues[item.columnName!] = newValue;
                      newRowData[item.columnName!] = newValue;
                    });
                  },
                ),
              ],
            ),
          ),
        );
      }

      // Number Field
      else if (item.insertType == "number") {
        final isReadOnly = ['totalquntity', 'finalquntity', 'totalprice', 'filnaltotal'].contains(item.columnName);
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
                CustomTextFormField(
                  hintText: '',
                  isValidator: item.isRquired!,
                  keyboardType: TextInputType.number,
                  controller: controllers[item.columnName],
                  readOnly: isReadOnly,
                  fillColor: Colors.grey.shade400,
                  filled: isReadOnly,
                  onChanged: (newValue) {
                    setState(() {
                      fieldValues[item.columnName!] = newValue;
                      newRowData[item.columnName!] = newValue;

                      if (['MWPrice', 'MWCount', 'Discount1', 'Discount2', 'UnitQuntity', 'DiscountQuntity']
                          .contains(item.columnName)) {
                        calculate();
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        );
      }

      // Date Field
      else if (item.insertType == "date") {
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
                          String formattedDate = DateFormat("yyyy-MM-dd", 'en').format(dateTime);
                          dsetState(() {
                            fieldValues[item.columnName!] = formattedDate;
                          });
                          setState(() {
                            newRowData[item.columnName!] = dateTime.toString();
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
                              fieldValues[item.columnName] ?? '',
                              textAlign: TextAlign.center,
                              style: AppStyles.textStyle14.copyWith(color: Colors.black),
                            ),
                            if ((fieldValues[item.columnName] ?? '').isNotEmpty)
                              GestureDetector(
                                onTap: () {
                                  dsetState(() {
                                    fieldValues[item.columnName!] = '';
                                  });
                                  setState(() {
                                    newRowData.remove(item.columnName!);
                                  });
                                },
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.blue,
                                  size: 18,
                                ),
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

      /*else if (item.insertType == "date") {
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
                          String formattedDate = DateFormat("yyyy-MM-dd", 'en').format(dateTime);
                          dsetState(() {
                            fieldValues[item.columnName!] = formattedDate;
                          });
                          setState(() {
                            newRowData[item.columnName!] = dateTime.toString();
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
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          fieldValues[item.columnName] ?? '',
                          textAlign: TextAlign.center,
                          style: AppStyles.textStyle14.copyWith(color: Colors.black),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }*/

      // Dropdown Field
      else if (item.insertType == "dropdown") {
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

        // حدد القيمة الحالية المختارة
        String? selectedValue = newRowData[item.searchName!.toString()] != null
            ? myListDrop!
                .firstWhere(
                  (e) => e.id.toString() == newRowData[item.searchName!.toString()].toString(),
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
                    if (item.isRquired == true) const Icon(Icons.star, color: Colors.red, size: 10),
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
                              newRowData[item.searchName!.toString()] = ii.id;
                            });
                          }
                        },
                      ),
                    ),
                    if (selectedValue != null && selectedValue.isNotEmpty)
                      InkWell(
                        onTap: () {
                          setState(() {
                            newRowData.remove(item.searchName!.toString());
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsetsDirectional.only(start: 8),
                          child: Icon(Icons.close, color: Colors.red, size: 18),
                        ),
                      )
                  ],
                ),
              ],
            ),
          ),
        );
      }
      /*else if (item.insertType == "dropdown") {
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
                CustomDropdown<String>.search(
                  hintText: '',
                  closedHeaderPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: CustomDropdownDecoration(
                      headerStyle: AppStyles.textStyle16.copyWith(color: Colors.black),
                      closedFillColor: Colors.transparent,
                      closedBorder: Border.all(color: AppColors.blueDark)),
                  items: myListDrop!.isEmpty ? [""] : List.generate(myListDrop.length, (index) => myListDrop![index].text ?? ''),
                  // initialValue: fieldValues[item.columnName],
                  onChanged: (value) {
                    ItemDrop ii = myListDrop!.firstWhere((element) => element.text == value);
                    setState(() {
                      fieldValues[item.columnName!] = value;
                      newRowData[item.searchName!] = ii.id;
                      if ((item.columnName == 'MWDTypeID' && newRowData['MachinProcessID'] != null) ||
                          (item.columnName == 'MachinProcessID' && newRowData['MWDTypeID'] != null)) {
                        getDataToCalculate();
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        );
      }*/

      // Checkbox Field
      else if (item.insertType == "checkbox") {
        list.add(
          StatefulBuilder(
            builder: (context, csetState) {
              return CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: fieldValues[item.columnName] ?? false,
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
                    fieldValues[item.columnName!] = newValue;
                  });
                  setState(() {
                    newRowData[item.columnName!] = newValue;
                  });
                },
              );
            },
          ),
        );
      }
    }

    return list;
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

  void calculate() {
    //السعر
    double mWPrice = double.tryParse(controllers['MWPrice']?.text ?? '') ?? 0;
    //العدد
    double mWCount = double.tryParse(controllers['MWCount']?.text ?? '') ?? 0;
    //خصم سولار
    double discount1 = double.tryParse(controllers['Discount1']?.text ?? '') ?? 0;
    //خصم
    double discount2 = double.tryParse(controllers['Discount2']?.text ?? '') ?? 0;
    //عدد الوحدات
    double unitQuntity = double.tryParse(controllers['UnitQuntity']?.text ?? '') ?? 0;
    //خصم كمية
    double discountQuntity = double.tryParse(controllers['DiscountQuntity']?.text ?? '') ?? 0;

    //اجمالي الكمية
    double totalquntity = mWCount * unitQuntity;
    //صافي الكمية
    double finalquntity = totalquntity - discountQuntity;
    //اجمالي السعر
    double totalprice = mWPrice * finalquntity;
    //صافي السعر
    double filnaltotal = totalprice - (discount1 + discount2);

    // الحقول اللي مسموح نعدلها
    final readOnlyFields = {
      'totalquntity': totalquntity,
      'finalquntity': finalquntity,
      'totalprice': totalprice,
      'filnaltotal': filnaltotal,
    };

    // تحديث الحقول القابلة للقراءة فقط
    readOnlyFields.forEach((key, value) {
      if (controllers[key] != null) {
        controllers[key]!.text = value.toStringAsFixed(2);
        fieldValues[key] = value.toStringAsFixed(2);
        newRowData[key] = value.toStringAsFixed(2);
      }
    });
  }

  void getDataToCalculate() {
    Map<String, dynamic>? itemMachine = AddMachineWork.listMachineProcess.cast<Map<String, dynamic>?>().firstWhere(
          (element) => element?['MPID']?.toString() == newRowData['MachinProcessID'],
          orElse: () => null,
        );

    final showDataInFields = {
      'UnitQuntity': newRowData['MWDTypeID'] == "3" ? itemMachine!['Capacty'] : 1,
      'MWPrice': newRowData['MWDTypeID'] == "1"
          ? itemMachine!['Dayprice']
          : newRowData['MWDTypeID'] == "2"
              ? itemMachine!['HourPrice']
              : newRowData['MWDTypeID'] == "3"
                  ? itemMachine!['ProcessPrice']
                  : 1,
    };

    showDataInFields.forEach((key, value) {
      if (controllers[key] != null) {
        controllers[key]!.text = value.toStringAsFixed(2);
        fieldValues[key] = value.toStringAsFixed(2);
        newRowData[key] = value.toStringAsFixed(2);
      }
    });
    calculate();
  }
}
