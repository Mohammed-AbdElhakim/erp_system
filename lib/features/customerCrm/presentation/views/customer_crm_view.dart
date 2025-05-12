import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:erp_system/features/customerCrm/data/models/tabs_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/manager/listSetup/list_setup_cubit.dart';
import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/repositories/general/general_repo_impl.dart';
import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/methods.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/change_status_bar_color.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_error_massage.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../data/models/all_dropdown_model.dart';
import '../../data/models/screen_model.dart';
import '../../data/repositories/customer_crm_repo_impl.dart';
import '../manager/getAllDropdownList/get_all_dropdown_list_cubit.dart';
import '../widgets/customer_crm_view_body.dart';

class CustomerCrmView extends StatefulWidget {
  const CustomerCrmView({super.key, required this.pageData});

  final Pages pageData;
  static List<AllDropdownModel> myAllDropdownModelList = [];

  @override
  State<CustomerCrmView> createState() => _CustomerCrmViewState();
}

class _CustomerCrmViewState extends State<CustomerCrmView> {
  String? lang;
  List<PageDetail> listTabs = [];

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeStatusBarColor(
      child: Scaffold(
        appBar: CustomAppBar(
          isPortrait: isOrientationPortrait(context),
          isTitleInPortrait: true,
          title: lang == AppStrings.enLangKey ? widget.pageData.nameEn : widget.pageData.nameAr,
        ),
        body: BlocProvider(
          create: (context) =>
              GetAllDropdownListCubit(getIt.get<CustomerCrmRepoImpl>())..getAllDropdownList(pageId: widget.pageData.pageId),
          child: BlocBuilder<GetAllDropdownListCubit, GetAllDropdownListState>(
            builder: (context, state) {
              if (state is GetAllDropdownListSuccess) {
                List<AllDropdownModel> allDropdownModelList = state.allDropdownModelList;
                CustomerCrmView.myAllDropdownModelList = allDropdownModelList;
                return BlocProvider(
                  create: (context) => ListSetupCubit(getIt.get<GeneralRepoImpl>())
                    ..getListSetup(
                      listName: "CustomerActions",
                      link: "Structure",
                    ),
                  child: BlocBuilder<ListSetupCubit, ListSetupState>(
                    builder: (context, state) {
                      if (state is ListSetupSuccess) {
                        List<ColumnList> listColumn = [];

                        for (var item in state.data) {
                          if (item['InsertVisable'] == true) {
                            listColumn.add(ColumnList.fromJson(item));
                          }
                        }

                        return CustomerCrmViewBody(
                          listColumn: listColumn,
                          listTabs: listTabs,
                          pageData: widget.pageData,
                        );
                      } else if (state is ListSetupFailure) {
                        return CustomErrorMassage(errorMassage: state.errorMassage);
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

  void fetchData() async {
    try {
      String companyKey = await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";

      Map<String, dynamic> data = await ApiService(Dio()).get(
        endPoint: "web/Structure/getPageAttribute/${widget.pageData.pageId}",
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      setState(() {
        listTabs = TabsModel.fromJson(data).pageDetail!;
      });
    } catch (e) {
      log('Error fetching data: $e');
    }
  }
}
