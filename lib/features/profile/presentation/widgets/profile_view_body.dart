import 'package:cached_network_image/cached_network_image.dart';
import 'package:erp_system/features/profile/presentation/widgets/data_item_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/profile_model.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key, required this.profileModel});
  final ProfileModel profileModel;

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
                child: ClipOval(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: CachedNetworkImage(
                      imageUrl: "http://${profileModel.userImageURL}",
                      placeholder: (context, url) =>
                          const CustomLoadingWidget(),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error,
                        size: 35,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              profileModel.userName!,
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
                  profileModel.companyName!,
                  style: AppStyles.textStyle16.copyWith(color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 50),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DataItemWidget(
                    title: S.of(context).advance_balance,
                    number: profileModel.loansBalance!,
                  ),
                  const VerticalDivider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  DataItemWidget(
                    title: S.of(context).vacation_balance,
                    number: profileModel.daysOffBalance!,
                  ),
                ],
              ),
            ),
            const Divider(
              endIndent: 30,
              indent: 30,
              height: 30,
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DataItemWidget(
                    title: S.of(context).attendance_days,
                    number: profileModel.attendedDays!,
                  ),
                  const VerticalDivider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  DataItemWidget(
                    title: S.of(context).salary_items,
                    number: profileModel.salary!,
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
