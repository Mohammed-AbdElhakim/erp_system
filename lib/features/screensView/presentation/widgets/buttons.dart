import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import 'custom_circular_button.dart';

class Buttons extends StatelessWidget {
  const Buttons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          CustomCircularButton(
            icon: Icons.search,
            color: AppColors.blue,
            onTap: () {},
          ),
          CustomCircularButton(
            icon: Icons.refresh,
            color: AppColors.orange,
            onTap: () {},
          ),
          CustomCircularButton(
            icon: Icons.add,
            color: AppColors.blueLight,
            onTap: () {},
          ),
          CustomCircularButton(
            icon: Icons.edit_note,
            color: AppColors.blueGreyDark,
            onTap: () {},
          ),
          CustomCircularButton(
            icon: Icons.delete,
            color: AppColors.red,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
