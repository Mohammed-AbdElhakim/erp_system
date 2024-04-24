import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../home/presentation/views/home_view.dart';
import 'my_drawer.dart';

class NavigationHelper {
  static Widget getMyWidget(int index) {
    switch (index) {
      case 1:
        return const HomeView();
      case 2:
        return OrientationBuilder(builder: (context, orientation) {
          final bool isPortrait = orientation == Orientation.portrait;
          return Scaffold(
            drawer: const MyDrawer(),
            appBar: CustomAppBar(
              isPortrait: isPortrait,
              title: "Location",
              actions: [
                Stack(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_none_sharp),
                    ),
                    Positioned(
                      right: 12,
                      top: 15,
                      child: Icon(
                        Icons.circle,
                        color: AppColors.orange,
                        size: 12,
                      ),
                    )
                  ],
                ),
              ],
            ),
            body: const Center(
              child: Text('Location'),
            ),
          );
        });
      case 3:
        return OrientationBuilder(builder: (context, orientation) {
          final bool isPortrait = orientation == Orientation.portrait;
          return Scaffold(
            drawer: const MyDrawer(),
            appBar: CustomAppBar(
              isPortrait: isPortrait,
              title: "Email",
              actions: [
                Stack(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_none_sharp),
                    ),
                    Positioned(
                      right: 12,
                      top: 15,
                      child: Icon(
                        Icons.circle,
                        color: AppColors.orange,
                        size: 12,
                      ),
                    )
                  ],
                ),
              ],
            ),
            body: const Center(
              child: Text('Email'),
            ),
          );
        });
      default:
        return OrientationBuilder(builder: (context, orientation) {
          final bool isPortrait = orientation == Orientation.portrait;
          return Scaffold(
            drawer: const MyDrawer(),
            appBar: CustomAppBar(
              isPortrait: isPortrait,
              title: "Information",
              actions: [
                Stack(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_none_sharp),
                    ),
                    Positioned(
                      right: 12,
                      top: 15,
                      child: Icon(
                        Icons.circle,
                        color: AppColors.orange,
                        size: 12,
                      ),
                    )
                  ],
                ),
              ],
            ),
            body: const Center(
              child: Text('Information'),
            ),
          );
        });
    }
  }
}
