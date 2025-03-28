import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dio/dio.dart';
import 'package:erp_system/core/widgets/custom_loading_widget.dart';
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
import '../../../../../../core/utils/service_locator.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/widgets/custom_error_massage.dart';
import '../../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../home/presentation/widgets/home_view_body.dart';
import '../../../../data/models/dropdown_model/all_dropdown_model.dart';
import '../../../../data/models/item_list_setup_model.dart';
import '../../../../data/models/permission_model.dart';
import '../../../../data/models/screen_model.dart';
import '../../../../data/models/tap_model.dart';
import '../../../../data/repositories/screen_repo_impl.dart';
import '../../../manager/addEditExpenses/add_edit_expenses_cubit.dart';
import '../../../manager/getExpensesDetails/get_expenses_details_cubit.dart';
import '../../../manager/getExpensesMaster/get_expenses_master_cubit.dart';
import '../../../manager/getListSetups/get_list_setups_cubit.dart';
import '../../../manager/getTable/get_table_cubit.dart';
import '../../../views/screen_table.dart';
import '../build_alert_add_in_dropdown.dart';
import 'product_process_out_table_add_edit_.dart';

class EditProductProcessOut extends StatefulWidget {
  const EditProductProcessOut(
      {super.key, required this.pageData, required this.listKey, this.tapData});
  final ListTaps? tapData;
  final Pages pageData;
  final List<dynamic> listKey;
  // static List<Map<String, dynamic>> tableList = [];

  @override
  State<EditProductProcessOut> createState() => _EditProductProcessOutState();
}

class _EditProductProcessOutState extends State<EditProductProcessOut> {
  String? lang;
  GlobalKey<FormState> formKey = GlobalKey();
  Map<String, dynamic> singleObject = {};
  bool isShow = false;
  List<Map<String, dynamic>> tableList = [];
  late List<AllDropdownModel> myAllDropdownModelList;
  late String id;
  int selectIndxs = -1;

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    myAllDropdownModelList = ScreenTable.myAllDropdownModelList;
    // id = widget.pageData.tableSrc == AppStrings.tableGroup
    //     ? ScreenTable.rowData[0].toString()
    //     : ScreenTable.rowData[0][widget.pageData.primary].toString();
    id = ScreenTable.rowData[0].toString();
    super.initState();
  }

  @override
  void dispose() {
    // EditViewBody.tableList = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetExpensesMasterCubit(getIt.get<ScreenRepoImpl>())
        ..getExpensesMaster(id: id, controllerName: widget.pageData.controllerName),
      child: BlocBuilder<GetExpensesMasterCubit, GetExpensesMasterState>(
        builder: (context, state) {
          if (state is GetExpensesMasterSuccess) {
            // Map<String, dynamic> dataMaster = state.data;

            return BlocProvider(
              create: (context) => GetExpensesDetailsCubit(getIt.get<ScreenRepoImpl>())
                ..getExpensesDetails(
                    tapModel: ListTaps(
                        pageID: widget.tapData!.pageID,
                        pageDisplay: widget.tapData!.pageDisplay,
                        masterName: widget.tapData!.masterName,
                        modulName: widget.tapData!.modulName,
                        masterID: widget.tapData!.masterID,
                        modulID: widget.tapData!.modulID,
                        detailId: widget.tapData!.detailId,
                        listName: widget.tapData!.listName,
                        tableName: widget.tapData!.tableName,
                        primary: widget.tapData!.primary,
                        controllerName: widget.tapData!.controllerName,
                        tableSrc: widget.tapData!.tableSrc,
                        editSrc: widget.tapData!.editSrc,
                        isCompany: widget.tapData!.isCompany,
                        companyName: widget.tapData!.companyName,
                        showPrint: widget.tapData!.showPrint,
                        showExport: widget.tapData!.showExport,
                        showSearch: widget.tapData!.showSearch,
                        showEdit: widget.tapData!.showEdit,
                        showDelete: widget.tapData!.showDelete,
                        showRowPrint: widget.tapData!.showRowPrint,
                        showNew: widget.tapData!.showNew,
                        searchFirst: widget.tapData!.searchFirst,
                        showSetting: widget.tapData!.showSetting,
                        showMasterButton: widget.tapData!.showMasterButton,
                        canDrag: widget.tapData!.canDrag,
                        canGroup: widget.tapData!.canGroup,
                        showSum: widget.tapData!.showSum,
                        showColumnSetting: widget.tapData!.showColumnSetting,
                        showRefersh: widget.tapData!.showRefersh,
                        canSort: widget.tapData!.canSort,
                        showPaging: widget.tapData!.showPaging,
                        showGroup: widget.tapData!.showGroup,
                        dataSourceApi: widget.tapData!.dataSourceApi,
                        limit: widget.tapData!.limit,
                        orderBy: widget.tapData!.orderBy,
                        tailCondition: "${widget.tapData!.foreignKey}=$id",
                        master: widget.tapData!.master,
                        foreignKey: widget.tapData!.foreignKey,
                        foreignKeyValue: widget.tapData!.foreignKeyValue,
                        groupLayout: widget.tapData!.groupLayout,
                        groupColumn: widget.tapData!.groupColumn,
                        outSiderGroupColumn: widget.tapData!.outSiderGroupColumn,
                        editOnly: widget.tapData!.editOnly,
                        listMaster: widget.tapData!.listMaster,
                        excel: widget.tapData!.excel,
                        excelNew: widget.tapData!.excelNew,
                        showInPopUp: widget.tapData!.showInPopUp,
                        pageAttributeId: widget.tapData!.pageAttributeId,
                        displayArabic: widget.tapData!.displayArabic,
                        displayEnglish: widget.tapData!.displayEnglish,
                        displayChinese: widget.tapData!.displayChinese,
                        columnColor: widget.tapData!.columnColor,
                        enName: widget.tapData!.enName,
                        isDesc: widget.tapData!.isDesc,
                        unaryColumn: widget.tapData!.unaryColumn,
                        numberOfEmptyRow: widget.tapData!.numberOfEmptyRow,
                        offset: 0,
                        statment: widget.tapData!.statment)),
              child: BlocBuilder<GetExpensesDetailsCubit, GetExpensesDetailsState>(
                builder: (context, state) {
                  if (state is GetExpensesDetailsSuccess) {
                    Map<String, dynamic> dataMaster =
                        state.expensesDetailsModel.dynamicList![0];
                    List<Map<String, dynamic>> listDataInTable =
                        state.expensesDetailsModel.dynamicList!;
                    singleObject = dataMaster;

                    return BlocBuilder<GetListSetupsCubit, GetListSetupsState>(
                      builder: (context, state) {
                        if (state is GetListSetupsSuccess) {
                          List<ItemListSetupModel> listSetup = state.listSetupModel;
                          List<ItemListSetupModel> listColumn = [];
                          List<dynamic> listKey = [];
                          List<String> category = [];
                          List<String> listHeader = [];
                          for (var item in state.listSetupModel) {
                            category.add(item.categoryTitle ?? "");
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
                                                dataMaster: dataMaster);
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
                                                          ),
                                                        ),
                                                        ...widgetList,
                                                      ],
                                                    ),
                                                  )
                                                : const SizedBox();
                                          }),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 16),
                                            child: ProductProcessOutTableAddEdit(
                                              oldTableList: listDataInTable,
                                              tapData: widget.tapData,
                                              pageData: widget.pageData,
                                              listKey: listKey,
                                              listHeader: listHeader,
                                              listColumn: listColumn,
                                              allDropdownModelList:
                                                  ScreenTable.myAllDropdownModelList,
                                              onTapAction: (data) {
                                                tableList = data;
                                              },
                                              typeView: "Edit",
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
                                                      viewEmployeeColumn: widget
                                                          .pageData.viewEmployeeColumn,
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
                                                text: S.of(context).btn_edit,
                                                width: 80,
                                                onTap: () {
                                                  if (formKey.currentState!.validate()) {
                                                    formKey.currentState!.save();

                                                    BlocProvider.of<AddEditExpensesCubit>(
                                                            context)
                                                        .edit(
                                                      singleObject: singleObject,
                                                      tableList: tableList.isEmpty
                                                          ? listDataInTable
                                                          : tableList,
                                                      controllerName:
                                                          widget.tapData!.controllerName,
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
                  } else if (state is GetExpensesDetailsFailure) {
                    return CustomErrorMassage(errorMassage: state.errorMassage);
                  } else {
                    return const CustomLoadingWidget();
                  }
                },
              ),
            );
          } else if (state is GetExpensesMasterFailure) {
            return CustomErrorMassage(errorMassage: state.errorMassage);
          } else {
            return const CustomLoadingWidget();
          }
        },
      ),
    );
  }

  List<Widget> getMyWidgetList({
    required List<ItemListSetupModel> listData,
    required String categoryName,
    required Map<String, dynamic> dataMaster,
  }) {
    List<Widget> list = [];

    for (var item in listData) {
      String title =
          lang == AppStrings.arLangKey ? item.arColumnLabel! : item.enColumnLabel!;
      bool condition = item.insertVisable == true &&
          item.cvisable == false &&
          item.visible == false &&
          item.isGeneral == true;
      //text
      if (item.insertType == "text" && item.categoryTitle == categoryName && condition) {
        TextEditingController controller = TextEditingController(
            text: dataMaster[item.columnName].toString() == "null"
                ? ''
                : dataMaster[item.columnName]);
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
                        dataMaster.updateAll((key, value) =>
                            key == item.columnName!.toString()
                                ? value = controller.text
                                : value);
                        singleObject = dataMaster;
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
        TextEditingController controller = TextEditingController(
            text: dataMaster[item.columnName].toString() == "null"
                ? ''
                : dataMaster[item.columnName].toString());
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
                    if (newValue!.isNotEmpty) {
                      setState(() {
                        dataMaster.updateAll((key, value) =>
                            key == item.columnName!.toString()
                                ? value = controller.text
                                : value);
                        singleObject = dataMaster;
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
        String date;
        if (dataMaster[item.columnName] != null) {
          date = DateFormat("yyyy-MM-dd", 'en')
              .format(DateTime.parse(dataMaster[item.columnName].toString()).toLocal());
        } else {
          // date = DateFormat("yyyy-MM-dd", 'en').format(DateTime.now());
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
                            dataMaster.updateAll((key, value) =>
                                key == item.columnName!.toString()
                                    ? value = dateTime.toString()
                                    : value);
                            singleObject = dataMaster;
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
                            style: AppStyles.textStyle14.copyWith(color: Colors.black),
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
        String? dropValue;
        for (var i in myListDrop!) {
          if (i.id.toString() == dataMaster[item.searchName].toString()) {
            dropValue = i.text ?? '';
          }
          if (i.id.toString() == dataMaster[item.searchName].toString()) {
            dropValue = i.text ?? '';
          }
          if (i.id.toString() == dataMaster[item.columnName].toString()) {
            dropValue = i.text ?? '';
          }
          if (i.id.toString() == dataMaster[item.columnName].toString()) {
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
                  closedHeaderPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: CustomDropdownDecoration(
                      headerStyle: AppStyles.textStyle16.copyWith(color: Colors.black),
                      closedFillColor: Colors.transparent,
                      closedBorder: Border.all(color: AppColors.blueDark)),
                  // validator: (value) {
                  //   if (value?.isEmpty ?? true) {
                  //     return S.of(context).field_is_required;
                  //   } else {
                  //     return null;
                  //   }
                  // },
                  items: myListDrop.isEmpty
                      ? [""]
                      : List.generate(
                          myListDrop.length, (index) => myListDrop![index].text ?? ''),
                  onChanged: (value) {
                    ItemDrop ii =
                        myListDrop!.firstWhere((element) => element.text == value);
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
        bool checkboxValue = dataMaster[item.columnName] ?? false;
        list.add(
          StatefulBuilder(
            builder: (context, csetState) {
              return CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: checkboxValue,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    title,
                    style: AppStyles.textStyle14.copyWith(color: Colors.black),
                  ),
                  onChanged: (newValue) {
                    csetState(() {
                      checkboxValue = !checkboxValue;
                    });
                    csetState(() {
                      dataMaster.updateAll((key, value) =>
                          key == item.columnName!.toString()
                              ? value = checkboxValue
                              : value);
                      singleObject = dataMaster;
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
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
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
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
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
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
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
}
