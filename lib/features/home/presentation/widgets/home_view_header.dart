import 'package:flutter/material.dart';

import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_container.dart';
import '../../../../generated/l10n.dart';

class HomeViewHeader extends StatelessWidget {
  const HomeViewHeader({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: 155,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          top: 14,
          start: 26,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${S.of(context).hi} $name",
              style: AppStyles.textStyle26,
            ),
            Text(
              "${S.of(context).welcome_in}${S.of(context).dynamic_pro}",
              style: AppStyles.textStyle12,
            ),
          ],
        ),
      ),
    );
  }
}
