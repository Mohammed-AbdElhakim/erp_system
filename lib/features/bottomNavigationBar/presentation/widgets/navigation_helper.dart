import 'package:flutter/material.dart';

import '../../../home/presentation/views/home_view.dart';

class NavigationHelper {
  static Widget getMyWidget(int index) {
    switch (index) {
      case 1:
        return const HomeView();
      case 2:
        return const Center(
          child: Text('Location'),
        );
      case 3:
        return const Center(
          child: Text('Email'),
        );
      default:
        return const Center(
          child: Text('Information'),
        );
    }
  }
}
