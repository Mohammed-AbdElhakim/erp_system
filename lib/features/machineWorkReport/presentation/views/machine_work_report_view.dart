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
import '../../data/repositories/machine_work_report_repo_impl.dart';
import '../manager/machineWorkReport/machine_work_report_cubit.dart';
import '../widgets/machine_work_report_view_body.dart';

class MachineWorkReportView extends StatefulWidget {
  const MachineWorkReportView({super.key, required this.pageData});

  final Pages pageData;

  @override
  State<MachineWorkReportView> createState() => _MachineWorkReportViewState();
}

class _MachineWorkReportViewState extends State<MachineWorkReportView> {
  late final String lang;
  bool _isLangInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // lang = Localizations.localeOf(context).toString();
    if (!_isLangInitialized) {
      lang = Localizations.localeOf(context).toString();
      _isLangInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait = isOrientationPortrait(context);
    final pageTitle = lang == AppStrings.enLangKey ? widget.pageData.nameEn : widget.pageData.nameAr;

    return BlocProvider(
      create: (context) => MachineWorkReportCubit(getIt<MachineWorkReportRepoImpl>()),
      child: ChangeStatusBarColor(
        child: Scaffold(
          appBar: CustomAppBar(
            isPortrait: isPortrait,
            title: pageTitle,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                if (isPortrait)
                  CustomContainer(
                    height: 120,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        pageTitle,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: AppStyles.textStyle26,
                      ),
                    ),
                  )
                else
                  const SizedBox(height: 25),
                MachineWorkReportViewBody(
                  pageData: widget.pageData,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
