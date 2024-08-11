import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/methods.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/change_status_bar_color.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_container.dart';
import '../../data/repositories/general_balance_repo_impl.dart';
import '../manager/generalBalance/general_balance_cubit.dart';
import '../widgets/general_balance_view_body.dart';

class GeneralBalanceView extends StatefulWidget {
  const GeneralBalanceView({super.key, required this.pageData});

  final Pages pageData;

  @override
  State<GeneralBalanceView> createState() => _GeneralBalanceViewState();
}

class _GeneralBalanceViewState extends State<GeneralBalanceView> {
  String? lang;

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GeneralBalanceCubit(getIt.get<GeneralBalanceRepoImpl>()),
      child: ChangeStatusBarColor(
        child: Scaffold(
          appBar: CustomAppBar(
            isPortrait: isOrientationPortrait(context),
            title: lang == AppStrings.enLangKey
                ? widget.pageData.nameEn
                : widget.pageData.nameAr,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                isOrientationPortrait(context)
                    ? CustomContainer(
                        height: 120,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            lang == AppStrings.enLangKey
                                ? widget.pageData.nameEn
                                : widget.pageData.nameAr,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: AppStyles.textStyle26,
                          ),
                        ),
                      )
                    : const SizedBox(
                        height: 25,
                      ),
                const ProfitViewBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
