import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import '../utils/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key, this.actions, required this.isPortrait, required this.title});
  final List<Widget>? actions;
  final bool isPortrait;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isPortrait ? 0 : 25),
      child: AppBar(
        iconTheme: IconThemeData(color: AppColors.white),
        flexibleSpace: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: gradientContainer,
            border: Border(
              bottom: BorderSide(
                color: AppColors.blue,
                width: 1,
              ),
            ),
          ),
        ),
        title: isPortrait
            ? Column(
                children: [
                  Image.asset(
                    AppAssets.logo,
                    height: 25,
                  ),
                  Text(
                    S.of(context).dynamic_pro,
                    textAlign: TextAlign.center,
                    style: AppStyles.textStyle14,
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: AppStyles.textStyle20,
                  ),
                  Column(
                    children: [
                      Image.asset(
                        AppAssets.logo,
                        height: 25,
                      ),
                      Text(
                        S.of(context).dynamic_pro,
                        textAlign: TextAlign.center,
                        style: AppStyles.textStyle14,
                      ),
                    ],
                  )
                ],
              ),
        centerTitle: true,
        elevation: 0.0,
        actions: actions,
        actionsIconTheme: IconThemeData(color: AppColors.white),
        backgroundColor: AppColors.blueDark,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(isPortrait ? kToolbarHeight : 85);
}
