import 'package:flutter/material.dart';

import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_container.dart';
import '../../../../generated/l10n.dart';

class HomeViewHeader extends StatefulWidget {
  const HomeViewHeader({super.key});

  @override
  State<HomeViewHeader> createState() => _HomeViewHeaderState();
}

class _HomeViewHeaderState extends State<HomeViewHeader> {
  String? userName;
  String? companyName;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: 155,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          top: 14,
          start: 26,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${S.of(context).hi} $userName",
              style: AppStyles.textStyle26,
            ),
            Text(
              "${S.of(context).welcome_in}$companyName",
              style: AppStyles.textStyle12,
            ),
          ],
        ),
      ),
    );
  }

  void getUserData() async {
    userName = await Pref.getStringFromPref(key: AppStrings.userNameKey) ?? "";
    companyName =
        await Pref.getStringFromPref(key: AppStrings.companyNameKey) ?? "";
    setState(() {});
  }
}
