import 'package:flutter/material.dart';

import '../../../../core/models/menu_model/pages.dart';
import '../../../attendance/presentation/views/attendance_view.dart';
import '../../../screenTable/presentation/views/screen_table.dart';

class ScreenView extends StatelessWidget {
  const ScreenView({super.key, required this.pageData});

  final Pages pageData;

  @override
  Widget build(BuildContext context) {
    return getWidgetBody(pageData.navigationKey);
  }

  getWidgetBody(String navigationKey) {
    switch (navigationKey) {
      case "Mobile Attendance":
        return AttendanceView(pageData: pageData);
      default:
        return ScreenTable(pageData: pageData);
    }
  }
}
