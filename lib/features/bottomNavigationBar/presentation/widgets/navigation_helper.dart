import 'package:flutter/material.dart';

import '../../../dashboard/presentation/views/dashboard_view.dart';
import '../../../home/presentation/views/home_view.dart';
import '../../../information.dart';
import '../../../notifications/presentation/views/notifications_view.dart';

class NavigationHelper {
  static Widget getMyWidget(int index) {
    switch (index) {
      case 1:
        return const HomeView();
      case 2:
        return const DashboardView();
      case 3:
        return const NotificationsView();
      default:
        return const Information();
    }
  }
}
