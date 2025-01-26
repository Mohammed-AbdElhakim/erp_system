import 'package:erp_system/features/profile/presentation/widgets/data_item_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 77,
              backgroundColor: AppColors.blueLight,
              child: CircleAvatar(
                radius: 75,
                backgroundColor: Colors.white,
                child: Image.asset(AppAssets.logo),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Mohamed Abd Elhakim",
              style: AppStyles.textStyle16.copyWith(color: Colors.black),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.business_sharp,
                  color: AppColors.blueLight,
                ),
                const SizedBox(width: 8),
                Text(
                  "Egy Dynamic",
                  style: AppStyles.textStyle16.copyWith(color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 50),
            const IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DataItemWidget(
                    title: "رصيد السلف",
                    number: 1500,
                  ),
                  VerticalDivider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  DataItemWidget(
                    title: "رصيد الاجازات",
                    number: 21,
                  ),
                ],
              ),
            ),
            const Divider(
              endIndent: 30,
              indent: 30,
              height: 30,
            ),
            const IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DataItemWidget(
                    title: "أيام الحضور",
                    number: 30,
                  ),
                  VerticalDivider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  DataItemWidget(
                    title: "مفرادات المرتب",
                    number: 5000,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
