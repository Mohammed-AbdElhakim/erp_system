import 'package:flutter/material.dart';

import '../../../../core/utils/app_styles.dart';

class DropdownWidget extends StatefulWidget {
  const DropdownWidget({super.key, required this.title});
  final String title;

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  int dropdownMenuValue = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: AppStyles.textStyle14.copyWith(color: Colors.grey),
          ),
          SizedBox(
            height: 40,
            child: DropdownMenu(
              expandedInsets: EdgeInsets.zero,
              dropdownMenuEntries: const [
                DropdownMenuEntry(value: 1, label: "1"),
                DropdownMenuEntry(value: 2, label: "2"),
                DropdownMenuEntry(value: 3, label: "3"),
                DropdownMenuEntry(value: 4, label: "4"),
                DropdownMenuEntry(value: 5, label: "5"),
              ],
              onSelected: (value) {
                if (value != null) {
                  setState(() {
                    dropdownMenuValue = value;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
