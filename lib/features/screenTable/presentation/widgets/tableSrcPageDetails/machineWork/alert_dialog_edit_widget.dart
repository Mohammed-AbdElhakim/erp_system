import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dio/dio.dart';
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
import 'edit_machine_work.dart';

typedef OnTapAdd<T> = void Function(T data);

class AlertDialogEditWidget extends StatefulWidget {
  const AlertDialogEditWidget({
    super.key,
    required this.listHeader,
    required this.listKey,
    required this.listColumn,
    required this.allDropdownModelList,
    required this.pageData,
    this.tapData,
    required this.onTapAdd,
    required this.dataOld,
  });

  final ListTaps? tapData;
  final List<String> listHeader;
  final List<dynamic> listKey;
  final List<ItemListSetupModel> listColumn;
  final List<AllDropdownModel> allDropdownModelList;
  final Pages pageData;
  final OnTapAdd<Map<String, dynamic>> onTapAdd;
  final Map<String, dynamic> dataOld;

  @override
  State<AlertDialogEditWidget> createState() => _AlertDialogEditWidgetState();
}

class _AlertDialogEditWidgetState extends State<AlertDialogEditWidget> {
  String? lang;
  GlobalKey<FormState> formKey = GlobalKey();
  Map<String, dynamic> newRowData = {};
  late List<AllDropdownModel> myAllDropdownModelList;
  Map<String, dynamic> fieldValues = {};
  final Map<String, TextEditingController> controllers = {};

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    myAllDropdownModelList = widget.allDropdownModelList;
    fieldValues = widget.dataOld;
    for (var item in widget.listColumn) {
      controllers[item.columnName!] =
          TextEditingController(text: fieldValues[item.columnName] == null ? '' : fieldValues[item.columnName].toString());
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
                    ...getMyWidgetList(columnList: widget.listColumn, show: true, oldData: widget.dataOld),
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
                    text: S.of(context).btn_edit,
                    width: 80,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        newRowData = Map<String, dynamic>.from(widget.dataOld);
                        // print("===========================");
                        // print(newRowData);
                        // print("============================");
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

  List<Widget> getMyWidgetList({
    required List<ItemListSetupModel> columnList,
    required bool show,
    required Map<String, dynamic> oldData,
  }) {
    List<Widget> list = [];
    for (var item in columnList) {
      String title = lang == AppStrings.arLangKey ? item.arColumnLabel! : item.enColumnLabel!;
      //text
      if (item.insertType == "text") {
        String key = item.columnName!;
        if (!controllers.containsKey(key)) {
          controllers[key] = TextEditingController(
            text: oldData[key]?.toString() == "null" ? '' : oldData[key]?.toString() ?? '',
          );
        }
        TextEditingController controller = controllers[key]!;
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
                  controller: controller,
                  isValidator: item.isRquired!,
                  keyboardType: TextInputType.text,
                  onSaved: (newValue) {
                    if (newValue!.isNotEmpty) {
                      setState(() {
                        oldData[item.columnName!.toString()] = controller.text;
                        // newRowData = oldData;
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
      if (item.insertType == "number") {
        final isReadOnly = ['totalquntity', 'finalquntity', 'totalprice', 'filnaltotal'].contains(item.columnName);

        String key = item.columnName!;
        if (!controllers.containsKey(key)) {
          controllers[key] = TextEditingController(
            text: oldData[key]?.toString() == "null" ? '' : oldData[key]?.toString() ?? '',
          );
        }
        TextEditingController controller = controllers[key]!;
        // TextEditingController controller =
        //     TextEditingController(text: oldData[item.columnName].toString() == "null" ? '' : oldData[item.columnName].toString());
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
                  controller: controller,
                  isValidator: item.isRquired!,
                  keyboardType: TextInputType.number,
                  onSaved: (newValue) {
                    // if (newValue != null && newValue.isNotEmpty) {
                    //   print("=========$key =====$newValue");
                    //   oldData[key] = newValue;
                    //   print("=========$oldData");
                    //   newRowData = oldData;
                    //   print("=========$newRowData");
                    // }
                    // if (newValue!.isNotEmpty) {
                    setState(() {
                      oldData[key] = newValue;
                      // oldData[item.columnName!.toString()] = controller.text;
                      // newRowData = oldData;
                    });
                    // }
                  },
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
      //Date
      if (item.insertType == "date") {
        String date;
        if (oldData[item.columnName] != null) {
          date = DateFormat("yyyy-MM-dd", 'en').format(DateTime.parse(oldData[item.columnName].toString()).toLocal());
        } else {
          date = '';
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
                      ),
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
                            oldData[item.columnName!.toString()] = dateTime.toString();
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
                                    oldData[item.columnName!.toString()] = null;
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
      /*if (item.insertType == "date") {
        // String date;
        // if (oldData[item.columnName] != null) {
        //   date = DateFormat("yyyy-MM-dd", 'en').format(DateTime.parse(oldData[item.columnName].toString()).toLocal());
        // } else {
        //   // date = DateFormat("yyyy-MM-dd", 'en').format(DateTime.now());
        //   date = '';
        // }
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
                            oldData[item.columnName!.toString()] = dateTime.toString();
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
                              borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.blueDark)),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            fieldValues[item.columnName] != null
                                ? DateFormat("yyyy-MM-dd", 'en').format(DateTime.parse(fieldValues[item.columnName]).toLocal())
                                : "",
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
      if (item.insertType == "dropdown") {
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
          if (ii.columnName == item.columnName && ii.nameAr == item.arColumnLabel) {
            myListDrop = ii.list;
          }
        }

        String? dropValue;
        for (var i in myListDrop!) {
          if (i.id.toString() == oldData[item.searchName].toString() || i.id.toString() == oldData[item.columnName].toString()) {
            dropValue = i.text ?? '';
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
                    if (item.isRquired == true) const Icon(Icons.star, color: Colors.red, size: 10),
                    const SizedBox(width: 12),
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
                        initialItem: dropValue,
                        closedHeaderPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        decoration: CustomDropdownDecoration(
                          headerStyle: AppStyles.textStyle16.copyWith(color: Colors.black),
                          closedFillColor: Colors.transparent,
                          closedBorder: Border.all(color: AppColors.blueDark),
                        ),
                        items: myListDrop.isEmpty
                            ? [""]
                            : List.generate(myListDrop.length, (index) => myListDrop![index].text ?? ''),
                        onChanged: (value) {
                          ItemDrop ii = myListDrop!.firstWhere((element) => element.text == value);

                          setState(() {
                            oldData[item.columnName!.toString()] = ii.id.toString();
                          });
                        },
                      ),
                    ),
                    if (dropValue != null && dropValue.isNotEmpty)
                      InkWell(
                        onTap: () {
                          setState(() {
                            oldData.remove(item.columnName!.toString());
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsetsDirectional.only(start: 8),
                          child: Icon(Icons.close, color: Colors.red, size: 18),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
      /*if (item.insertType == "dropdown") {
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
          if (ii.columnName == item.columnName && ii.nameAr == item.arColumnLabel) {
            myListDrop = ii.list;
          }
        }
        String? dropValue;
        for (var i in myListDrop!) {
          if (i.id.toString() == oldData[item.searchName].toString()) {
            dropValue = i.text ?? '';
          }
          if (i.id.toString() == oldData[item.searchName].toString()) {
            dropValue = i.text ?? '';
          }
          if (i.id.toString() == oldData[item.columnName].toString()) {
            dropValue = i.text ?? '';
          }
          if (i.id.toString() == oldData[item.columnName].toString()) {
            dropValue = i.text ?? '';
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
                CustomDropdown<String>.search(
                  hintText: '',
                  initialItem: dropValue,
                  closedHeaderPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: CustomDropdownDecoration(
                      headerStyle: AppStyles.textStyle16.copyWith(color: Colors.black),
                      closedFillColor: Colors.transparent,
                      closedBorder: Border.all(color: AppColors.blueDark)),
                  items: myListDrop.isEmpty ? [""] : List.generate(myListDrop.length, (index) => myListDrop![index].text ?? ''),
                  onChanged: (value) {
                    ItemDrop ii = myListDrop!.firstWhere((element) => element.text == value);
                    setState(() {
                      oldData[item.columnName!.toString()] = ii.id;
                      fieldValues[item.columnName!] = value;
                      newRowData[item.searchName!] = ii.id;
                      if (['MWDTypeID'].contains(item.columnName)) {
                        getDataToCalculate(ii.id!);
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        );
      }*/
      //checkbox
      if (item.insertType == "checkbox") {
        bool checkboxValue = oldData[item.columnName] ?? false;
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
                      oldData[item.columnName!.toString()] = checkboxValue;
                      fieldValues[item.columnName!] = newValue;
                    });
                    setState(() {
                      newRowData[item.columnName!] = newValue;
                    });
                  });
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

  void getDataToCalculate(String typeId) {
    Map<String, dynamic>? itemMachine = EditMachineWork.listMachineProcess.cast<Map<String, dynamic>?>().firstWhere(
          (element) => element?['MPID']?.toString() == newRowData['MachinProcessID'],
          orElse: () => null,
        );

    final showDataInFields = {
      'UnitQuntity': typeId == "3" ? itemMachine!['Capacty'] : 1,
      'MWPrice': typeId == "1"
          ? itemMachine!['Dayprice']
          : typeId == "2"
              ? itemMachine!['HourPrice']
              : typeId == "3"
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
