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
import '../../../screenTable/data/models/item_list_setup_model.dart';
import '../../../screenTable/data/repositories/screen_repo_impl.dart';
import '../../../screenTable/presentation/manager/getListSetups/get_list_setups_cubit.dart';
import '../../data/repositories/cashier_repo_impl.dart';
import '../manager/cashier/cashier_cubit.dart';
import '../widgets/cashier_view_body.dart';

class CashierView extends StatefulWidget {
  const CashierView({super.key, required this.pageData});

  final Pages pageData;

  @override
  State<CashierView> createState() => _CashierViewState();
}

class _CashierViewState extends State<CashierView> {
  String? lang;
  int _currentIndex = 0;

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CashierCubit(
            getIt.get<CashierRepoImpl>(),
          )..getCashierData(),
        ),
        BlocProvider(
          create: (context) => GetListSetupsCubit(getIt.get<ScreenRepoImpl>())
            ..getListSetups("SalesDetailView"),
        ),
      ],
      child: ChangeStatusBarColor(
        child: Scaffold(
          appBar: CustomAppBar(
            isPortrait: isOrientationPortrait(context),
            title: lang == AppStrings.enLangKey
                ? widget.pageData.nameEn
                : widget.pageData.nameAr,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: _currentIndex == index ? 12 : 8,
                    height: _currentIndex == index ? 12 : 8,
                    decoration: BoxDecoration(
                      color: _currentIndex == index ? Colors.blue : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              )
            ],
          ),
          body: BlocBuilder<CashierCubit, CashierState>(
            builder: (context, cstate) {
              if (cstate is CashierSuccess) {
                return BlocBuilder<GetListSetupsCubit, GetListSetupsState>(
                  builder: (context, state) {
                    if (state is GetListSetupsSuccess) {
                      List<ItemListSetupModel> listSetup = state.listSetupModel;
                      List<ItemListSetupModel> listColumn = [];
                      List<dynamic> listKey = [];
                      List<String> category = [];
                      List<String> listHeader = [];

                      for (var item in state.listSetupModel) {
                        category.add(item.categoryTitle ?? '');
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
                      return CashierViewBody(
                        title: lang == AppStrings.enLangKey
                            ? widget.pageData.nameEn
                            : widget.pageData.nameAr,
                        allModalityList: cstate.modalityList,
                        allProCompanyList: cstate.pRoCompanyList,
                        allProductList: cstate.productList,
                        listSetup: listSetup,
                        categoryList: categoryList,
                        listKey: listKey,
                        listColumn: listColumn,
                        listHeader: listHeader,
                        onPageChanged: (pageIndex) {
                          setState(() {
                            _currentIndex = pageIndex;
                          });
                        },
                      );
                    } else if (state is GetListSetupsFailure) {
                      return CustomErrorMassage(
                          errorMassage: state.errorMassage);
                    } else {
                      return const CustomLoadingWidget();
                    }
                  },
                );
              } else if (cstate is CashierFailure) {
                return CustomErrorMassage(errorMassage: cstate.errorMassage);
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
