import 'package:cached_network_image/cached_network_image.dart';
import 'package:erp_system/features/profile/presentation/widgets/data_item_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
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
                /* backgroundImage: CachedNetworkImageProvider(
                  // "http://161.97.161.180:805/assets/images/icons/pages/637635156668156648CustomerPayment.png",
                  "http://${profileModel.userImageURL}",
                  errorListener: (p0) => const Icon(
                    Icons.error,
                    size: 35,
                  ),

                  // placeholder: (context, url) => const CustomLoadingWidget(),
                ),*/
                // child: Image.asset(AppAssets.logo),
                child: ClipOval(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: CachedNetworkImage(
                      // fit: BoxFit.cover,
                      // imageUrl:
                      //     "http://161.97.161.180:805/assets/images/icons/pages/637635156668156648CustomerPayment.png",
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
                    title: "رصيد السلف",
                    number: profileModel.loansBalance!,
                  ),
                  const VerticalDivider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  DataItemWidget(
                    title: "رصيد الاجازات",
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
                    title: "أيام الحضور",
                    number: profileModel.attendedDays!,
                  ),
                  const VerticalDivider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  DataItemWidget(
                    title: "مفرادات المرتب",
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
