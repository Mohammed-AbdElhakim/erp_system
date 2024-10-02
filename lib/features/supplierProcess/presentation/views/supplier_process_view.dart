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
import '../../data/repositories/supplier_process_repo_impl.dart';
import '../manager/getAllDropdownList/get_all_dropdown_list_cubit.dart';
import '../manager/getTable/get_table_cubit.dart';
import '../widgets/supplier_process_view_body.dart';

class SupplierProcessView extends StatefulWidget {
  const SupplierProcessView({super.key, required this.pageData});

  final Pages pageData;
  static List<AllDropdownModel> myAllDropdownModelList = [];

  @override
  State<SupplierProcessView> createState() => _SupplierProcessViewState();
}

class _SupplierProcessViewState extends State<SupplierProcessView> {
  String? lang;

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
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
              GetAllDropdownListCubit(getIt.get<SupplierProcessRepoImpl>())
                ..getAllDropdownList(pageId: widget.pageData.pageId),
          child: BlocBuilder<GetAllDropdownListCubit, GetAllDropdownListState>(
            builder: (context, state) {
              if (state is GetAllDropdownListSuccess) {
                List<AllDropdownModel> allDropdownModelList =
                    state.allDropdownModelList;
                SupplierProcessView.myAllDropdownModelList =
                    allDropdownModelList;
                return BlocProvider(
                  create: (context) =>
                      GetTableCubit(getIt.get<SupplierProcessRepoImpl>())
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
                          viewEmployeeColumn:
                              widget.pageData.viewEmployeeColumn,
                          dropdownValueOfLimit: 10,
                          numberOfPage: 1,
                        ),
                  child: BlocBuilder<GetTableCubit, GetTableState>(
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

                        return SupplierProcessViewBody(
                          listColumn: listColumn,
                          listColumnInTable: listColumnInTable,
                          pageData: widget.pageData,
                        );
                      } else if (state is GetTableFailure) {
                        return CustomErrorMassage(
                            errorMassage: state.errorMassage);
                      } else {
                        return const CustomLoadingWidget();
                      }
                    },
                  ),
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
}
