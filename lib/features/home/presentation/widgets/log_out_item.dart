import 'package:erp_system/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/app_strings.dart';

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
    return InkWell(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        // color: Theme.of(context).primaryColor,
        elevation: 5,
        shadowColor: Colors.white38,
        child: ListTile(
          title: const Padding(
            padding: EdgeInsets.only(right: 20),
            child: Text(
              "تسجيل خروج",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Image.asset(
              "assets/images/logout.png",
              width: 35,
              height: 35,
            ),
          ),
        ),
      ),
      onTap: () {
        Pref.saveBoolToPref(key: AppStrings.isLoginKey, value: false);
        GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
      },
    );
  }
}
