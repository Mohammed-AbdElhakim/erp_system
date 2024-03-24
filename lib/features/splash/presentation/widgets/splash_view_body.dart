import 'package:erp_system/core/utils/app_assets.dart';
import 'package:erp_system/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../generated/l10n.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> sliderAnimation;

  @override
  void initState() {
    super.initState();
    initSlidAnimation();
    navigateToNewView();
    generateUniqueId();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(gradient: gradientContainer),
      child: AnimatedBuilder(
          animation: sliderAnimation,
          builder: (context, _) {
            return SlideTransition(
              position: sliderAnimation,
              child: Stack(
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
            );
          }),
    );
  }

  void navigateToNewView() {
    Future.delayed(
      const Duration(seconds: 5),
      () async {
        String host =
            await Pref.getStringFromPref(key: AppStrings.hostKey) ?? "";
        bool isLogin =
            await Pref.getBoolFromPref(key: AppStrings.isLoginKey) ?? false;
        if (isLogin == true && host.isNotEmpty) {
          if (mounted) {
            GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
          }
        } else if (isLogin == false && host.isNotEmpty) {
          if (mounted) {
            GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
          }
        } else if (isLogin == false && host.isEmpty) {
          if (mounted) {
            GoRouter.of(context).pushReplacement(AppRouter.kHostView);
          }
        }
      },
    );
  }

  void initSlidAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ),
    );
    sliderAnimation = Tween<Offset>(begin: const Offset(0, 2), end: Offset.zero)
        .animate(animationController);
    animationController.forward();
  }

  void generateUniqueId() async {
    String uniqueId =
        await Pref.getStringFromPref(key: AppStrings.uniqueIdKey) ?? "";
    if (uniqueId.isEmpty) {
      Uuid uuid = const Uuid();
      Pref.saveStringToPref(key: AppStrings.uniqueIdKey, value: uuid.v1());
    }
  }
}
