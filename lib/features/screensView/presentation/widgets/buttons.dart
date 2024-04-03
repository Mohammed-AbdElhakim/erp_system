import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import 'custom_circular_button.dart';

class Buttons extends StatelessWidget {
  const Buttons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 85,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Stack(
        alignment: Alignment.center,
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          PositionedDirectional(
            start: 8,
            top: 8,
            child: CustomCircularButton(
              icon: Icons.search,
              color: AppColors.blue,
              onTap: () {},
            ),
          ),
          PositionedDirectional(
            start: MediaQuery.of(context).size.width / 4.5,
            top: 24,
            child: CustomCircularButton(
              icon: Icons.refresh,
              color: AppColors.orange,
              onTap: () {},
            ),
          ),
          PositionedDirectional(
            top: 32,
            child: CustomCircularButton(
              icon: Icons.add,
              color: AppColors.blueLight,
              onTap: () {},
            ),
          ),
          PositionedDirectional(
            end: MediaQuery.of(context).size.width / 4.5,
            top: 24,
            child: CustomCircularButton(
              icon: Icons.edit_note,
              color: AppColors.blueGreyDark,
              onTap: () {},
            ),
          ),
          PositionedDirectional(
            end: 8,
            top: 8,
            child: CustomCircularButton(
              icon: Icons.delete,
              color: AppColors.red,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
