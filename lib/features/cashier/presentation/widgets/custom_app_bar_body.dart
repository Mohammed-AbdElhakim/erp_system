import 'package:erp_system/core/utils/methods.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/constants.dart';

class CustomAppBarBody extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBarBody({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      centerTitle: true,
      actionsIconTheme: IconThemeData(color: AppColors.white),
      backgroundColor: AppColors.blueDark,
      title: Text(
        isOrientationPortrait(context) ? title : "",
        textAlign: TextAlign.center,
        style: AppStyles.textStyle20,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
