import 'package:flutter/material.dart';

import '../../features/auth/presentation/widgets/container_custom_clipper.dart';
import '../utils/constants.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.height, required this.child});

  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ContainerCustomClipper(),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          gradient: gradientContainer,
        ),
        child: child,
      ),
    );
  }
}
