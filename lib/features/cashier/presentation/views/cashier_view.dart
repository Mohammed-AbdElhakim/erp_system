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
import '../../data/models/item_list_setup_model.dart';
import '../../data/models/modality_model.dart';
import '../../data/models/pro_company_model.dart';
import '../../data/models/product_model.dart';
import '../../data/models/tap_model.dart';
import '../../data/repositories/cashier_repo_impl.dart';
import '../manager/addEditProduct/add_edit_product_cubit.dart';
import '../manager/cashier/cashier_cubit.dart';
import '../manager/getAllDropdownList/get_all_dropdown_list_cubit.dart';
import '../manager/getListSetups/get_list_setups_cubit.dart';
import '../manager/getPageDetails/get_page_details_cubit.dart';
import '../widgets/cashier_view_body.dart';

class CashierView extends StatefulWidget {
  const CashierView({super.key, required this.pageData});

  final Pages pageData;
  static List<AllDropdownModel> myAllDropdownModelList = [];

  @override
  State<CashierView> createState() => _CashierViewState();
}

class _CashierViewState extends State<CashierView> {
  String? lang;
  int _currentPage = 0;
  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEditProductCubit(getIt.get<CashierRepoImpl>()),
      child: ChangeStatusBarColor(
        child: Scaffold(
          appBar: CustomAppBar(
            isPortrait: isOrientationPortrait(context),
            title: lang == AppStrings.enLangKey
                ? widget.pageData.nameEn
                : widget.pageData.nameAr,
            actions: [
              ...List.generate(3, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 10 : 6,
                  height: _currentPage == index ? 10 : 6,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? Colors.white : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                );
              }),
              const SizedBox(width: 20),
            ],
          ),
          body: BlocProvider(
            create: (context) =>
                GetAllDropdownListCubit(getIt.get<CashierRepoImpl>())
                  ..getAllDropdownList(pageId: widget.pageData.pageId),
            child:
                BlocBuilder<GetAllDropdownListCubit, GetAllDropdownListState>(
              builder: (context, state) {
                if (state is GetAllDropdownListSuccess) {
                  List<AllDropdownModel> allDropdownModelList =
                      state.allDropdownModelList;
                  CashierView.myAllDropdownModelList = allDropdownModelList;
                  return BlocProvider(
                    create: (context) =>
                        GetPageDetailsCubit(getIt.get<CashierRepoImpl>())
                          ..getPageDetails(widget.pageData.pageId),
                    child:
                        BlocBuilder<GetPageDetailsCubit, GetPageDetailsState>(
                      builder: (context, state) {
                        if (state is GetPageDetailsSuccess) {
                          ListTaps tapData = state.tapModel.list[0];
                          return BlocProvider(
                            create: (context) => GetListSetupsCubit(
                                getIt.get<CashierRepoImpl>())
                              ..getListSetups(state.tapModel.list[0].listName),
                            child: BlocBuilder<GetListSetupsCubit,
                                GetListSetupsState>(
                              builder: (context, state) {
                                if (state is GetListSetupsSuccess) {
                                  List<ItemListSetupModel> listSetup =
                                      state.listSetupModel;
                                  List<ItemListSetupModel> listColumn = [];
                                  List<String> listHeader = [];

                                  for (var item in state.listSetupModel) {
                                    if (item.insertVisable == true &&
                                        item.cvisable == true &&
                                        item.visible == true &&
                                        item.isGeneral != true) {
                                      listColumn.add(item);
                                      listHeader.add(
                                          lang == AppStrings.enLangKey
                                              ? item.enColumnLabel!
                                              : item.arColumnLabel!);
                                    }
                                  }

                                  return BlocProvider(
                                    create: (context) => CashierCubit(
                                      getIt.get<CashierRepoImpl>(),
                                    )..getCashierData(),
                                    child:
                                        BlocBuilder<CashierCubit, CashierState>(
                                      builder: (context, state) {
                                        if (state is CashierSuccess) {
                                          List<ProCompanyItem>
                                              allProCompanyList =
                                              state.pRoCompanyList;
                                          List<ModalityItem> allModalityList =
                                              state.modalityList;
                                          List<ProductItem> allProductList =
                                              state.productList;
                                          return CashierViewBody(
                                            onPageChange: (currentPage) {
                                              setState(() {
                                                _currentPage = currentPage;
                                              });
                                            },
                                            allModalityList: allModalityList,
                                            allProCompanyList:
                                                allProCompanyList,
                                            allProductList: allProductList,
                                            listSetup: listSetup,
                                            tapData: tapData,
                                            pageData: widget.pageData,
                                            listColumn: listColumn,
                                            listHeader: listHeader,
                                          );
                                        } else if (state is CashierFailure) {
                                          return CustomErrorMassage(
                                              errorMassage: state.errorMassage);
                                        } else {
                                          return const CustomLoadingWidget();
                                        }
                                      },
                                    ),
                                  );
                                } else if (state is GetListSetupsFailure) {
                                  return CustomErrorMassage(
                                      errorMassage: state.errorMassage);
                                } else {
                                  return const CustomLoadingWidget();
                                }
                              },
                            ),
                          );
                        } else if (state is GetPageDetailsFailure) {
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
      ),
    );
  }
}
