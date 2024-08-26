import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dio/dio.dart';
import 'package:erp_system/core/utils/app_colors.dart';
import 'package:erp_system/core/widgets/custom_loading_widget.dart';
import 'package:erp_system/features/cashier/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../core/helper/AlertDialog/custom_alert_dialog.dart';
import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/widgets/home_view_body.dart';
import '../../data/models/all_dropdown_model.dart';
import '../../data/models/item_list_setup_model.dart';
import '../../data/models/modality_model.dart';
import '../../data/models/permission_model.dart';
import '../../data/models/pro_company_model.dart';
import '../../data/models/screen_model.dart';
import '../../data/models/tap_model.dart';
import '../../data/repositories/cashier_repo_impl.dart';
import '../manager/addEdit/add_edit_cubit.dart';
import '../manager/addEditProduct/add_edit_product_cubit.dart';
import '../views/barcode_view.dart';
import '../views/cashier_view.dart';
import 'build_alert_add_in_dropdown.dart';
import 'custom_product_item_widget.dart';
import 'custom_search.dart';
import 'sales_table_add_edit_.dart';

class CashierViewBody extends StatefulWidget {
  const CashierViewBody({
    super.key,
    required this.allProCompanyList,
    required this.allModalityList,
    required this.allProductList,
    required this.listSetup,
    required this.pageData,
    required this.tapData,
    required this.listColumn,
    required this.listHeader,
  });
  final Pages pageData;
  final List<ProCompanyItem> allProCompanyList;
  final List<ModalityItem> allModalityList;
  final List<ProductItem> allProductList;
  final List<ItemListSetupModel> listSetup;
  final ListTaps? tapData;
  final List<ItemListSetupModel> listColumn;
  final List<String> listHeader;
  static int userId = -1;
  static List<dynamic> listProduct = [];
  static List<dynamic> listCustomerAccount = [];
  static List<dynamic> listBarcodeData = [];
  static List<dynamic> listProductPrices = [];
  static List<dynamic> listCustomerAccountLocation = [];
  static List<Map<String, dynamic>> tableList = [];

  @override
  State<CashierViewBody> createState() => _CashierViewBodyState();
}

class _CashierViewBodyState extends State<CashierViewBody> {
  final PageController _pageController = PageController();

  int _currentPage = 0;
  late int companyId;
  List<ModalityItem> modalityList = [];
  List<ProductItem> productList = [];
  late int modalityId;
  final List<Map<String, dynamic>> widgetsData = [];
  late List<AllDropdownModel> myAllDropdownModelList;
  Map<String, dynamic> singleObject = {};
  String? lang;

  //------------
  late int customerCategoryID;
  late int productId;
  late String proName;
  late double proPrice;
  int indexSelect = -1;

  double? lat;
  double? long;
  bool isGetLocationAndListLocation = false;
  //==================
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
  TextEditingController deadlineClientController = TextEditingController();
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
    initStatePage1();
    initStatePage2();
    getDataList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
              if (_currentPage != 0) {
                if (CashierViewBody.userId == -1) {
                  CustomAlertDialog.alertWithButton(
                      context: context,
                      type: AlertType.warning,
                      title: S.of(context).warning,
                      textButton: S.of(context).ok,
                      desc: S.of(context).select_client,
                      onPressed: () {
                        _pageController.jumpToPage(0);
                        Navigator.of(context).pop();
                      });
                }
              }
            },
            children: [
              _buildPage1(),
              _buildPage2(),
              _buildPage3(),
            ],
          ),
        ),
        navigationPageView(),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    CashierViewBody.tableList = [];
    CashierViewBody.userId = -1;
    super.dispose();
  }

  Widget _buildPage1() {
//تقسيم ال list  الى مجموعات
    final Map<String, List<Map<String, dynamic>>> groupData = {};
    for (var item in widgetsData) {
      if (!groupData
          .containsKey((item['widget'] as ItemListSetupModel).categoryTitle)) {
        groupData[(item['widget'] as ItemListSetupModel).categoryTitle!] = [];
      }
      groupData[(item['widget'] as ItemListSetupModel).categoryTitle]!
          .add(item);
    }
    return Padding(
      padding: const EdgeInsets.all(12),
      child: ListView(
        children: groupData.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildCategoryName(entry),
              buildCategoryChildren(entry),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget buildCategoryChildren(
      MapEntry<String, List<Map<String, dynamic>>> entry) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(
            entry.value.length,
            (index) {
              final widgetData = entry.value[index];
              ItemListSetupModel itemListSetupModel = widgetData['widget'];
              String title = lang == AppStrings.arLangKey
                  ? itemListSetupModel.arColumnLabel!
                  : itemListSetupModel.enColumnLabel!;
              if (itemListSetupModel.insertType == "text") {
                return buildTextAndNumberWidget(
                    title, itemListSetupModel, widgetData, TextInputType.text);
              } else if (itemListSetupModel.insertType == "number") {
                return buildTextAndNumberWidget(title, itemListSetupModel,
                    widgetData, TextInputType.number);
              } else if (itemListSetupModel.insertType == "checkbox") {
                return buildCheckBoxWidget(
                    widgetData, title, itemListSetupModel);
              } else if (itemListSetupModel.insertType == "date") {
                return buildDateWidget(title, itemListSetupModel, widgetData);
              } else if (itemListSetupModel.insertType == "dropdown") {
                return buildDropdownWidget(
                    title, itemListSetupModel, widgetData);
              } else {
                return Text("${itemListSetupModel.insertType}");
              }
            },
          )
        ],
      ),
    );
  }

  Container buildCategoryName(
      MapEntry<String, List<Map<String, dynamic>>> entry) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
            color: AppColors.grey.withOpacity(.4),
            borderRadius: BorderRadius.circular(15)),
        child: Text(
          entry.key,
          style: AppStyles.textStyle18.copyWith(color: Colors.black),
        ));
  }

  Widget buildTextAndNumberWidget(
      String title,
      ItemListSetupModel itemListSetupModel,
      Map<String, dynamic> widgetData,
      TextInputType? keyboardType) {
    return StatefulBuilder(
      builder: (context, tNSetState) {
        return Padding(
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
                  if (itemListSetupModel.isRquired! == true)
                    const Icon(
                      Icons.star,
                      color: Colors.red,
                      size: 10,
                    )
                ],
              ),
              CustomTextFormField(
                hintText: '',
                isValidator: itemListSetupModel.isRquired!,
                keyboardType: keyboardType,
                controller: TextEditingController(text: widgetData['value']),
                onChanged: (value) {
                  tNSetState(() {
                    widgetData['value'] = value;
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildDateWidget(String title, ItemListSetupModel itemListSetupModel,
      Map<String, dynamic> widgetData) {
    String date = widgetData['value'] != ""
        ? DateFormat("yyyy-MM-dd", 'en')
            .format(DateTime.parse(widgetData['value']))
        : "";
    return Padding(
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
              if (itemListSetupModel.isRquired == true)
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
                      widgetData['value'] = dateTime.toString();
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
                      style:
                          AppStyles.textStyle14.copyWith(color: Colors.black),
                    )),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildDropdownWidget(
    String title,
    ItemListSetupModel itemListSetupModel,
    Map<String, dynamic> widgetData,
  ) {
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
      if (ii.columnName == itemListSetupModel.columnName) {
        myListDrop = ii.list;
      }
    }
    String? dropValue;
    for (var i in myListDrop!) {
      if (i.id.toString() == widgetData['value'].toString()) {
        dropValue = i.text ?? '';
        if (itemListSetupModel.columnName == "CustomerID") {
          CashierViewBody.userId = int.parse(i.id ?? "-1");
        } else if (itemListSetupModel.columnName == "CustomerID") {
          CashierViewBody.userId = int.parse(i.id ?? "-1");
        }
      }
    }
    Pages? dropPage = getDropPage(itemListSetupModel.pageId);
    return Padding(
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
              if (itemListSetupModel.isRquired == true)
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
                    bool canAdd =
                        await getPermissions(itemListSetupModel.pageId);
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
          StatefulBuilder(
            builder: (context, dropSetState) {
              return SizedBox(
                height: 40,
                child: CustomDropdown<String>.search(
                  hintText: '',
                  initialItem: dropValue,
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
                    dropSetState(() {
                      ItemDrop ii = myListDrop!
                          .firstWhere((element) => element.text == value);
                      widgetData['value'] = ii.id;
                      if (itemListSetupModel.columnName == "CustomerID") {
                        CashierViewBody.userId = int.parse(ii.id ?? "-1");
                      }
                    });
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }

  StatefulBuilder buildCheckBoxWidget(Map<String, dynamic> widgetData,
      String title, ItemListSetupModel itemListSetupModel) {
    return StatefulBuilder(
      builder: (context, csetState) {
        return CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          value: widgetData['value'],
          controlAffinity: ListTileControlAffinity.leading,
          title: Row(
            children: [
              Text(
                title,
                style: AppStyles.textStyle14.copyWith(color: Colors.black),
              ),
              if (itemListSetupModel.isRquired == true)
                const Icon(
                  Icons.star,
                  color: Colors.red,
                  size: 10,
                )
            ],
          ),
          onChanged: (newValue) {
            csetState(() {
              widgetData['value'] = newValue;
            });
          },
        );
      },
    );
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
        content: BlocProvider(
          create: (context) => AddEditCubit(getIt.get<CashierRepoImpl>()),
          child: BuildAlertAddInDropdown(
            columnList: columnList!,
            pageData: page,
            onTapBtn: (val) {
              getDropdownList(widget.pageData.pageId);
            },
          ),
        ),
      );
    } catch (e) {
      print(e);
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
      print(e);
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
      print(e);
      return false;
    }
  }

  Widget _buildPage2() {
    return Column(
      children: [
        // Text(CashierViewBody.singleObject.toString()),
        Expanded(
            child: Row(
          children: [
            Expanded(
                child: Container(
              decoration: const BoxDecoration(
                  border: BorderDirectional(
                      end: BorderSide(color: Colors.black26))),
              padding: const EdgeInsets.all(5),
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: ListView.separated(
                  itemCount: modalityList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        productList.clear();
                        setState(() {
                          modalityId = modalityList[index].modalityID!;
                          for (var i in widget.allProductList) {
                            if (i.modality == modalityId) {
                              productList.add(i);
                            }
                          }
                        });
                      },
                      child: Container(
                        width: 100,
                        height: 35,
                        padding: const EdgeInsets.all(5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: modalityId == modalityList[index].modalityID
                                ? AppColors.blueGreyDark
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black)),
                        child: Text(
                          modalityList[index].modalityName ?? "",
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: modalityId == modalityList[index].modalityID
                                ? AppColors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 5),
                ),
              ),
            )),
            Expanded(
              flex: 2,
              child: StatefulBuilder(
                builder: (context, tSetState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, right: 16, left: 16, bottom: 10),
                            child: InkWell(
                              onTap: () async {
                                final resultScanner = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const BarcodeView(),
                                    ));

                                if (!context.mounted) return;

                                getDataPro(resultScanner);

                                Map<String, dynamic> proData = {
                                  "ProductID": productId,
                                  "Qty": "1",
                                  "PriceCurrancy": "$proPrice",
                                  "systemDescription": "",
                                  "BatchNumber": "",
                                };
                                if (CashierViewBody.tableList.isEmpty) {
                                  CashierViewBody.tableList.add(proData);
                                } else {
                                  Map<String, dynamic> data =
                                      CashierViewBody.tableList.firstWhere(
                                    (element) =>
                                        element['ProductID'] ==
                                        proData['ProductID'],
                                    orElse: () => {},
                                  );
                                  if (data.isEmpty) {
                                    CashierViewBody.tableList.add(proData);
                                  } else {
                                    data['Qty'] =
                                        (int.parse(data['Qty']) + 1).toString();
                                  }
                                }
                              },
                              child: CircleAvatar(
                                  backgroundColor: AppColors.green,
                                  child: Icon(
                                    Icons.barcode_reader,
                                    color: AppColors.white,
                                  )),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, right: 16, left: 16, bottom: 10),
                            child: InkWell(
                              onTap: () {
                                showSearch(
                                  context: context,
                                  delegate: CustomSearch(
                                    productList: widget.allProductList,
                                    listColumn: widget.listColumn,
                                    onTapAdd: (data) {
                                      total = 0.0;
                                      if (CashierViewBody.tableList.isEmpty) {
                                        CashierViewBody.tableList.add(data);
                                      } else {
                                        Map<String, dynamic> itemSearch =
                                            CashierViewBody.tableList
                                                .firstWhere(
                                          (element) =>
                                              element['ProductID'] ==
                                              data['ProductID'],
                                          orElse: () => {},
                                        );
                                        if (itemSearch.isEmpty) {
                                          tSetState(() {
                                            CashierViewBody.tableList.add(data);
                                          });
                                        } else {
                                          itemSearch['Qty'] =
                                              (int.parse(data['Qty']) + 1)
                                                  .toString();
                                        }
                                      }
                                      calculateNumbers(tSetState);
                                    },
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                  backgroundColor: AppColors.blueGreyLight,
                                  child: const Icon(Icons.search)),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Center(
                            child: SingleChildScrollView(
                              child: Wrap(
                                runSpacing: 5.0,
                                spacing: 5,
                                children: productList
                                    .map(
                                      (productItem) => CustomProductItemWidget(
                                        productItem: productItem,
                                        listColumn: widget.listColumn,
                                        onTapAdd: (data) {
                                          total = 0.0;
                                          if (CashierViewBody
                                              .tableList.isEmpty) {
                                            CashierViewBody.tableList.add(data);
                                          } else {
                                            Map<String, dynamic> itemSearch =
                                                CashierViewBody.tableList
                                                    .firstWhere(
                                              (element) =>
                                                  element['ProductID'] ==
                                                  data['ProductID'],
                                              orElse: () => {},
                                            );
                                            if (itemSearch.isEmpty) {
                                              tSetState(() {
                                                CashierViewBody.tableList
                                                    .add(data);
                                              });
                                            } else {
                                              print(
                                                  "=============${itemSearch['Qty']}=========");

                                              itemSearch['Qty'] = (int.parse(
                                                          itemSearch['Qty']) +
                                                      1)
                                                  .toString();
                                              tSetState(() {});
                                            }
                                          }

                                          calculateNumbers(tSetState);
                                        },
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        )),
        Container(
          height: 86,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              border: const Border(top: BorderSide(color: Colors.black))),
          padding: const EdgeInsets.all(5),
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                runSpacing: 5.0,
                spacing: 5,
                direction: Axis.vertical,
                children: widget.allProCompanyList
                    .map(
                      (item) => InkWell(
                        onTap: () {
                          modalityList.clear();
                          productList.clear();
                          setState(() {
                            companyId = item.companyID!;
                            for (var i in widget.allModalityList) {
                              if (i.companyID == companyId) {
                                modalityList.add(i);
                              }
                            }
                            modalityId = modalityList[0].modalityID!;
                            for (var i in widget.allProductList) {
                              if (i.modality == modalityId) {
                                productList.add(i);
                              }
                            }
                          });
                        },
                        child: Container(
                          width: 100,
                          height: 35,
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: companyId == item.companyID
                                  ? AppColors.blueGreyDark
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.black)),
                          child: Text(
                            item.companyName ?? "",
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: companyId == item.companyID
                                  ? AppColors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPage3() {
    return Column(
      children: [
        Expanded(
          child: StatefulBuilder(
            builder: (context, salessetState) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      StatefulBuilder(
                        builder: (context, ssetState) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: SalesTableAddEdit(
                              onTapRow: (selectRow) {
                                setState(() {
                                  indexSelect = selectRow;
                                });
                              },
                              allProductList: widget.allProductList,
                              listColumn: widget.listColumn,
                              listHeader: widget.listHeader,
                              onTapAction: (data) {
                                total = 0.0;

                                ssetState(() {
                                  CashierViewBody.tableList = data;
                                });

                                calculateNumbers(salessetState);
                              },
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
                                  start: const BorderSide(color: Colors.grey),
                                  end: const BorderSide(color: Colors.grey),
                                  bottom: index == listHeaderSales.length - 1
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
                                                    listHeaderSales[index] ==
                                                        "الاجل على العميل" ||
                                                    listHeaderSales[index] ==
                                                        "عدد الاقساط" ||
                                                    listHeaderSales[index] ==
                                                        "تاريخ اول قسط" ||
                                                    listHeaderSales[index] ==
                                                        "شهور القسط"
                                                ? Colors.cyanAccent
                                                : null),
                                        alignment:
                                            AlignmentDirectional.centerStart,
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
                                                    listHeaderSales[index] ==
                                                        "الاجل على العميل"
                                                ? Colors.cyanAccent
                                                : null),
                                        alignment: Alignment.center,
                                        child: getWidgetSales(
                                            title: listHeaderSales[index],
                                            listSetup: widget.listSetup),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
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
            BlocConsumer<AddEditProductCubit, AddEditProductState>(
              listener: (context, state) {
                if (state is AddEditProductSuccess) {
                  _pageController.jumpToPage(0);
                  CashierViewBody.tableList = [];
                  CashierViewBody.userId = -1;
                  total = 0.0;
                  setState(() {});
                } else if (state is AddEditProductFailure) {
                  CustomAlertDialog.alertWithButton(
                      context: context,
                      type: AlertType.error,
                      title: S.of(context).error,
                      desc: state.errorMassage);
                }
              },
              builder: (context, state) {
                if (state is AddEditProductLoading) {
                  return const CustomLoadingWidget();
                } else {
                  if (isGetLocationAndListLocation == false) {
                    return CustomButton(
                      text: S.of(context).btn_add,
                      width: 80,
                      onTap: () async {
                        for (var widgetData in widgetsData) {
                          singleObject.addAll({
                            "${(widgetData['widget'] as ItemListSetupModel).columnName}":
                                "${widgetData['value']}"
                          });
                        }
                        singleObject.addAll({
                          "TotalCurrancy": total,
                          "DiscountCurrancy":
                              double.parse(discountController.text.trim()),
                          "TaxCurrancy":
                              double.parse(discountTaxController.text.trim()),
                          "AddTaxCurrancy":
                              double.parse(taxController.text.trim()),
                          "TotalOrderBeforCurrancy":
                              double.parse(totalAfterTaxController.text.trim()),
                          "POPaid": cashCollectedController.text.isNotEmpty
                              ? double.parse(
                                  cashCollectedController.text.trim())
                              : 0.0,
                          "shippingPrice":
                              shippingPriceController.text.isNotEmpty
                                  ? double.parse(
                                      shippingPriceController.text.trim())
                                  : 0.0,
                          "remind": double.parse(
                              deadlineClientController.text.trim()),
                          // "SafeAccount":double.parse(),
                          // "SuplayOrderPoPaid":double.parse(),
                          // "Voucher":double.parse(),
                          // "TaxDetailTotal":double.parse(),
                          // "DiscountDetailTotal":double.parse(),
                        });

                        bool? customerClose =
                            getCustomer(CashierViewBody.userId);

                        if (customerClose == true) {
                          checkLocation();
                        } else {
                          BlocProvider.of<AddEditProductCubit>(context).add(
                              singleObject: singleObject,
                              tableList: CashierViewBody.tableList,
                              controllerName: widget.tapData!.controllerName);
                        }
                      },
                    );
                  } else {
                    return const CustomLoadingWidget();
                  }
                }
              },
            ),
          ],
        )
      ],
    );
  }

  void calculateNumbers(StateSetter salessetState) {
    if (CashierViewBody.tableList.isNotEmpty) {
      for (var i in CashierViewBody.tableList) {
        salessetState(() {
          total = total +
              (double.parse(i['PriceCurrancy']) *
                  double.parse(i['Qty'] ?? "1"));
          // totalController.text =
          //     total.toString();

          discountController.text = discount(
                  total: total,
                  discountPercent: discountPercentController.text.isEmpty
                      ? 0
                      : double.parse(discountPercentController.text))
              .toString();
          discountTaxController.text = discountTax(
                  discountTaxPercent: discountTaxPercentController.text.isEmpty
                      ? 0
                      : double.parse(discountTaxPercentController.text),
                  total: total,
                  discountPercent: discountPercentController.text.isEmpty
                      ? 0
                      : double.parse(discountPercentController.text))
              .toString();
          taxController.text = tax(
            total: total,
            discountPercent: discountPercentController.text.isEmpty
                ? 0
                : double.parse(discountPercentController.text),
            taxPercent: taxPercentController.text.isEmpty
                ? 0
                : double.parse(taxPercentController.text),
          ).toString();

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

          deadlineClientController.text = deadlineClientValue(
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
          ).toString();
        });
      }
    } else {
      salessetState(() {
        total = 0.0;
      });
    }
  }

  void initStatePage1() {
    for (var i in widget.listSetup) {
      if (i.insertVisable == true &&
          i.cvisable == false &&
          i.visible == false &&
          i.isGeneral == true) {
        widgetsData.add({"widget": i, "value": ""});
      }
    }
    myAllDropdownModelList = CashierView.myAllDropdownModelList;
  }

  void initStatePage2() {
    companyId = widget.allProCompanyList[0].companyID!;
    for (var i in widget.allModalityList) {
      if (i.companyID == companyId) {
        modalityList.add(i);
      }
    }
    modalityId = modalityList[0].modalityID!;
    for (var i in widget.allProductList) {
      if (i.modality == modalityId) {
        productList.add(i);
      }
    }
  }

  navigationPageView() {
    // return SizedBox(
    //   height: 0,
    //   child: Row(
    //     children: [
    //       Padding(
    //         padding:
    //             const EdgeInsetsDirectional.only(bottom: 8, top: 8, start: 16),
    //         child: InkWell(
    //           onTap: _currentPage != 0 ? _previousPage : null,
    //           child: CircleAvatar(
    //             backgroundColor: _currentPage != 0
    //                 ? AppColors.blueGreyLight
    //                 : Colors.transparent,
    //             child: Icon(
    //               Icons.arrow_back,
    //               color: _currentPage != 0 ? null : Colors.transparent,
    //             ),
    //           ),
    //         ),
    //       ),
    //       const Spacer(),
    //       ...List.generate(3, (index) {
    //         return AnimatedContainer(
    //           duration: const Duration(milliseconds: 300),
    //           margin: const EdgeInsets.symmetric(horizontal: 4),
    //           width: _currentPage == index ? 10 : 6,
    //           height: _currentPage == index ? 10 : 6,
    //           decoration: BoxDecoration(
    //             color: _currentPage == index ? Colors.blue : Colors.grey,
    //             shape: BoxShape.circle,
    //           ),
    //         );
    //       }),
    //       const Spacer(),
    //       Padding(
    //         padding:
    //             const EdgeInsetsDirectional.only(bottom: 8, top: 8, end: 16),
    //         child: InkWell(
    //           onTap: _nextPage,
    //           child: CircleAvatar(
    //             backgroundColor: _currentPage != 2
    //                 ? AppColors.blueGreyLight
    //                 : Colors.transparent,
    //             child: Icon(
    //               Icons.arrow_forward,
    //               color: _currentPage != 2 ? null : Colors.transparent,
    //             ),
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(3, (index) {
          return InkWell(
            onTap: () {
              _pageController.jumpToPage(index);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
              width: _currentPage == index ? 13 : 7,
              height: _currentPage == index ? 13 : 7,
              decoration: BoxDecoration(
                color: _currentPage == index ? Colors.blue : Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
          );
        }),
      ],
    );
  }

  // void _nextPage() {
  //   if (CashierViewBody.userId != -1) {
  //     _pageController.nextPage(
  //         duration: const Duration(milliseconds: 300), curve: Curves.ease);
  //   } else {
  //     CustomAlertDialog.alertWithButton(
  //         context: context,
  //         type: AlertType.warning,
  //         title: S.of(context).warning,
  //         textButton: S.of(context).ok,
  //         desc: S.of(context).select_client,
  //         onPressed: () {
  //           Navigator.of(context).pop();
  //         });
  //   }
  // }
  //
  // void _previousPage() {
  //   _pageController.previousPage(
  //       duration: const Duration(milliseconds: 300), curve: Curves.ease);
  // }

  getWidgetSales({
    required String title,
    required List<ItemListSetupModel> listSetup,
  }) {
    switch (title) {
      case "الاجمالى":
        return Text(
          "$total",
          style: const TextStyle(color: Colors.red, fontSize: 20),
        );
      case "المحصل نقدا":
        // cashCollectedController.text =
        //     oldDataMaster['Contract']['POPaid'].toString();
        return StatefulBuilder(
          builder: (context, wsetState) => CustomTextFormField(
            controller: cashCollectedController,
            hintText: '',
            isValidator: false,
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
              deadlineClientController.text = deadlineClientValue(
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
              ).toString();
              // singleObject['Contract'].updateAll((key, value) => key == "POPaid"
              //     ? double.parse(cashCollectedController.text)
              //     : value);

              wsetState(() {});
            },
          ),
        );
      case "عدد الاقساط":
        numberOfInstallmentsController.text = "";
        return CustomTextFormField(
          controller: numberOfInstallmentsController,
          hintText: '',
          isValidator: false,
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
                ),
              ),
            );
          },
        );
      case "شهور القسط":
        installmentMonthsController.text = "";
        return CustomTextFormField(
          controller: installmentMonthsController,
          hintText: '',
          isValidator: false,
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
      case "ضريبة خصم منبع":
        // discountTaxController.text =
        //     oldDataMaster['Contract']['TaxCurrancy'].toString() ?? "";
        // discountTaxPercentController.text = oldDataMaster['Contract']
        //             ['TaxCurrancy'] !=
        //         null
        //     ? discountTaxPercent(
        //             totalAfterDiscount: totalAfterDiscount(
        //                 total:
        //                     oldDataMaster['Contract']['TotalCurrancy'] ?? 0.0,
        //                 discountPercent: oldDataMaster['Contract']
        //                             ['DiscountCurrancy'] !=
        //                         null
        //                     ? discountPercent(
        //                         total: oldDataMaster['Contract']
        //                                 ['TotalCurrancy'] ??
        //                             0.0,
        //                         discount: oldDataMaster['Contract']
        //                                 ['DiscountCurrancy'] ??
        //                             0.0)
        //                     : 0.0),
        //             discountTax: discountTaxController.text.isEmpty
        //                 ? 0.0
        //                 : double.parse(discountTaxController.text))
        //         .toString()
        //     : "";
        return StatefulBuilder(
          builder: (context, wsetState) => Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  controller: discountTaxPercentController,
                  hintText: '',
                  isValidator: false,
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

                    deadlineClientController.text = deadlineClientValue(
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
                    ).toString();
                    // singleObject['Contract'].updateAll((key, value) => key ==
                    //         "TaxCurrancy"
                    //     ? discountTax(
                    //         discountTaxPercent:
                    //             newValue.isEmpty ? 0 : double.parse(newValue),
                    //         total: total,
                    //         discountPercent: discountPercentController
                    //                 .text.isEmpty
                    //             ? 0
                    //             : double.parse(discountPercentController.text))
                    //     : value);

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
                  controller: discountTaxController,
                  hintText: '',
                  isValidator: false,
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

                    deadlineClientController.text = deadlineClientValue(
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
                    ).toString();
                    // singleObject['Contract'].updateAll((key, value) =>
                    //     key == "TaxCurrancy"
                    //         ? double.parse(discountTaxController.text)
                    //         : value);

                    wsetState(() {});
                  },
                ),
              ),
            ],
          ),
        );
      case "خصم اجنبي":
        // discountController.text =
        //     oldDataMaster['Contract']['DiscountCurrancy'].toString() ?? "";
        // discountPercentController.text = oldDataMaster['Contract']
        //             ['DiscountCurrancy'] !=
        //         null
        //     ? discountPercent(
        //             total: oldDataMaster['Contract']['TotalCurrancy'] ?? 0.0,
        //             discount:
        //                 oldDataMaster['Contract']['DiscountCurrancy'] ?? 0.0)
        //         .toString()
        //     : "";
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

                    deadlineClientController.text = deadlineClientValue(
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
                    ).toString();
                    // singleObject['Contract'].updateAll((key, value) => key ==
                    //         "DiscountCurrancy"
                    //     ? discount(
                    //         total: total,
                    //         discountPercent:
                    //             newValue.isEmpty ? 0 : double.parse(newValue))
                    //     : value);
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
                  controller: discountController,
                  hintText: '',
                  isValidator: false,
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

                    deadlineClientController.text = deadlineClientValue(
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
                    ).toString();
                    // singleObject['Contract'].updateAll((key, value) =>
                    //     key == "DiscountCurrancy"
                    //         ? double.parse(discountController.text)
                    //         : value);
                    wsetState(() {});
                  },
                ),
              ),
            ],
          ),
        );
      case "ضريبة القيمة المضافة":
        // taxController.text = oldDataMaster['Contract']['AddTaxCurrancy'] != null
        //     ? oldDataMaster['Contract']['AddTaxCurrancy'].toString()
        //     : "";
        // taxPercentController.text = oldDataMaster['Contract']
        //             ['AddTaxCurrancy'] !=
        //         null
        //     ? taxPercent(
        //             total: oldDataMaster['Contract']['TotalCurrancy'] ?? 0.0,
        //             tax: oldDataMaster['Contract']['AddTaxCurrancy'] ?? 0.0)
        //         .toString()
        //     : "";
        return StatefulBuilder(
          builder: (context, wsetState) => Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  controller: taxPercentController,
                  hintText: '',
                  isValidator: false,
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

                    deadlineClientController.text = deadlineClientValue(
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
                    ).toString();
                    // singleObject['Contract'].updateAll((key, value) => key ==
                    //         "AddTaxCurrancy"
                    //     ? tax(
                    //         taxPercent:
                    //             newValue.isEmpty ? 0 : double.parse(newValue),
                    //         total: total,
                    //         discountPercent: discountPercentController
                    //                 .text.isEmpty
                    //             ? 0
                    //             : double.parse(discountPercentController.text))
                    //     : value);
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
                    taxPercentController.text = taxPercent(
                      total: total,
                      tax: tax(
                        total: total,
                        discountPercent: discountPercentController.text.isEmpty
                            ? 0
                            : double.parse(discountPercentController.text),
                        taxPercent:
                            newValue.isEmpty ? 0 : double.parse(newValue),
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

                    deadlineClientController.text = deadlineClientValue(
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
                    ).toString();
                    // singleObject['Contract'].updateAll((key, value) =>
                    //     key == "AddTaxCurrancy"
                    //         ? double.parse(taxController.text)
                    //         : value);
                    wsetState(() {});
                  },
                ),
              ),
            ],
          ),
        );
      case "اجمالي بعد الضرائب":
        // totalAfterTaxController.text = oldDataMaster['Contract']
        //             ['TotalOrderBeforCurrancy'] !=
        //         null
        //     ? oldDataMaster['Contract']['TotalOrderBeforCurrancy'].toString()
        //     : "";
        return CustomTextFormField(
          controller: totalAfterTaxController,
          hintText: '',
          isValidator: false,
          keyboardType: TextInputType.number,
          readOnly: true,
          filled: true,
          fillColor: Colors.grey.shade300,
        );
      case "مصاريف الشحن":
        // shippingPriceController.text =
        //     oldDataMaster['Contract']['shippingPrice'].toString();
        return StatefulBuilder(
          builder: (context, wsetState) => CustomTextFormField(
            controller: shippingPriceController,
            hintText: '',
            isValidator: false,
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

              deadlineClientController.text = deadlineClientValue(
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
              ).toString();
              // singleObject['Contract'].updateAll((key, value) =>
              //     key == "shippingPrice" ? double.parse(newValue) : value);
              wsetState(() {});
            },
          ),
        );
      case "الاجل على العميل":
        // deadlineClientController.text =
        //     oldDataMaster['Contract']['remind'] != null
        //         ? oldDataMaster['Contract']['remind'].toString()
        //         : "0.0";
        return CustomTextFormField(
          controller: deadlineClientController,
          hintText: '',
          isBorder: false,
          readOnly: true,
          isValidator: false,
          keyboardType: TextInputType.number,
          textStyle: const TextStyle(color: Colors.red, fontSize: 20),
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
      Map<String, dynamic> dataCustomerAccount = await ApiService(Dio()).post(
        endPoint: "web/Structure/getDataGlobal",
        data: {"TableName": "CustomerAccount"},
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
      CashierViewBody.listProduct = dataProduct['dynamicList'];
      CashierViewBody.listProductPrices = dataProductPrices['dynamicList'];
      CashierViewBody.listCustomerAccount = dataCustomerAccount['dynamicList'];
      CashierViewBody.listBarcodeData = barcodeData['dynamicList'];
    } catch (e) {
      print(e);
    }
  }

  void getDataPro(String resultScanner) {
    productId = CashierViewBody.listBarcodeData.firstWhere(
      (element) => element['BarcodeProc'] == resultScanner /*"11961"*/,
      orElse: () => {"ProductId": -1},
    )['ProductId'];

    customerCategoryID = CashierViewBody.listCustomerAccount.firstWhere(
        (element) =>
            element['CustomerAccountID'] ==
            CashierViewBody.userId)['CategoryID'];

    double productPrice = CashierViewBody.listProductPrices.firstWhere(
          (element) =>
              element['ProductID'] == productId &&
              element['CustomerCategoryID'] == customerCategoryID,
          orElse: () => {},
        )['Price'] ??
        0.0;
    if (productPrice != 0.0) {
      proPrice = productPrice;
      proName = CashierViewBody.listProduct.firstWhere(
            (element) => element["ProID"] == productId,
            orElse: () => {},
          )['ProName'] ??
          "";
    } else {
      double price = CashierViewBody.listProduct.firstWhere(
            (element) => element["ProID"] == productId,
            orElse: () => {},
          )['ProPrice'] ??
          -1;
      if (price != -1) {
        proPrice = price;
        proName = CashierViewBody.listProduct.firstWhere(
              (element) => element["ProID"] == productId,
              orElse: () => {},
            )['ProName'] ??
            "";
      }
    }
  }

  bool? getCustomer(int userId) {
    for (var item in CashierViewBody.listCustomerAccount) {
      if (item['CustomerAccountID'] == userId) {
        return item['Closelocation'];
      }
    }
    return null;
  }

  void checkLocation() async {
    await getLocation();
    await getCustomerLocation(CashierViewBody.userId);
    double distance;
    for (var location in CashierViewBody.listCustomerAccountLocation) {
      distance = (Geolocator.distanceBetween(
            lat ?? 0.0,
            long ?? 0.0,
            location['LocationLat'],
            location['LocationLong'],
          )) /
          1000;
      // radius.add(distance);
      if (distance == location['Radius'] ||
          distance < location['Radius'] ||
          distance == 0.0) {
        BlocProvider.of<AddEditProductCubit>(context).add(
            singleObject: singleObject,
            tableList: CashierViewBody.tableList,
            controllerName: widget.tapData!.controllerName);
      } else {
        CustomAlertDialog.alertWithButton(
            context: context,
            type: AlertType.error,
            isCloseButton: false,
            isOverlayTapDismiss: false,
            title: S.of(context).error,
            desc: S.of(context).no_location,
            onPressed: () {
              Navigator.of(context).pop();
            });
      }
    }
  }

  Future<void> getCustomerLocation(int userId) async {
    setState(() {
      isGetLocationAndListLocation = true;
    });
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ??
              "";
      String token =
          await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      Map<String, dynamic> customerAccountLocation =
          await ApiService(Dio()).post(
        endPoint: "web/Structure/getDataGlobal",
        data: {
          "TableName": "CustomerAccountLocation",
          "TailCondition": "CustomerID= $userId"
        },
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      CashierViewBody.listCustomerAccountLocation =
          customerAccountLocation['dynamicList'];
      setState(() {
        isGetLocationAndListLocation = false;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> getLocation() async {
    setState(() {
      isGetLocationAndListLocation = true;
    });
    Location location = Location();

    var serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    var permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    var locationData = await location.getLocation();
    setState(() {
      lat = locationData.latitude;
      long = locationData.longitude;
      isGetLocationAndListLocation = false;
    });
  }
}
