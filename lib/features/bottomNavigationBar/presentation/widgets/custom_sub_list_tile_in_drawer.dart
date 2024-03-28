import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_loaging_widget.dart';

class CustomSubListTileInDrawer extends StatelessWidget {
  const CustomSubListTileInDrawer({
    Key? key,
    required this.title,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  final String title;
  final Function onTap;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 30),
      child: ListTile(
        title: Text(
          title,
          style: AppStyles.textStyle18.copyWith(color: AppColors.blueDark),
        ),
        leading: CachedNetworkImage(
          width: 30,
          height: 30,
          // fit: BoxFit.fill,
          imageUrl: "http://161.97.161.180/assets/$icon",
          placeholder: (context, url) => const CustomLoadingWidget(),
          errorWidget: (context, url, error) => const Icon(
            Icons.error,
            size: 35,
          ),
        ),
        onTap: () => onTap(),
      ),
    );
  }
}
