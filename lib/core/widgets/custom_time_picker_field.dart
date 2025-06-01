import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class CustomTimePickerField extends StatefulWidget {
  const CustomTimePickerField(
      {super.key,
      required this.title,
      required this.itemIsRequired,
      this.initialTimeString,
      required this.onTimeSelected,
      this.onClear});

  final String title;
  final bool itemIsRequired;
  final String? initialTimeString;
  final Function(String?) onTimeSelected;
  final Function()? onClear;

  @override
  State<CustomTimePickerField> createState() => _CustomTimePickerFieldState();
}

class _CustomTimePickerFieldState extends State<CustomTimePickerField> {
  TimeOfDay? selectedTime;
  String? selectedTimeFormatted;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.initialTimeString != null && widget.initialTimeString!.isNotEmpty) {
      selectedTime = parseTimeOfDay(widget.initialTimeString!);
      selectedTimeFormatted = selectedTime!.format(context);
    }
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
              if (widget.itemIsRequired) const Icon(Icons.star, color: Colors.red, size: 10),
            ],
          ),
          GestureDetector(
            onTap: () async {
              final picked = await showTimePicker(
                context: context,
                initialTime: selectedTime ?? TimeOfDay.now(),
              );
              if (picked != null) {
                setState(() {
                  selectedTime = picked;
                  selectedTimeFormatted = picked.format(context);
                });
                widget.onTimeSelected(formatTimeOfDayToFullString(picked));
              }
            },
            child: _timeContainer(),
          ),
        ],
      ),
    );
  }

  Widget _timeContainer() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            selectedTimeFormatted ?? "",
            style: TextStyle(
              color: selectedTimeFormatted == null ? Colors.grey : Colors.black,
            ),
          ),
          if (selectedTimeFormatted != null)
            InkWell(
              onTap: () {
                setState(() {
                  selectedTime = null;
                  selectedTimeFormatted = null;
                });
                widget.onClear?.call();
              },
              child: Icon(Icons.clear, size: 20, color: AppColors.blueLight),
            ),
        ],
      ),
    );
  }

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

/*class _CustomTimePickerFieldState extends State<CustomTimePickerField> {
  late TimeOfDay time;
  bool isFirst = true;

  @override
  void initState() {
    time = parseTimeOfDay(widget.initialTimeString ?? "");
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
                    isFirst = false;
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

  Widget _timeContainer(String text) {
    String time = isFirst == true ? "" : text;
    return StatefulBuilder(
      builder: (context, setState) => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(time),
            if (time != "")
              InkWell(
                onTap: () {
                  setState(() {
                    time = "";
                  });
                },
                child: Icon(
                  Icons.clear,
                  size: 20,
                  color: AppColors.blueLight,
                ),
              )
          ],
        ),
      ),
    );
  }

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
}*/
