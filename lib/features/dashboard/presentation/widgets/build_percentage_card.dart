import 'package:flutter/material.dart';

class BuildPercentageCard extends StatelessWidget {
  const BuildPercentageCard(
      {super.key,
      required this.title,
      required this.value,
      required this.color});
  final String title;
  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade300,
                offset: const Offset(1, 1),
                blurRadius: 1,
                spreadRadius: 1),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(
                  value: value,
                  color: color,
                  // backgroundColor: color.withOpacity(.2),
                  backgroundColor: color.withAlpha(51),
                  strokeWidth: 6,
                ),
              ),
              Text(
                "${(value * 100).toInt()}%",
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          FittedBox(
            child: Text(
              title,
              style: TextStyle(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
