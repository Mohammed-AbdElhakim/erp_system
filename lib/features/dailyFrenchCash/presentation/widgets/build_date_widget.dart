import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class BuildDateWidget extends StatefulWidget {
  const BuildDateWidget({super.key, required this.title, required this.selectedDate});
  final String title;
  final void Function(String dateTime) selectedDate;

  @override
  State<BuildDateWidget> createState() => _BuildDateWidgetState();
}

class _BuildDateWidgetState extends State<BuildDateWidget> {
  String date = "";

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: AppStyles.textStyle14.copyWith(color: Colors.grey),
            ),
            InkWell(
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
                    widget.selectedDate(dateTime.toString());
                  });
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
            ),
          ],
        ),
      ),
    );
  }
}
