import 'package:erp_system/core/widgets/change_status_bar_color.dart';
import 'package:erp_system/core/widgets/custom_error_massage.dart';
import 'package:erp_system/core/widgets/custom_loading_widget.dart';
import 'package:erp_system/features/Reports/data/models/report_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/methods.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_container.dart';
import '../../data/repositories/reports_repo_impl.dart';
import '../manager/reports/reports_cubit.dart';
import '../widgets/reports_view_body.dart';

class ReportsView extends StatefulWidget {
  const ReportsView({super.key, required this.pageData});

  final Pages pageData;

  @override
  State<ReportsView> createState() => _ReportsViewState();
}

class _ReportsViewState extends State<ReportsView> {
  String? lang;

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportsCubit(
        getIt.get<ReportsRepoImpl>(),
      )..getReports(pageId: widget.pageData.pageId),
      child: ChangeStatusBarColor(
        child: Scaffold(
          appBar: CustomAppBar(
            isPortrait: isOrientationPortrait(context),
            title: lang == AppStrings.enLangKey
                ? widget.pageData.nameEn
                : widget.pageData.nameAr,
          ),
          body: Column(
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
              BlocBuilder<ReportsCubit, ReportsState>(
                builder: (context, state) {
                  if (state is ReportsSuccess) {
                    List<ReportModel> reportsList = state.reportsList;
                    return ReportsViewBody(
                      reportsList: reportsList,
                    );
                  } else if (state is ReportsFailure) {
                    return CustomErrorMassage(errorMassage: state.errorMassage);
                  } else {
                    return const CustomLoadingWidget();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
