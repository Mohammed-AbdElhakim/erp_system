import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../core/helper/AlertDialog/custom_alert_dialog.dart';
import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/custom_error_massage.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/widgets/home_view_body.dart';
import '../../../productCard/presentation/widgets/pagination_widget.dart';
import '../../data/models/all_dropdown_model.dart';
import '../../data/models/permission_model.dart';
import '../../data/models/screen_model.dart';
import '../../data/models/store_show_model.dart';
import '../../data/repositories/store_show_repo_impl.dart';
import '../manager/addEdit/add_edit_cubit.dart';
import '../manager/storeShow/store_show_cubit.dart';
import '../views/store_show_view.dart';
import 'build_alert_add_in_dropdown.dart';
import 'custom_table_store_show.dart';

class StoreShowViewBody extends StatefulWidget {
  const StoreShowViewBody(
      {super.key,
      required this.listColumn,
      required this.pageData,
      required this.listColumnInTable});

  final List<ColumnList> listColumn;
  final List<ColumnList> listColumnInTable;
  final Pages pageData;

  @override
  State<StoreShowViewBody> createState() => _StoreShowViewBodyState();
}

class _StoreShowViewBodyState extends State<StoreShowViewBody> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<Map<String, dynamic>> widgetsData = [];
  late List<AllDropdownModel> myAllDropdownModelList;

  String? lang;
  Map<String, dynamic> myData = {};
  ScrollController verticalScrollController = ScrollController();
  ScrollController horizontalScrollController = ScrollController();

  final DataGridController dataGridController = DataGridController();
  late TableDataSource tableDataSource;

  late int allPages;
  List<int> listNumberItemInList = [10, 25, 50, 100];
  late int numberPage;
  late int dropdownValue;
  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    initStatePage1();
    initStatePage2();
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
            },
            children: [
              _buildPage1(),
              _buildPage2(),
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
    super.dispose();
  }

  navigationPageView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(2, (index) {
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

  void initStatePage1() {
    for (var i in widget.listColumn) {
      if (i.insertType == "checkbox") {
        widgetsData.add({"widget": i, "value": false});
      } else if (i.insertType == "dropdown") {
        if (i.isMulti == true) {
          widgetsData.add({"widget": i, "value": []});
        } else {
          widgetsData.add({"widget": i, "value": ""});
        }
      } else {
        widgetsData.add({"widget": i, "value": ""});
      }
    }
    myAllDropdownModelList = StoreShowView.myAllDropdownModelList;
  }

  void initStatePage2() {
    numberPage = 1;
    dropdownValue = listNumberItemInList[0];
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
              ColumnList itemColumnList = widgetData['widget'];
              String title = lang == AppStrings.arLangKey
                  ? itemColumnList.arColumnLabel!
                  : itemColumnList.enColumnLabel!;
              if (itemColumnList.insertType == "text") {
                return buildTextAndNumberWidget(
                    title, itemColumnList, widgetData, TextInputType.text);
              } else if (itemColumnList.insertType == "number") {
                return buildTextAndNumberWidget(
                    title, itemColumnList, widgetData, TextInputType.number);
              } else if (itemColumnList.insertType == "checkbox") {
                return buildCheckBoxWidget(widgetData, title, itemColumnList);
              } else if (itemColumnList.insertType == "date") {
                return buildDateWidget(title, itemColumnList, widgetData);
              } else if (itemColumnList.insertType == "dropdown") {
                return buildDropdownWidget(title, itemColumnList, widgetData);
              } else {
                return Text("${itemColumnList.insertType}");
              }
            },
          )
        ],
      ),
    );
  }

  Widget buildTextAndNumberWidget(String title, ColumnList itemColumnList,
      Map<String, dynamic> widgetData, TextInputType? keyboardType) {
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
                  if (itemColumnList.isRquired! == true)
                    const Icon(
                      Icons.star,
                      color: Colors.red,
                      size: 10,
                    )
                ],
              ),
              CustomTextFormField(
                hintText: '',
                isValidator: itemColumnList.isRquired!,
                keyboardType: keyboardType,
                controller: TextEditingController(text: widgetData['value']),
                onChanged: (value) {
                  tNSetState(() {
                    widgetData['value'] = "";
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

  Widget buildDateWidget(String title, ColumnList itemColumnList,
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
              if (itemColumnList.isRquired == true)
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
                      widgetData['value'] = "";
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
    ColumnList itemColumnList,
    Map<String, dynamic> widgetData,
  ) {
    List<ListDrop>? listDrop = [];
    List<ItemDrop>? myListDrop = [];

    for (var ii in myAllDropdownModelList) {
      if (ii.listName == widget.pageData.listName) {
        listDrop = ii.list;
      }
    }
    for (var ii in listDrop!) {
      if (ii.columnName == itemColumnList.columnName) {
        myListDrop = ii.list;
      }
    }
    String? dropValue;
    List<String> dropValueList = [];
    if (itemColumnList.isMulti == true) {
      for (var st in widgetData['value']) {
        for (var i in myListDrop!) {
          if (i.id.toString() == st) {
            dropValueList.add(i.text ?? '');
          }
        }
      }
    } else {
      for (var i in myListDrop!) {
        if (i.id.toString() == widgetData['value'].toString()) {
          dropValue = i.text ?? '';
        }
      }
    }

    Pages? dropPage = getDropPage(itemColumnList.pageId);
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
              if (itemColumnList.isRquired == true)
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
                    bool canAdd = await getPermissions(itemColumnList.pageId);
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
                child: itemColumnList.isMulti == false
                    ? CustomDropdown<String>.search(
                        hintText: '',
                        initialItem: dropValue,
                        validator: itemColumnList.isRquired!
                            ? (value) {
                                if (value?.isEmpty ?? true) {
                                  return S.of(context).field_is_required;
                                } else {
                                  return null;
                                }
                              }
                            : null,
                        closedHeaderPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 8),
                        decoration: CustomDropdownDecoration(
                          headerStyle: AppStyles.textStyle16
                              .copyWith(color: Colors.black),
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
                            widgetData['value'] = "";
                            widgetData['value'] = ii.id;
                          });
                        },
                      )
                    : CustomDropdown<String>.multiSelectSearch(
                        hintText: '',
                        initialItems: dropValueList,
                        listValidator: itemColumnList.isRquired!
                            ? (value) {
                                if (value.isEmpty) {
                                  return S.of(context).field_is_required;
                                } else {
                                  return null;
                                }
                              }
                            : null,
                        onListChanged: (valueList) {
                          dropSetState(() {
                            widgetData['value'] = [];
                            for (String i in valueList) {
                              for (ItemDrop ii in myListDrop!) {
                                if (ii.text == i) {
                                  widgetData['value'].add(ii.id);
                                }
                              }
                            }
                          });
                        },
                        // initialItem: dropValue,
                        closedHeaderPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 8),
                        decoration: CustomDropdownDecoration(
                          headerStyle: AppStyles.textStyle16
                              .copyWith(color: Colors.black),
                          closedFillColor: Colors.transparent,
                          closedBorder: Border.all(color: AppColors.blueDark),
                        ),
                        items: myListDrop!.isEmpty
                            ? [""]
                            : List.generate(myListDrop.length,
                                (index) => myListDrop![index].text ?? ''),
                      ),
              );
            },
          )
        ],
      ),
    );
  }

  StatefulBuilder buildCheckBoxWidget(Map<String, dynamic> widgetData,
      String title, ColumnList itemColumnList) {
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
              if (itemColumnList.isRquired == true)
                const Icon(
                  Icons.star,
                  color: Colors.red,
                  size: 10,
                )
            ],
          ),
          onChanged: (newValue) {
            csetState(() {
              widgetData['value'] = false;
              widgetData['value'] = newValue;
            });
          },
        );
      },
    );
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
          create: (context) => AddEditCubit(getIt.get<StoreShowRepoImpl>()),
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
      debugPrint(e.toString());
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

  Container buildCategoryName(
      MapEntry<String, List<Map<String, dynamic>>> entry) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
            // color: AppColors.grey.withOpacity(.4),
            color: AppColors.grey.withAlpha(102),
            borderRadius: BorderRadius.circular(15)),
        child: Text(
          entry.key,
          style: AppStyles.textStyle18.copyWith(color: Colors.black),
        ));
  }

  _buildPage1() {
    GlobalKey<FormState> formKey = GlobalKey();
    //تقسيم ال list  الى مجموعات
    final Map<String, List<Map<String, dynamic>>> groupData = {};
    for (var item in widgetsData) {
      if (!groupData.containsKey((item['widget'] as ColumnList).categoryName)) {
        groupData[(item['widget'] as ColumnList).categoryName!] = [];
      }
      groupData[(item['widget'] as ColumnList).categoryName]!.add(item);
    }
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Scaffold(
        body: ListView(
          children: [
            ...groupData.entries.map((entry) {
              return Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildCategoryName(entry),
                    buildCategoryChildren(entry),
                  ],
                ),
              );
            }).toList(),
            const SizedBox(height: 80),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.blueLight,
          shape: const StadiumBorder(),
          child: Icon(
            Icons.search,
            color: AppColors.white,
          ),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              numberPage = 1;
              dropdownValue = listNumberItemInList[0];
              createMyData();
              _pageController.jumpToPage(2);
            }
          },
        ),
      ),
    );
  }

  _buildPage2() {
    return myData.isNotEmpty
        ? BlocProvider(
            create: (context) => StoreShowCubit(getIt.get<StoreShowRepoImpl>())
              ..getTableStoreShow(
                objectData: myData,
                numberOfPage: numberPage,
                dropdownValueOfLimit: dropdownValue,
              ),
            child: BlocBuilder<StoreShowCubit, StoreShowState>(
              builder: (context, state) {
                if (state is StoreShowSuccess) {
                  int? numberOfRecords = state.storeShowModel.numberofrecords;
                  List<StoreShowItem>? listData =
                      state.storeShowModel.dynamicList;

                  numberPage = state.numberPage;
                  dropdownValue = state.dropdownValue;
                  allPages = (numberOfRecords! % dropdownValue) == 0
                      ? (numberOfRecords ~/ dropdownValue)
                      : (numberOfRecords ~/ dropdownValue) + 1;
                  return CustomTableStoreShow(
                    pageData: widget.pageData,
                    listData: listData!,
                    listColumn: widget.listColumnInTable,
                    allDropdownModelList: StoreShowView.myAllDropdownModelList,
                    paginationWidget: PaginationWidget(
                      allPages: allPages,
                      dropdownValue: dropdownValue,
                      listNumberItemInList: listNumberItemInList,
                      myPage: numberPage,
                      numberOfRecords: numberOfRecords,
                      onChangeLimit: (limit) {
                        setState(() {
                          dropdownValue = limit;
                          numberPage = 1;
                          allPages = (numberOfRecords % dropdownValue) == 0
                              ? (numberOfRecords ~/ dropdownValue)
                              : (numberOfRecords ~/ dropdownValue) + 1;
                        });
                        createMyData();
                        BlocProvider.of<StoreShowCubit>(context)
                            .getTableStoreShow(
                          objectData: myData,
                          numberOfPage: numberPage,
                          dropdownValueOfLimit: dropdownValue,
                        );
                      },
                      onTapMin: () {
                        setState(() {
                          numberPage--;
                        });
                        createMyData();
                        BlocProvider.of<StoreShowCubit>(context)
                            .getTableStoreShow(
                          objectData: myData,
                          numberOfPage: numberPage,
                          dropdownValueOfLimit: dropdownValue,
                        );
                      },
                      onTapAdd: () {
                        setState(() {
                          numberPage++;
                        });
                        createMyData();
                        BlocProvider.of<StoreShowCubit>(context)
                            .getTableStoreShow(
                          objectData: myData,
                          numberOfPage: numberPage,
                          dropdownValueOfLimit: dropdownValue,
                        );
                      },
                    ),
                  );
                } else if (state is StoreShowFailure) {
                  return CustomErrorMassage(errorMassage: state.errorMassage);
                } else {
                  return const CustomLoadingWidget();
                }
              },
            ),
          )
        : const SizedBox();
  }

  void createMyData() {
    Map<String, dynamic> params = {};
    myData = {};
    myData.addAll({
      "pageId": widget.pageData.pageId,
      "arrayToSum": null,
      "authorizationID": widget.pageData.authorizationID,
      "company": true,
      "companyname": "ComID",
      "employee": false,
      "isCashed": false,
      "isDepartment": widget.pageData.isDepartment,
      "IsDesc": widget.pageData.isDesc,
      "limit": dropdownValue,
      "offset": (numberPage * dropdownValue) - dropdownValue,
      "listName": widget.pageData.listName,
      "orderby": widget.pageData.orderBy,
      "selectFromCash": true,
      "statment": "",
      //التاريخ متكرر مرتين فهنا انا عمله على انه يجب اخر واحد
      "tableName":
          "GetCurrentInventoryDateTo('${DateFormat("MM-d-yyyy", 'en').format(DateTime.parse(widgetsData.where(
                (element) =>
                    (element['widget'] as ColumnList).columnName == "dateto",
              ).last['value']))}')",
      "ViewEmployeeColumn": widget.pageData.viewEmployeeColumn,
      "DepartmentName": widget.pageData.departmentName,
    });
    for (var i in widgetsData) {
      params["${(i['widget'] as ColumnList).columnName}"] = i['value'];
    }
    myData["Params"] = params;
  }
}
