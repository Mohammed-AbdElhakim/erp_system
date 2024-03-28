import 'package:erp_system/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_styles.dart';

class CustomMainListTileInDrawer extends StatefulWidget {
  const CustomMainListTileInDrawer({
    Key? key,
    required this.title,
    required this.bodyList,
    // required this.isOpen,
  }) : super(key: key);
  final String title;
  final List<Widget> bodyList;
  // final isOpened isOpen;

  @override
  State<CustomMainListTileInDrawer> createState() =>
      _CustomMainListTileInDrawerState();
}

class _CustomMainListTileInDrawerState
    extends State<CustomMainListTileInDrawer> {
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
      trailing: val ? Icon(Icons.arrow_drop_up) : const SizedBox(),
      // leading: const SizedBox(),
      // backgroundColor: Colors.red,
      children: widget.bodyList,
    );
  }
}
