import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/constants.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(gradient: gradientContainer),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.home_outlined,
              size: 30,
              color: AppColors.white,
            ),
          ),
          Icon(
            Icons.location_on_outlined,
            size: 30,
            color: AppColors.white,
          ),
          Icon(
            Icons.email_outlined,
            size: 30,
            color: AppColors.white,
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.person_outline,
                  size: 30,
                  color: AppColors.white,
                ),
              ),
              const Positioned(
                right: 10,
                top: 12,
                child: Icon(
                  Icons.circle,
                  color: Colors.orange,
                  size: 12,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
