import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/methods.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/change_status_bar_color.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_error_massage.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../data/models/header_account_tree_model.dart';
import '../../data/models/all_dropdown_model.dart';
import '../../data/repositories/account_tree_repo_impl.dart';
import '../manager/addEditNode/add_edit_node_cubit.dart';
import '../manager/getAccountTree/get_account_tree_cubit.dart';
import '../widgets/accounting_tree_view_body.dart';

class AccountingTreeView extends StatefulWidget {
  const AccountingTreeView({super.key, required this.pageData});

  final Pages pageData;
  static List<AllDropdownModel> dataListDropdown = [];
  static List<HeaderAccountTreeModel> dataListHeader = [];
  static late int pageId;

  @override
  State<AccountingTreeView> createState() => _AccountingTreeViewState();
}

class _AccountingTreeViewState extends State<AccountingTreeView> {
  String? lang;

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    fetchData();
    AccountingTreeView.pageId = widget.pageData.pageId;
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
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => GetAccountTreeCubit(getIt.get<AccountTreeRepoImpl>())..getAllAccountTree(),
            ),
            BlocProvider(
              create: (context) => AddEditNodeCubit(getIt.get<AccountTreeRepoImpl>()),
            ),
          ],
          child: BlocBuilder<GetAccountTreeCubit, GetAccountTreeState>(
            builder: (context, state) {
              if (state is GetAccountTreeSuccess) {
                return AccountingTreeViewBody(
                  tree: state.accountTree,
                );
              } else if (state is GetAccountTreeFailure) {
                return CustomErrorMassage(errorMassage: state.errorMassage);
              } else if (state is GetAccountTreeLoading) {
                return const CustomLoadingWidget();
              } else {
                return const SizedBox();
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
      List<dynamic> dataHeader = await ApiService(Dio()).get(
        endPoint: "web/Structure/getListSetups/AccountView",
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );

      List<dynamic> dataDropdown = await ApiService(Dio()).get(
        endPoint: "home/GetPageDropDown?pageId=${widget.pageData.pageId}",
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      List<HeaderAccountTreeModel> dataListHeader = [];
      for (var i in dataHeader) {
        dataListHeader.add(HeaderAccountTreeModel.fromJson(i));
      }
      List<AllDropdownModel> dataListDropdown = [];
      for (var i in dataDropdown) {
        dataListDropdown.add(AllDropdownModel.fromJson(i));
      }

      AccountingTreeView.dataListHeader = dataListHeader;
      AccountingTreeView.dataListDropdown = dataListDropdown;
    } catch (e) {
      log('Error fetching data: $e');
    }
  }
}
