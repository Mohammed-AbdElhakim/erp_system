import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomButton(
          text: "Logout",
          width: 100,
          height: 35,
          textStyle: const TextStyle(fontSize: 14, color: Colors.white),
          onTap: () {
            Pref.saveBoolToPref(key: AppStrings.isLoginKey, value: false);
            GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
          },
        ),
      ),
    );
  }
}
