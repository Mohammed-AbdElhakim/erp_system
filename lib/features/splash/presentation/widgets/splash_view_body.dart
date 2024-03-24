import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/app_strings.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AnimatedBuilder(
            animation: sliderAnimation,
            builder: (context, _) {
              return SlideTransition(
                position: sliderAnimation,
                child: const FlutterLogo(
                  size: 100,
                ),
              );
            }),
      ],
    );
  }

  void navigateToNewView() {
    Future.delayed(
      const Duration(seconds: 4),
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
