import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class CustomDrawerItem extends StatefulWidget {
  const CustomDrawerItem({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);
  final String text;
  final Function() onTap;

  @override
  State<CustomDrawerItem> createState() => _CustomDrawerItemState();
}

class _CustomDrawerItemState extends State<CustomDrawerItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Text(
          widget.text,
          style: AppStyles.textStyle18.copyWith(color: AppColors.blueLight),
        ),
      ),
      onTap: widget.onTap,
    );
  }
}
