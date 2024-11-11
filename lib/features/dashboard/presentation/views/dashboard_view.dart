import 'package:flutter/material.dart';

import '../../../../core/utils/methods.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../bottomNavigationBar/presentation/widgets/my_drawer.dart';
import '../widgets/dashboard_view_body.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: CustomAppBar(
        isPortrait: isOrientationPortrait(context),
        title: "Dashboard",
      ),
      body: DashboardViewBody(
        isPortrait: isOrientationPortrait(context),
      ),
    );
  }
}
