import 'package:flutter/material.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/widgets/custom_container.dart';
import '../../../../generated/l10n.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({
    Key? key,
    required this.userName,
  }) : super(key: key);

  final String userName;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: CircleAvatar(
              radius: 40,
              child: Image.asset(
                AppAssets.logo,
              ),
            ),
          ),
          Text(
            S.of(context).dynamic_pro,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
