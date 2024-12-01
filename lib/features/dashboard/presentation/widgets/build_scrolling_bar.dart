import 'package:flutter/material.dart';

class BuildScrollingBar extends StatelessWidget {
  const BuildScrollingBar(
      {super.key,
      required this.controller,
      required this.items,
      required this.height});
  final ScrollController controller;
  final List<Widget> items;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        controller: controller,
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: items[index],
          );
        },
      ),
    );
  }
}
