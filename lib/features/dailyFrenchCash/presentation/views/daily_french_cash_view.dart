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
import '../../data/repositories/daily_french_cash_repo_impl.dart';
import '../manager/accounts/accounts_cubit.dart';
import '../manager/dailyFrenchCash/daily_french_cash_cubit.dart';
import '../widgets/daily_french_cash_view_body.dart';

class DailyFrenchCashView extends StatefulWidget {
  const DailyFrenchCashView({super.key, required this.pageData});

  final Pages pageData;

  @override
  State<DailyFrenchCashView> createState() => _DailyFrenchCashViewState();
}

class _DailyFrenchCashViewState extends State<DailyFrenchCashView> {
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
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  AccountsCubit(getIt.get<DailyFrenchCashRepoImpl>())..getAccountsList(),
            ),
            BlocProvider(
              create: (context) =>
                  DailyFrenchCashCubit(getIt.get<DailyFrenchCashRepoImpl>()),
            ),
          ],
          child: BlocBuilder<AccountsCubit, AccountsState>(
            builder: (context, state) {
              if (state is AccountsSuccess) {
                state.accountsList;
                return DailyFrenchCashViewBody(
                  accountsList: state.accountsList,
                );
              } else if (state is AccountsFailure) {
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
