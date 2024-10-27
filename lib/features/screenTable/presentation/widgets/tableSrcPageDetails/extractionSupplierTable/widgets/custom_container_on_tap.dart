import 'package:flutter/material.dart';

class CustomContainerOnTap extends StatelessWidget {
  const CustomContainerOnTap({
    super.key,
    required this.title,
    required this.onTap,
  });
  final String title;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          margin: const EdgeInsetsDirectional.only(top: 5, bottom: 10, end: 12),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: Colors.black,
              )),
          child: Text(title)),
    );
  }
}
