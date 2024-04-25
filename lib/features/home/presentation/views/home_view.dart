import 'package:erp_system/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/change_status_bar_color.dart';
import '../../../../generated/l10n.dart';
import '../../../bottomNavigationBar/presentation/widgets/my_drawer.dart';
import '../widgets/home_view_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? userName;
  String? companyName;
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    bool isPortrait = orientation == Orientation.portrait;
    return ChangeStatusBarColor(
      child: Scaffold(
        drawer: const MyDrawer(),
        appBar: CustomAppBar(
          isPortrait: isPortrait,
          title:
              "${S.of(context).hi} $userName \n${S.of(context).welcome_in}$companyName",
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
        body: HomeViewBody(
          isPortrait: isPortrait,
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
