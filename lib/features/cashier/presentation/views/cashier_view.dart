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

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CashierCubit(
        getIt.get<CashierRepoImpl>(),
      )..getCashierData(),
      child: ChangeStatusBarColor(
        child: Scaffold(
          appBar: CustomAppBar(
            isPortrait: isOrientationPortrait(context),
            title: lang == AppStrings.enLangKey
                ? widget.pageData.nameEn
                : widget.pageData.nameAr,
          ),
          body: BlocBuilder<CashierCubit, CashierState>(
            builder: (context, state) {
              if (state is CashierSuccess) {
                return CashierViewBody(
                  title: lang == AppStrings.enLangKey
                      ? widget.pageData.nameEn
                      : widget.pageData.nameAr,
                  allModalityList: state.modalityList,
                  allProCompanyList: state.pRoCompanyList,
                  allProductList: state.productList,
                );
              } else if (state is CashierFailure) {
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
