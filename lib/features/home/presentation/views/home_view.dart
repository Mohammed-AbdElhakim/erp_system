import 'package:flutter/material.dart';

import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/app_strings.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Pref.saveBoolToPref(key: AppStrings.isLoginKey, value: false);
    // Pref.saveStringToPref(key: AppStrings.hostKey, value: '');
    return const Scaffold();
  }
}
