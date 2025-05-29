import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/app_colors.dart';

class CustomDatePickerField extends StatelessWidget {
  final String? title;
  final bool isRequired;
  final String? initialDateString;
  final Function(DateTime?) onDateSelected;
  final Function()? onClear;

  const CustomDatePickerField({
    Key? key,
    required this.title,
    this.isRequired = false,
    this.initialDateString,
    required this.onDateSelected,
    this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String displayDate = '';
    if (initialDateString != null && initialDateString!.isNotEmpty) {
      try {
        displayDate = DateFormat("yyyy-MM-dd", 'en').format(DateTime.parse(initialDateString!).toLocal());
      } catch (_) {
        displayDate = '';
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title ?? '',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              if (isRequired)
                const Icon(
                  Icons.star,
                  color: Colors.red,
                  size: 10,
                )
            ],
          ),
          InkWell(
            onTap: () async {
              DateTime initial = DateTime.now();
              if (initialDateString != null && initialDateString!.isNotEmpty) {
                initial = DateTime.tryParse(initialDateString!) ?? DateTime.now();
              }

              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: initial,
                firstDate: DateTime(1980),
                lastDate: DateTime(2100),
              );
              onDateSelected(picked);
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.blueDark),
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    displayDate.isNotEmpty ? displayDate : "",
                    style: TextStyle(
                      color: displayDate.isNotEmpty ? Colors.black : Colors.grey,
                    ),
                  ),
                  if (displayDate.isNotEmpty)
                    GestureDetector(
                      onTap: onClear,
                      child: const Icon(Icons.close, color: Colors.blue, size: 18),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
