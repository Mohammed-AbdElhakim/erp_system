import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class InitDropdown extends StatelessWidget {
  const InitDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.blueDark),
          borderRadius: BorderRadius.circular(12)),
      child: const Row(
        children: [
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(
              Icons.keyboard_arrow_down,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
