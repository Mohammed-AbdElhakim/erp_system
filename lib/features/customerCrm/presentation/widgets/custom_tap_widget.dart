import 'package:flutter/material.dart';

class CustomTapWidget extends StatelessWidget {
  const CustomTapWidget({
    super.key,
    required this.title,
    required this.onTap,
    required this.color,
  });

  final String title;
  final void Function() onTap;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          ),
        ),
        child: Text(title),
      ),
    );
  }
}
