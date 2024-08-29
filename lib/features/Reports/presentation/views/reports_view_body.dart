import 'package:flutter/material.dart';

import '../../data/models/report_model.dart';

class ReportsViewBody extends StatefulWidget {
  const ReportsViewBody({super.key, required this.reportsList});
  final List<ReportModel> reportsList;

  @override
  State<ReportsViewBody> createState() => _ReportsViewBodyState();
}

class _ReportsViewBodyState extends State<ReportsViewBody> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Card(
              child: Text(widget.reportsList[index].reportName!),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 8);
          },
          itemCount: widget.reportsList.length),
    );
  }
}
