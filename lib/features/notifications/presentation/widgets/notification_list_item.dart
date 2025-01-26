import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/methods.dart';

class NotificationListItem extends StatelessWidget {
  const NotificationListItem({
    super.key,
    required this.onTap,
    required this.child,
  });
  final void Function() onTap;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.blueLight),
          boxShadow: [
            BoxShadow(
                color: colorWithOpacity(color: AppColors.grey, opacity: .8),
                offset: const Offset(-2, 2),
                blurRadius: 2,
                spreadRadius: 1)
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        margin: const EdgeInsets.symmetric(horizontal: 12),
        child: child,
      ),
    );
  }
}
