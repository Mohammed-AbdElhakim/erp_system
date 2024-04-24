import 'package:flutter/material.dart';

import '../../../../core/widgets/change_status_bar_color.dart';
import '../widgets/home_view_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        final bool isPortrait = orientation == Orientation.portrait;
        return ChangeStatusBarColor(
          child: Scaffold(
            body: HomeViewBody(
              isPortrait: isPortrait,
            ),
          ),
        );
      },
    );
  }
}
