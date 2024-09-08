import 'package:erp_system/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/models/menu_model/pages.dart';
import '../../data/models/pass_data_table_report_view.dart';
import '../../data/models/report_model.dart';

class ReportsViewBody extends StatefulWidget {
  const ReportsViewBody(
      {super.key, required this.reportsList, required this.pageData});
  final List<ReportModel> reportsList;
  final Pages pageData;

  @override
  State<ReportsViewBody> createState() => _ReportsViewBodyState();
}

class _ReportsViewBodyState extends State<ReportsViewBody> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  GoRouter.of(context).push(
                    AppRouter.kTableReportsView,
                    extra: PassDataTableReportView(
                      pageData: widget.pageData,
                      reportModel: widget.reportsList[index],
                    ),
                  );
                },
                child: Card(
                  color: Colors.grey.shade200,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    child: Text(
                      widget.reportsList[index].reportName!,
                    ),
                  ),
                ),
              );
            },
            itemCount: widget.reportsList.length),
      ),
    );
  }
}
