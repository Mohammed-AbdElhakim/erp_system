import 'package:erp_system/features/Reports/data/models/table_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/methods.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/change_status_bar_color.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_container.dart';
import '../../../../core/widgets/custom_error_massage.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../data/models/report_model.dart';
import '../../data/repositories/reports_repo_impl.dart';
import '../manager/tableReport/table_report_cubit.dart';
import '../widgets/table_reports_view_body.dart';

class TableReportsView extends StatefulWidget {
  const TableReportsView({super.key, required this.reportModel});
  final ReportModel reportModel;

  @override
  State<TableReportsView> createState() => _TableReportsViewState();
}

class _TableReportsViewState extends State<TableReportsView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TableReportCubit(
        getIt.get<ReportsRepoImpl>(),
      )..getTableReport(reportId: widget.reportModel.id!),
      child: ChangeStatusBarColor(
        child: Scaffold(
          appBar: CustomAppBar(
            isPortrait: isOrientationPortrait(context),
            title: widget.reportModel.reportName!,
          ),
          body: Column(
            children: [
              isOrientationPortrait(context)
                  ? CustomContainer(
                      height: 120,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          widget.reportModel.reportName!,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: AppStyles.textStyle26,
                        ),
                      ),
                    )
                  : const SizedBox(
                      height: 25,
                    ),
              BlocBuilder<TableReportCubit, TableReportState>(
                builder: (context, state) {
                  if (state is TableReportSuccess) {
                    TableModel tableModel = state.tableModel;
                    return TableReportsViewBody(
                      tableModel: tableModel,
                    );
                  } else if (state is TableReportFailure) {
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
