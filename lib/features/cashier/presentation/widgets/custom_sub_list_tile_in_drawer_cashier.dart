import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../data/models/modality_model.dart';

class CustomSubListTileInDrawerCashier extends StatefulWidget {
  const CustomSubListTileInDrawerCashier({
    Key? key,
    required this.modalityItem,
    required this.onTap,
  }) : super(key: key);

  final ModalityItem modalityItem;
  final void Function(int modalityId) onTap;

  @override
  State<CustomSubListTileInDrawerCashier> createState() =>
      _CustomSubListTileInDrawerCashierState();
}

class _CustomSubListTileInDrawerCashierState
    extends State<CustomSubListTileInDrawerCashier> {
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
          widget.modalityItem.modalityName!,
          style: AppStyles.textStyle18.copyWith(color: AppColors.blueDark),
        ),
        // leading: CachedNetworkImage(
        //   width: 30,
        //   height: 30,
        //   imageUrl: "http://${widget.page.icon}",
        //   placeholder: (context, url) => const CustomLoadingWidget(),
        //   errorWidget: (context, url, error) => const Icon(
        //     Icons.error,
        //     size: 35,
        //   ),
        // ),
        onTap: () {
          // GoRouter.of(context).push(AppRouter.kScreenView, extra: widget.page);
          widget.onTap(widget.modalityItem.modalityID!);
          GoRouter.of(context).pop();
        },
        dense: true,
      ),
    );
  }
}
