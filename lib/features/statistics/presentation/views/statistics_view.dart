import 'package:flutter/material.dart';

import '../../../../core/utils/methods.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../generated/l10n.dart';
import '../../../bottomNavigationBar/presentation/widgets/my_drawer.dart';
import '../widgets/statistics_view_body.dart';

class StatisticsView extends StatelessWidget {
  const StatisticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: CustomAppBar(
        isPortrait: isOrientationPortrait(context),
        title: S.of(context).statistics,
        isTitleInPortrait: true,
      ),
      body: StatisticsViewBody(
        isPortrait: isOrientationPortrait(context),
      ),
    );
  }
}
