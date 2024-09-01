import 'package:flutter/material.dart';

class TableReportsView extends StatefulWidget {
  const TableReportsView({super.key, required this.reportId});
  final int reportId;

  @override
  State<TableReportsView> createState() => _TableReportsViewState();
}

class _TableReportsViewState extends State<TableReportsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(widget.reportId.toString())),
    );
  }
}
