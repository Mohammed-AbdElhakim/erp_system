
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class BuildNewsCard extends StatelessWidget {
  const BuildNewsCard({super.key, required this.newsText, required this.time,});

  final String newsText;
      final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blue.shade900)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            newsText,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
          ),
          const SizedBox(height: 5),
          Text(
            DateFormat('yyyy-MM-dd').format(DateTime.parse(time)),
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
