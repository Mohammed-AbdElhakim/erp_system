import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_loaging_widget.dart';
import '../../../home/data/models/menu_model/pages.dart';

class CustomSubListTileInDrawer extends StatefulWidget {
  const CustomSubListTileInDrawer({
    Key? key,
    required this.page,
  }) : super(key: key);

  final Pages page;

  @override
  State<CustomSubListTileInDrawer> createState() =>
      _CustomSubListTileInDrawerState();
}

class _CustomSubListTileInDrawerState extends State<CustomSubListTileInDrawer> {
  String? lang;
  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 15),
      child: ListTile(
        title: Text(
          lang == AppStrings.enLangKey
              ? widget.page.nameEn
              : widget.page.nameAr,
          style: AppStyles.textStyle18.copyWith(color: AppColors.blueDark),
        ),
        leading: CachedNetworkImage(
          width: 30,
          height: 30,
          // fit: BoxFit.fill,
          imageUrl: "http://${widget.page.icon}",
          placeholder: (context, url) => const CustomLoadingWidget(),
          errorWidget: (context, url, error) => const Icon(
            Icons.error,
            size: 35,
          ),
        ),
        onTap: () {
          GoRouter.of(context).push(AppRouter.kScreenView, extra: widget.page);
          GoRouter.of(context).pop();
        },
        dense: true,
      ),
    );
  }
}
