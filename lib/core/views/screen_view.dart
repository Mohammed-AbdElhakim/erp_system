import 'package:flutter/material.dart';

import '../../features/attendance/presentation/views/attendance_view.dart';
import '../../features/chart/presentation/views/chart_view.dart';
import '../../features/screenTable/presentation/views/screen_table.dart';
import '../../features/tasks/presentation/views/tasks_view.dart';
import '../models/menu_model/pages.dart';

class ScreenView extends StatelessWidget {
  const ScreenView({super.key, required this.pageData});

  final Pages pageData;

  @override
  Widget build(BuildContext context) {
    return getWidgetBody(pageData.url);
  }

  getWidgetBody(String navigationKey) {
    switch (navigationKey) {
      case "mobileAttendance":
        return AttendanceView(pageData: pageData);
      case "employeeTask":
        return TasksView(pageData: pageData);
      case "general":
        return ScreenTable(pageData: pageData);
      case "chart":
        return ChartView(pageData: pageData);
    }
  }
}
