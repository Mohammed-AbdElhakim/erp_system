import 'package:flutter/material.dart';

import '../../../../core/widgets/change_status_bar_color.dart';
import '../widgets/splash_view_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeStatusBarColor(
      child: Scaffold(
        backgroundColor: Colors.cyan[100],
        body: const SplashViewBody(),
      ),
    );
  }
}
