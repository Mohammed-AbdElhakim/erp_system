import 'package:flutter/material.dart';

import '../../../../core/utils/app_styles.dart';
import '../../../../generated/l10n.dart';
import 'select_date_widget.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyles.textStyle14.copyWith(color: Colors.grey),
          ),
          Row(
            children: [
              SelectDateWidget(
                title: S.of(context).from,
              ),
              const SizedBox(width: 8),
              SelectDateWidget(
                title: S.of(context).to,
              ),
            ],
          )
        ],
      ),
    );
  }
}
