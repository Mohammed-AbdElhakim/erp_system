import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'container_custom_clipper.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer(
      {super.key, required this.height, required this.child, this.width});

  final double height;
  final double? width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ContainerCustomClipper(),
      child: Container(
        height: height,
        width: width ?? MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: gradientContainer,
        ),
        child: child,
      ),
    );
  }
}
