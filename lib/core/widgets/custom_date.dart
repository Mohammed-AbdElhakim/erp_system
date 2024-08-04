import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class CustomDate extends StatefulWidget {
  const CustomDate({super.key, required this.onSelect});
  final void Function(String date) onSelect;

  @override
  State<CustomDate> createState() => _CustomDateState();
}

class _CustomDateState extends State<CustomDate> {
  String date = '';
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        DateTime? dateTime = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1980),
          lastDate: DateTime(2100),
        );
        if (dateTime != null) {
          setState(() {
            date = DateFormat("yyyy-MM-dd", 'en').format(dateTime);
          });
          widget.onSelect(date);
        }
      },
      child: Container(
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.blueDark)),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: Text(
            date,
            textAlign: TextAlign.center,
            style: AppStyles.textStyle14.copyWith(color: Colors.black),
          )),
    );
  }
}
