import 'package:flutter/material.dart';

import '../utils/constants.dart';

class ChangeStatusBarColor extends StatelessWidget {
  const ChangeStatusBarColor({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: AppColors.blueDark,
      decoration: BoxDecoration(
        gradient: gradientContainer,
      ),
      child: SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: child,
      ),
    );
  }
}
