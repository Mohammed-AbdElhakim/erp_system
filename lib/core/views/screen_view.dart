import 'package:flutter/material.dart';

import '../../features/Reports/presentation/views/reports_view.dart';
import '../../features/accountProf/presentation/views/account_prof_view.dart';
import '../../features/attendance/presentation/views/attendance_view.dart';
import '../../features/cashier/presentation/views/cashier_view.dart';
import '../../features/chart/presentation/views/chart_view.dart';
import '../../features/generalBalance/presentation/views/general_balance_view.dart';
import '../../features/profit/presentation/views/profit_view.dart';
import '../../features/screenTable/presentation/views/screen_table.dart';
import '../../features/tasks/presentation/views/tasks_view.dart';
import '../../features/trialBalance/presentation/views/trial_balance.dart';
import '../models/menu_model/pages.dart';

class ScreenView extends StatelessWidget {
  const ScreenView({super.key, required this.pageData});

  final Pages pageData;

  @override
  Widget build(BuildContext context) {
    return getWidgetBody(pageData);
  }

  getWidgetBody(Pages pageData) {
    switch (pageData.url) {
      case "mobileAttendance":
        return AttendanceView(pageData: pageData);
      case "employeeTask":
        return TasksView(pageData: pageData);
      case "chart":
        return ChartView(pageData: pageData);
      case "general":
        switch (pageData.tableSrc) {
          case "profit":
            return ProfitView(pageData: pageData);
          case "genralBalance":
            return GeneralBalanceView(pageData: pageData);
          case "trialBalance":
            return TrialBalance(pageData: pageData);
          case "cashier":
            return CashierView(pageData: pageData);
          case "PivotTable":
            return ReportsView(pageData: pageData);
          case "profAccount":
            return AccountProfView(pageData: pageData);
          default:
            return ScreenTable(pageData: pageData);
        }
    }
  }
}
