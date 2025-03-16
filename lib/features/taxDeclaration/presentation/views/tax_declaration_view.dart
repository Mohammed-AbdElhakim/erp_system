import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/methods.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/change_status_bar_color.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_error_massage.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../data/models/all_dropdown_model.dart';
import '../../data/models/screen_model.dart';
import '../../data/repositories/tax_declaration_repo_impl.dart';
import '../manager/getAllDropdownList/get_all_dropdown_list_cubit.dart';
import '../manager/getTable/get_table_cubit.dart';
import '../widgets/tax_declaration_view_body.dart';

class TaxDeclarationView extends StatefulWidget {
  const TaxDeclarationView({super.key, required this.pageData});

  final Pages pageData;
  static List<AllDropdownModel> myAllDropdownModelList = [];

  @override
  State<TaxDeclarationView> createState() => _TaxDeclarationViewState();
}

class _TaxDeclarationViewState extends State<TaxDeclarationView> {
  String? lang;
  List<ColumnList> listColumn = [];
  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    getListColumn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeStatusBarColor(
      child: Scaffold(
        appBar: CustomAppBar(
          isPortrait: isOrientationPortrait(context),
          isTitleInPortrait: true,
          title: lang == AppStrings.enLangKey
              ? widget.pageData.nameEn
              : widget.pageData.nameAr,
        ),
        body: BlocProvider(
          create: (context) =>
              GetAllDropdownListCubit(getIt.get<TaxDeclarationRepoImpl>())
                ..getAllDropdownList(pageId: widget.pageData.pageId),
          child: BlocBuilder<GetAllDropdownListCubit, GetAllDropdownListState>(
            builder: (context, state) {
              if (state is GetAllDropdownListSuccess) {
                List<AllDropdownModel> allDropdownModelList = state.allDropdownModelList;
                TaxDeclarationView.myAllDropdownModelList = allDropdownModelList;
                return BlocProvider(
                  create: (context) => GetTableCubit(getIt.get<TaxDeclarationRepoImpl>())
                    ..getTable(
                      pageId: widget.pageData.pageId,
                      employee: false,
                      isdesc: widget.pageData.isDesc,
                      limit: 10,
                      offset: 0,
                      orderby: widget.pageData.orderBy,
                      statment: "",
                      selectcolumns: '',
                      departmentName: widget.pageData.departmentName,
                      isDepartment: widget.pageData.isDepartment,
                      authorizationID: widget.pageData.authorizationID,
                      viewEmployeeColumn: widget.pageData.viewEmployeeColumn,
                      dropdownValueOfLimit: 10,
                      numberOfPage: 1,
                    ),
                  child: TaxDeclarationViewBody(
                    listColumn: listColumn,
                    // listColumnInTable: listColumnInTable,
                    pageData: widget.pageData,
                  ),
                  /*child: BlocBuilder<GetTableCubit, GetTableState>(
                    builder: (context, state) {
                      if (state is GetTableSuccess) {
                        List<ColumnList> listColumn = [];
                        List<ColumnList> listColumnInTable = [];
                        for (var item in state.screenModel.columnList!) {
                          if (item.insertVisable == true) {
                            listColumn.add(item);
                          }
                          if (item.visible == true) {
                            listColumnInTable.add(item);
                          }
                        }

                        return TaxDeclarationViewBody(
                          listColumn: listColumn,
                          // listColumnInTable: listColumnInTable,
                          pageData: widget.pageData,
                        );
                      } else if (state is GetTableFailure) {
                        return CustomErrorMassage(errorMassage: state.errorMassage);
                      } else {
                        return const CustomLoadingWidget();
                      }
                    },
                  ),*/
                );
              } else if (state is GetAllDropdownListFailure) {
                return CustomErrorMassage(errorMassage: state.errorMassage);
              } else {
                return const CustomLoadingWidget();
              }
            },
          ),
        ),
      ),
    );
  }

  void getListColumn() {
    List<Map<String, dynamic>> dataMap = [
      {
        "id": 947395,
        "ListName": "TaxDeclaration",
        "ColumnName": "datefrom",
        "enColumnLabel": " From date ",
        "arColumnLabel": "من تاريخ",
        "InsertVisable": true,
        "InsertType": "date",
        "userID": 4121,
        "ListID": 40060,
        "sort": 1,
        "visible": false,
        "Cvisable": false,
        "validation": "required",
        "isKey": false,
        "IsRquired": false,
        "SearchName": "datefrom",
        "InsertDefult": true,
        "VisableDefult": true,
        "Width": 140,
        "CategoryTitle": "بيانات اساسية",
        "CategorySort": 1,
        "CategoryID": 10,
        "IsExcel": false,
        "MobileVisable": true,
        "ComID": 1,
        "MasterInsertVisible": true,
        "CategoryName": "بيانات اساسية"
      },
      {
        "id": 947393,
        "ListName": "TaxDeclaration",
        "ColumnName": "Accountid",
        "enColumnLabel": "Accountid",
        "arColumnLabel": "الحساب",
        "InsertVisable": true,
        "InsertType": "dropdown",
        "userID": 4121,
        "ListID": 40058,
        "sort": 2,
        "visible": false,
        "DroModel": "AccountView",
        "DroValue": "AcID",
        "DroText": "AcName",
        "Cvisable": false,
        "validation": "required",
        "isKey": false,
        "IsRquired": false,
        "SearchName": "Accountid",
        "InsertDefult": true,
        "VisableDefult": true,
        "Width": 140,
        "CategoryTitle": "اختيارات متعددة",
        "CategorySort": 2,
        "CategoryID": 11,
        "IsExcel": false,
        "MobileVisable": true,
        "ComID": 1,
        "MasterInsertVisible": true,
        "CategoryName": "اختيارات متعددة",
        "IsMulti": false
      },
      {
        "id": 947394,
        "ListName": "TaxDeclaration",
        "ColumnName": "dateto",
        "enColumnLabel": " To date ",
        "arColumnLabel": "إلى تاريخ",
        "InsertVisable": true,
        "InsertType": "date",
        "userID": 4121,
        "ListID": 40059,
        "sort": 3,
        "visible": false,
        "Cvisable": false,
        "validation": "required",
        "isKey": false,
        "IsRquired": false,
        "SearchName": "datefrom",
        "InsertDefult": true,
        "VisableDefult": true,
        "Width": 140,
        "CategoryTitle": "بيانات اساسية",
        "CategorySort": 1,
        "CategoryID": 10,
        "IsExcel": false,
        "MobileVisable": true,
        "ComID": 1,
        "MasterInsertVisible": true,
        "CategoryName": "بيانات اساسية"
      }
    ];
    for (var i in dataMap) {
      ColumnList columnListItem = ColumnList.fromJson(i);
      listColumn.add(columnListItem);
    }
  }
}
