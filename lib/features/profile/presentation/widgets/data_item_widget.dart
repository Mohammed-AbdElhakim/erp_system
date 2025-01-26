import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class DataItemWidget extends StatelessWidget {
  const DataItemWidget({
    super.key,
    required this.number,
    required this.title,
  });
  final num number;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            "$number",
            style: TextStyle(
                color: AppColors.blueLight,
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          Text(
            title,
            style: TextStyle(color: AppColors.grey, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
