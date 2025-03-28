import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dio/dio.dart';
import 'package:erp_system/core/widgets/custom_error_massage.dart';
import 'package:erp_system/core/widgets/custom_loading_widget.dart';
import 'package:erp_system/features/screenTable/data/models/item_list_setup_model.dart';
import 'package:erp_system/features/screenTable/presentation/manager/addEditExpenses/add_edit_expenses_cubit.dart';
import 'package:erp_system/features/screenTable/presentation/manager/getExpensesDetails/get_expenses_details_cubit.dart';
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
import '../../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../home/presentation/widgets/home_view_body.dart';
import '../../../../data/models/dropdown_model/all_dropdown_model.dart';
import '../../../../data/models/permission_model.dart';
import '../../../../data/models/screen_model.dart';
import '../../../../data/models/tap_model.dart';
import '../../../../data/repositories/screen_repo_impl.dart';
import '../../../manager/getExpensesMaster/get_expenses_master_cubit.dart';
import '../../../manager/getListSetups/get_list_setups_cubit.dart';
import '../../../manager/getTable/get_table_cubit.dart';
import '../../../views/screen_table.dart';
import '../build_alert_add_in_dropdown.dart';
import 'customer_order_table_add_edit.dart';

class EditCustomerOrder extends StatefulWidget {
  const EditCustomerOrder(
      {super.key, required this.pageData, required this.listKey, this.tapData});
  final ListTaps? tapData;
  final Pages pageData;
  final List<dynamic> listKey;
  // static List<Map<String, dynamic>> tableList = [];
  // static List<dynamic> listCustomerAccount = [];
  static List<dynamic> listProduct = [];
  static List<dynamic> listProductPrices = [];
  static List<dynamic> listBarcodeData = [];
  static int userId = -1;

  @override
  State<EditCustomerOrder> createState() => _EditCustomerOrderState();
}

class _EditCustomerOrderState extends State<EditCustomerOrder> {
  String? lang;
  GlobalKey<FormState> formKey = GlobalKey();
  Map<String, dynamic> singleObject = {};
  List<Map<String, dynamic>> tableList = [];
  late List<AllDropdownModel> myAllDropdownModelList;
  late String id;
  int selectIndxs = -1;

  List<String> listHeaderSales = [
    "الاجمالى",
    "الخصم",
    "مصاريف الشحن",
    "الضريبة",
    "المدفوع",
    "الحساب",
    "الباقي",
    "طريقة البيع",
  ];

  double total = 0.0;
  String dropdownAccount = "";
  String dropdownConTypeId = "";
  TextEditingController discountController = TextEditingController();
  TextEditingController discountPercentController = TextEditingController();
  TextEditingController shippingCostsController = TextEditingController();
  TextEditingController paidController = TextEditingController();
  TextEditingController restController = TextEditingController();

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
    getDataList();
    super.initState();
  }

  @override
  void dispose() {
    // EditViewBody.tableList = [];
    EditCustomerOrder.userId = -1;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetExpensesMasterCubit(getIt.get<ScreenRepoImpl>())
        ..getExpensesMaster(
            id: id, controllerName: widget.pageData.controllerName),
      child: BlocBuilder<GetExpensesMasterCubit, GetExpensesMasterState>(
        builder: (context, state) {
          if (state is GetExpensesMasterSuccess) {
            Map<String, dynamic> dataMaster = state.data;
            singleObject = dataMaster;
            total = dataMaster['TotalOrder'] ?? 0.0;
            return BlocProvider(
              create: (context) =>
                  GetExpensesDetailsCubit(getIt.get<ScreenRepoImpl>())
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
                            showColumnSetting:
                                widget.tapData!.showColumnSetting,
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
                            outSiderGroupColumn:
                                widget.tapData!.outSiderGroupColumn,
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
              child:
                  BlocBuilder<GetExpensesDetailsCubit, GetExpensesDetailsState>(
                builder: (context, state) {
                  if (state is GetExpensesDetailsSuccess) {
                    List<Map<String, dynamic>> listDataInTable =
                        state.expensesDetailsModel.dynamicList!;
                    tableList = listDataInTable;

                    return BlocBuilder<GetListSetupsCubit, GetListSetupsState>(
                      builder: (context, state) {
                        if (state is GetListSetupsSuccess) {
                          List<ItemListSetupModel> listSetup =
                              state.listSetupModel;
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
                                      padding:
                                          const EdgeInsets.only(bottom: 60),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ...List.generate(
                                                categoryList.length, (index) {
                                              String categoryName =
                                                  categoryList[index];
                                              List<Widget> widgetList =
                                                  getMyWidgetList(
                                                      listData: listSetup,
                                                      categoryName:
                                                          categoryName,
                                                      dataMaster: dataMaster);
                                              return widgetList.isNotEmpty
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 16),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        12,
                                                                    vertical:
                                                                        8),
                                                            decoration:
                                                                BoxDecoration(
                                                                    // color: AppColors.grey.withOpacity(.4),
                                                                    color: AppColors
                                                                        .grey
                                                                        .withAlpha(
                                                                            102),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15)),
                                                            child: Text(
                                                              categoryName,
                                                              style: AppStyles
                                                                  .textStyle18
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .black),
                                                            ),
                                                          ),
                                                          ...widgetList,
                                                        ],
                                                      ),
                                                    )
                                                  : const SizedBox();
                                            }),
                                            StatefulBuilder(
                                              builder: (context, ssetState) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 16),
                                                  child:
                                                      CustomerOrderTableAddEdit(
                                                    oldTableList:
                                                        listDataInTable,
                                                    tapData: widget.tapData,
                                                    pageData: widget.pageData,
                                                    listKey: listKey,
                                                    listHeader: listHeader,
                                                    listColumn: listColumn,
                                                    allDropdownModelList:
                                                        ScreenTable
                                                            .myAllDropdownModelList,
                                                    onTapAction: (data) {
                                                      total = 0.0;
                                                      ssetState(() {
                                                        tableList = data;
                                                      });
                                                      if (tableList
                                                          .isNotEmpty) {
                                                        for (var i
                                                            in tableList) {
                                                          salessetState(() {
                                                            total = total +
                                                                ((double.parse(i['DetailValue'].toString().isEmpty
                                                                            ? "0.0"
                                                                            : i[
                                                                                'DetailValue']) -
                                                                        double.parse(i['DetailDiscount'].toString().isEmpty
                                                                            ? "0.0"
                                                                            : i[
                                                                                'DetailDiscount'])) *
                                                                    double.parse(i['DetailQuantity']
                                                                            .toString()
                                                                            .isEmpty
                                                                        ? "1.0"
                                                                        : i['DetailQuantity']));

                                                            restController
                                                                .text = restValue(
                                                                    total:
                                                                        total,
                                                                    shippingPrice: shippingCostsController
                                                                            .text
                                                                            .isEmpty
                                                                        ? 0.0
                                                                        : double.parse(shippingCostsController
                                                                            .text),
                                                                    discountPercent: discountPercentController
                                                                            .text
                                                                            .isEmpty
                                                                        ? 0.0
                                                                        : double.parse(discountPercentController
                                                                            .text),
                                                                    cashCollected: paidController
                                                                            .text
                                                                            .isEmpty
                                                                        ? 0.0
                                                                        : double.parse(
                                                                            paidController.text))
                                                                .toString();
                                                          });
                                                        }
                                                      } else {
                                                        salessetState(() {
                                                          total = 0.0;
                                                        });
                                                      }
                                                    },
                                                    typeView: "Edit",
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
                                                          border:
                                                              BorderDirectional(
                                                        top: const BorderSide(
                                                            color: Colors.grey),
                                                        start: const BorderSide(
                                                            color: Colors.grey),
                                                        end: const BorderSide(
                                                            color: Colors.grey),
                                                        bottom: index ==
                                                                listHeaderSales.length -
                                                                    1
                                                            ? const BorderSide(
                                                                color:
                                                                    Colors.grey)
                                                            : BorderSide.none,
                                                      )),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Container(
                                                              height: 55,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8,
                                                                      vertical:
                                                                          5),
                                                              decoration:
                                                                  BoxDecoration(
                                                                      border:
                                                                          const BorderDirectional(
                                                                        end: BorderSide(
                                                                            color:
                                                                                Colors.grey,
                                                                            width: .5),
                                                                      ),
                                                                      color: listHeaderSales[index] == "الاجمالى" ||
                                                                              listHeaderSales[index] ==
                                                                                  "الباقي"
                                                                          ? Colors
                                                                              .cyanAccent
                                                                          : null),
                                                              alignment:
                                                                  AlignmentDirectional
                                                                      .centerStart,
                                                              child: Text(
                                                                  listHeaderSales[
                                                                      index]),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Container(
                                                              height: 55,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8,
                                                                      vertical:
                                                                          5),
                                                              decoration:
                                                                  BoxDecoration(
                                                                      border:
                                                                          const BorderDirectional(
                                                                        start: BorderSide(
                                                                            color:
                                                                                Colors.grey,
                                                                            width: .7),
                                                                      ),
                                                                      color: listHeaderSales[index] == "الاجمالى" ||
                                                                              listHeaderSales[index] ==
                                                                                  "الباقي"
                                                                          ? Colors
                                                                              .cyanAccent
                                                                          : null),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: getWidgetSales(
                                                                  title:
                                                                      listHeaderSales[
                                                                          index],
                                                                  listSetup:
                                                                      listSetup,
                                                                  oldDataMaster:
                                                                      dataMaster),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
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
                                              if (state
                                                  is AddEditExpensesSuccess) {
                                                BlocProvider.of<
                                                        GetTableCubit>(context)
                                                    .getTable(
                                                        pageId: widget
                                                            .pageData.pageId,
                                                        employee: false,
                                                        isdesc:
                                                            widget
                                                                .pageData.isDesc,
                                                        limit: 10,
                                                        offset: 0,
                                                        orderby:
                                                            widget.pageData
                                                                .orderBy,
                                                        statment: '',
                                                        selectcolumns: '',
                                                        departmentName:
                                                            widget.pageData
                                                                .departmentName,
                                                        isDepartment:
                                                            widget.pageData
                                                                .isDepartment,
                                                        authorizationID:
                                                            widget.pageData
                                                                .authorizationID,
                                                        viewEmployeeColumn: widget
                                                            .pageData
                                                            .viewEmployeeColumn,
                                                        numberOfPage: 1,
                                                        dropdownValueOfLimit:
                                                            10);
                                                Navigator.pop(context);
                                              } else if (state
                                                  is AddEditExpensesFailure) {
                                                CustomAlertDialog
                                                    .alertWithButton(
                                                        context: context,
                                                        type: AlertType.error,
                                                        title:
                                                            S.of(context).error,
                                                        desc:
                                                            state.errorMassage);
                                              }
                                            },
                                            builder: (context, state) {
                                              if (state
                                                  is AddEditExpensesLoading) {
                                                return const CustomLoadingWidget();
                                              } else {
                                                return CustomButton(
                                                  text: S.of(context).btn_edit,
                                                  width: 80,
                                                  onTap: () {
                                                    if (formKey.currentState!
                                                        .validate()) {
                                                      formKey.currentState!
                                                          .save();

                                                      singleObject.addAll({
                                                        "TotalOrder": total,
                                                        "MasterDescount": double
                                                            .parse(discountController
                                                                    .text
                                                                    .isEmpty
                                                                ? "0.0"
                                                                : discountController
                                                                    .text
                                                                    .trim()),
                                                        "ShippingPrice": double.parse(
                                                            shippingCostsController
                                                                    .text
                                                                    .isEmpty
                                                                ? "0.0"
                                                                : shippingCostsController
                                                                    .text
                                                                    .trim()),
                                                        "POPaid": double.parse(
                                                            paidController.text
                                                                    .isEmpty
                                                                ? "0.0"
                                                                : paidController
                                                                    .text
                                                                    .trim()),
                                                        "remind": double.parse(
                                                            restController.text
                                                                    .isEmpty
                                                                ? "0.0"
                                                                : restController
                                                                    .text
                                                                    .trim()),
                                                        "SafeAccount":
                                                            dropdownAccount,
                                                        "ConTypeId":
                                                            dropdownConTypeId,
                                                      });
                                                      // if (!mapEquals(
                                                      //     singleObject,
                                                      //     newSingleObject)) {
                                                      //   singleObject = Map.from(
                                                      //       newSingleObject); // حفظ التعديلات
                                                      //   print(
                                                      //       'تم التعديل: $singleObject');
                                                      // } else {
                                                      //   print('لا يوجد تعديل');
                                                      // }
                                                      BlocProvider.of<
                                                                  AddEditExpensesCubit>(
                                                              context)
                                                          .edit(
                                                              singleObject:
                                                                  singleObject,
                                                              tableList:
                                                                  tableList,
                                                              controllerName: widget
                                                                  .tapData!
                                                                  .controllerName);
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
                          return CustomErrorMassage(
                              errorMassage: state.errorMassage);
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
      if (item.insertType == "date" &&
          item.categoryTitle == categoryName &&
          condition) {
        String date;
        if (dataMaster[item.columnName] != null) {
          date = DateFormat("yyyy-MM-dd", 'en').format(
              DateTime.parse(dataMaster[item.columnName].toString()).toLocal());
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
                            date =
                                DateFormat("yyyy-MM-dd", 'en').format(dateTime);
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
        String? dropValue;
        for (var i in myListDrop!) {
          if (i.id.toString() == dataMaster[item.searchName].toString()) {
            dropValue = i.text ?? '';
            if (item.columnName == "CustomerID") {
              EditCustomerOrder.userId = int.parse(i.id ?? "-1");
            }
          }
          if (i.id.toString() == dataMaster[item.searchName].toString()) {
            dropValue = i.text ?? '';
            if (item.columnName == "CustomerID") {
              EditCustomerOrder.userId = int.parse(i.id ?? "-1");
            }
          }
          if (i.id.toString() == dataMaster[item.columnName].toString()) {
            dropValue = i.text ?? '';
            if (item.columnName == "CustomerID") {
              EditCustomerOrder.userId = int.parse(i.id ?? "-1");
            }
          }
          if (i.id.toString() == dataMaster[item.columnName].toString()) {
            dropValue = i.text ?? '';
            if (item.columnName == "CustomerID") {
              EditCustomerOrder.userId = int.parse(i.id ?? "-1");
            }
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
                      headerStyle:
                          AppStyles.textStyle16.copyWith(color: Colors.black),
                      closedFillColor: Colors.transparent,
                      closedBorder: Border.all(color: AppColors.blueDark)),
                  items: myListDrop.isEmpty
                      ? [""]
                      : List.generate(myListDrop.length,
                          (index) => myListDrop![index].text ?? ''),
                  onChanged: (value) {
                    ItemDrop ii = myListDrop!
                        .firstWhere((element) => element.text == value);
                    // singleObject.addAll({item.searchName!.toString(): ii.id});
                    dataMaster.updateAll((key, value) =>
                        key == item.columnName!.toString()
                            ? value = ii.id
                            : value);
                    singleObject = dataMaster;

                    if (item.columnName == "CustomerID") {
                      EditCustomerOrder.userId = int.parse(ii.id ?? "-1");
                    }
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

  getWidgetSales(
      {required String title,
      required List<ItemListSetupModel> listSetup,
      required Map<String, dynamic> oldDataMaster}) {
    switch (title) {
      case "الاجمالى":
        return Text(
          "$total",
          style: const TextStyle(color: Colors.red, fontSize: 20),
        );

      case "الخصم":
        discountController.text = oldDataMaster['MasterDescount'] != null
            ? oldDataMaster['MasterDescount'].toString()
            : "";
        discountPercentController.text = oldDataMaster['MasterDescount'] != null
            ? discountPercent(
                    total: double.parse(oldDataMaster['TotalOrder'] ?? 0.0),
                    discount:
                        double.parse(oldDataMaster['MasterDescount'] ?? 0.0))
                .toString()
            : "";
        return StatefulBuilder(
          builder: (context, wsetState) => Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  controller: discountPercentController,
                  hintText: '',
                  isValidator: false,
                  keyboardType: TextInputType.number,
                  onChanged: (newValue) {
                    changeDiscountPercent(newValue, wsetState);
                  },
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 2,
                child: CustomTextFormField(
                  controller: discountController,
                  hintText: '',
                  isValidator: false,
                  keyboardType: TextInputType.number,
                  onChanged: (newValue) {
                    changeDiscount(newValue, wsetState);
                  },
                ),
              ),
            ],
          ),
        );

      case "مصاريف الشحن":
        shippingCostsController.text = oldDataMaster['ShippingPrice'] != null
            ? oldDataMaster['ShippingPrice'].toString()
            : "";
        return StatefulBuilder(
          builder: (context, wsetState) => CustomTextFormField(
            controller: shippingCostsController,
            hintText: '',
            isValidator: false,
            keyboardType: TextInputType.number,
            onChanged: (newValue) {
              changeShippingCosts(newValue, wsetState);
            },
          ),
        );
      case "الضريبة":
        ItemListSetupModel item =
            listSetup.firstWhere((element) => element.columnName == "Tax");
        List<ListDrop>? listDrop = [];
        List<ItemDrop>? myListDrop = [];
        String val = "";
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
          if (ii.columnName == item.columnName &&
              ii.nameAr == item.arColumnLabel) {
            myListDrop = ii.list;
          }
        }
        for (var i in myListDrop!) {
          if (i.id == oldDataMaster['Tax']) {
            val = i.text!;
          }
        }
        return CustomDropdown<String>.search(
          hintText: '',
          initialItem: val,
          closedHeaderPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: CustomDropdownDecoration(
              headerStyle: AppStyles.textStyle16.copyWith(color: Colors.black),
              closedFillColor: Colors.transparent,
              closedBorder: Border.all(color: AppColors.blueDark)),
          items: myListDrop.isEmpty
              ? [""]
              : List.generate(
                  myListDrop.length, (index) => myListDrop![index].text ?? ''),
          onChanged: (value) {},
        );
      case "المدفوع":
        paidController.text = oldDataMaster['POPaid'] != null
            ? oldDataMaster['POPaid'].toString()
            : "";
        return StatefulBuilder(
          builder: (context, wsetState) => CustomTextFormField(
            controller: paidController,
            hintText: '',
            isValidator: false,
            keyboardType: TextInputType.number,
            onChanged: (newValue) {
              changePaid(newValue, wsetState);
            },
          ),
        );
      case "الحساب":
        dropdownAccount = oldDataMaster['SafeAccount'].toString();
        ItemListSetupModel item = listSetup
            .firstWhere((element) => element.columnName == "SafeAccount");
        List<ListDrop>? listDrop = [];
        List<ItemDrop>? myListDrop = [];
        String val = "";
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
          if (ii.columnName == item.columnName &&
              ii.nameAr == item.arColumnLabel) {
            myListDrop = ii.list;
          }
        }
        for (var i in myListDrop!) {
          if (i.id == oldDataMaster['SafeAccount'].toString()) {
            val = i.text!;
          } else {
            val = "null";
          }
        }
        return CustomDropdown<String>.search(
          hintText: '',
          initialItem: val == "null" ? null : val,
          closedHeaderPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: CustomDropdownDecoration(
              headerStyle: AppStyles.textStyle16.copyWith(color: Colors.black),
              closedFillColor: Colors.transparent,
              closedBorder: Border.all(color: AppColors.blueDark)),
          items: myListDrop.isEmpty
              ? [""]
              : List.generate(
                  myListDrop.length, (index) => myListDrop![index].text ?? ''),
          onChanged: (value) {
            ItemDrop ii =
                myListDrop!.firstWhere((element) => element.text == value);
            dropdownAccount = ii.id!;
          },
        );

      case "الباقي":
        restController.text = oldDataMaster['remind'] != null
            ? oldDataMaster['remind'].toString()
            : "0.0";
        return CustomTextFormField(
          controller: restController,
          hintText: '',
          isBorder: false,
          readOnly: true,
          isValidator: false,
          keyboardType: TextInputType.number,
          textStyle: const TextStyle(color: Colors.red, fontSize: 20),
        );

      case "طريقة البيع":
        dropdownConTypeId = oldDataMaster['ConTypeId'].toString();
        ItemListSetupModel item = listSetup
            .firstWhere((element) => element.columnName == "ConTypeId");
        List<ListDrop>? listDrop = [];
        List<ItemDrop>? myListDrop = [];
        String val = "";

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
          if (ii.columnName == item.columnName &&
              ii.nameAr == item.arColumnLabel) {
            myListDrop = ii.list;
          }
        }
        for (var i in myListDrop!) {
          if (i.id == oldDataMaster['ConTypeId'].toString()) {
            val = i.text!;
          } else {
            val = "null";
          }
        }
        return CustomDropdown<String>.search(
          hintText: '',
          initialItem: val == "null" ? null : val,
          closedHeaderPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: CustomDropdownDecoration(
              headerStyle: AppStyles.textStyle16.copyWith(color: Colors.black),
              closedFillColor: Colors.transparent,
              closedBorder: Border.all(color: AppColors.blueDark)),
          items: myListDrop.isEmpty
              ? [""]
              : List.generate(
                  myListDrop.length, (index) => myListDrop![index].text ?? ''),
          onChanged: (value) {
            ItemDrop ii =
                myListDrop!.firstWhere((element) => element.text == value);
            dropdownConTypeId = ii.id!;
          },
        );
    }
  }

  void changePaid(String newValue, StateSetter wsetState) {
    restController.text = restValue(
            total: total,
            shippingPrice: shippingCostsController.text.isEmpty
                ? 0.0
                : double.parse(shippingCostsController.text),
            discountPercent: discountPercentController.text.isEmpty
                ? 0.0
                : double.parse(discountPercentController.text),
            cashCollected: newValue.isEmpty ? 0.0 : double.parse(newValue))
        .toString();
    wsetState(() {});
  }

  void changeShippingCosts(String newValue, StateSetter wsetState) {
    restController.text = restValue(
            total: total,
            shippingPrice: newValue.isEmpty ? 0.0 : double.parse(newValue),
            discountPercent: discountPercentController.text.isEmpty
                ? 0.0
                : double.parse(discountPercentController.text),
            cashCollected: paidController.text.isEmpty
                ? 0.0
                : double.parse(paidController.text))
        .toString();
    wsetState(() {});
  }

  void changeDiscountPercent(String newValue, StateSetter wsetState) {
    discountController.text = discount(
            total: total,
            discountPercent: newValue.isEmpty ? 0.0 : double.parse(newValue))
        .toString();
    restController.text = restValue(
            total: total,
            shippingPrice: shippingCostsController.text.isEmpty
                ? 0.0
                : double.parse(shippingCostsController.text),
            discountPercent: newValue.isEmpty ? 0.0 : double.parse(newValue),
            cashCollected: paidController.text.isEmpty
                ? 0.0
                : double.parse(paidController.text))
        .toString();
    wsetState(() {});
  }

  void changeDiscount(String newValue, StateSetter wsetState) {
    discountPercentController.text = discountPercent(
            total: total,
            discount: newValue.isEmpty ? 0.0 : double.parse(newValue))
        .toString();
    restController.text = restValue(
            total: total,
            shippingPrice: shippingCostsController.text.isEmpty
                ? 0.0
                : double.parse(shippingCostsController.text),
            discountPercent: discountPercentController.text.isEmpty
                ? 0.0
                : double.parse(discountPercentController.text),
            cashCollected: paidController.text.isEmpty
                ? 0.0
                : double.parse(paidController.text))
        .toString();
    wsetState(() {});
  }

  double discount({required double total, required double discountPercent}) {
    return discountPercent * total / 100;
  }

  double discountPercent({required double total, required double discount}) {
    return 100 * discount / total;
  }

  double totalAfterDiscount(
      {required double total, required double discountPercent}) {
    return total - discount(total: total, discountPercent: discountPercent);
  }

  double restValue(
      {required double total,
      required double shippingPrice,
      required double discountPercent,
      required double cashCollected}) {
    return cashCollected -
        (totalAfterDiscount(
              discountPercent: discountPercent,
              total: total,
            ) +
            shippingPrice);
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

      Map<String, dynamic> dataProductPrices = await ApiService(Dio()).post(
        endPoint: "web/Structure/getDataGlobal",
        data: {"TableName": "ProductPrices"},
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      // Map<String, dynamic> dataCustomerAccount = await ApiService(Dio()).post(
      //   endPoint: "web/Structure/getDataGlobal",
      //   data: {"TableName": "CustomerAccount"},
      //   headers: {
      //     "Authorization": "Bearer $token",
      //     "CompanyKey": companyKey,
      //   },
      // );

      Map<String, dynamic> barcodeData = await ApiService(Dio()).post(
        endPoint: "web/Structure/getDataGlobal",
        data: {"TableName": "BarcodeData"},
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );

      EditCustomerOrder.listProduct = dataProduct['dynamicList'];
      EditCustomerOrder.listProductPrices = dataProductPrices['dynamicList'];
      // EditCustomerOrder.listCustomerAccount = dataCustomerAccount['dynamicList'];
      EditCustomerOrder.listBarcodeData = barcodeData['dynamicList'];
    } catch (e) {
      debugPrint(e.toString());
    }
  }

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

  // bool mapEquals(Map<String, dynamic> singleObject, Map<String, dynamic> newSingleObject) {
  //   return singleObject.length == newSingleObject.length &&
  //       singleObject.keys.every((key) => newSingleObject.containsKey(key) && singleObject[key] == newSingleObject[key]);
  // }
}
