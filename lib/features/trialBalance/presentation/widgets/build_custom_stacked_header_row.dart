import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../core/utils/app_styles.dart';

StackedHeaderRow buildCustomStackedHeaderRow() {
  return StackedHeaderRow(cells: [
    StackedHeaderCell(
        columnNames: ['acName'],
        child: Center(child: Text('الحساب', style: AppStyles.textStyle14))),
    StackedHeaderCell(
        columnNames: ['depitBefor', 'creditBefor'],
        child: Center(
            child: Text('الأرصدة الافتتاحية', style: AppStyles.textStyle14))),
    StackedHeaderCell(
        columnNames: ['depitMony', 'creditMony'],
        child: Center(child: Text('الحركة', style: AppStyles.textStyle14))),
    StackedHeaderCell(
        columnNames: ['depitSum', 'creditSum'],
        child: Center(child: Text('مجاميع', style: AppStyles.textStyle14))),
    StackedHeaderCell(
        columnNames: ['depitAfter', 'creditAfter'],
        child: Center(
            child: Text('الأرصدة الختامية', style: AppStyles.textStyle14))),
  ]);
}
