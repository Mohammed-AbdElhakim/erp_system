import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class CustomTimePickerField extends StatefulWidget {
  const CustomTimePickerField({super.key, required this.title, required this.itemIsRequired});

  final String title;
  final bool itemIsRequired;

  @override
  State<CustomTimePickerField> createState() => _CustomTimePickerFieldState();
}

class _CustomTimePickerFieldState extends State<CustomTimePickerField> {
  late TimeOfDay time;

  @override
  void initState() {
    time = parseTimeOfDay("00:00:00");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.title,
                style: AppStyles.textStyle14.copyWith(color: Colors.grey),
              ),
              if (widget.itemIsRequired == true)
                const Icon(
                  Icons.star,
                  color: Colors.red,
                  size: 10,
                )
            ],
          ),
          StatefulBuilder(
            builder: (context, setState) => GestureDetector(
              onTap: () async {
                final picked = await showTimePicker(
                  context: context,
                  initialTime: time,
                );
                if (picked != null) {
                  setState(() {
                    time = picked;
                    String myTime = formatTimeOfDayToFullString(picked);
                    print("====================$myTime");
                  });
                  // onUpdateSelection?.call();
                }
              },
              child: _timeContainer(time.format(context)),
            ),
          )
        ],
      ),
    );
  }

  Widget _timeContainer(String text) => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(text),
      );

  TimeOfDay parseTimeOfDay(String timeString) {
    final parts = timeString.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }

  String formatTimeOfDayToFullString(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:00";
  }
}
