import 'package:erp_system/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';

class LogoutItem extends StatefulWidget {
  const LogoutItem({
    Key? key,
  }) : super(key: key);

  @override
  State<LogoutItem> createState() => _LogoutItemState();
}

class _LogoutItemState extends State<LogoutItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Text(
          "تسجيل خروج",
          style: AppStyles.textStyle18.copyWith(color: AppColors.blueLight),
        ),
      ),
      onTap: () {
        Pref.saveBoolToPref(key: AppStrings.isLoginKey, value: false);
        GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
      },
    );
  }
}
