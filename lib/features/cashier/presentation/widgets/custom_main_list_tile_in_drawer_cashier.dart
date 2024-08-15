import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class CustomMainListTileInDrawerCashier extends StatefulWidget {
  const CustomMainListTileInDrawerCashier({
    Key? key,
    required this.title,
    required this.bodyList,
  }) : super(key: key);
  final String title;
  final List<Widget> bodyList;

  @override
  State<CustomMainListTileInDrawerCashier> createState() =>
      _CustomMainListTileInDrawerCashierState();
}

class _CustomMainListTileInDrawerCashierState
    extends State<CustomMainListTileInDrawerCashier> {
  bool val = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      shape: Border.all(color: Colors.white, width: 0),
      collapsedShape: Border.all(color: Colors.white, width: 0),
      dense: true,
      onExpansionChanged: (v) {
        setState(() {
          val = v;
        });
      },
      title: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Text(
          widget.title,
          style: AppStyles.textStyle18.copyWith(color: AppColors.blueLight),
        ),
      ),
      trailing: val ? const Icon(Icons.arrow_drop_up) : const SizedBox(),
      children: widget.bodyList,
    );
  }
}
