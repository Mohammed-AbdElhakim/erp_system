import 'package:erp_system/features/tasks/presentation/views/tasks_view.dart';
import 'package:flutter/material.dart';

import '../../features/attendance/presentation/views/attendance_view.dart';
import '../../features/screenTable/presentation/views/screen_table.dart';
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
      // default:
      //   return ScreenTable(pageData: pageData);
    }
  }
}
