import 'package:flutter/material.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_container.dart';
import '../../../../generated/l10n.dart';

class LoginViewHeader extends StatelessWidget {
  const LoginViewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: MediaQuery.of(context).size.height * .52,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              S.of(context).welcome,
              textAlign: TextAlign.center,
              style: AppStyles.textStyle32,
            ),
          ),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.asset(
                AppAssets.logo,
                height: 170,
                width: 170,
              ),
              Text(
                S.of(context).dynamic_pro,
                textAlign: TextAlign.center,
                style: AppStyles.textStyle20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
