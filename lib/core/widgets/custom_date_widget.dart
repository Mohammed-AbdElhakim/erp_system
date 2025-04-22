import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

typedef TapSelect<String> = void Function(String date);

class CustomDateWidget extends StatefulWidget {
  const CustomDateWidget({super.key, required this.onSelect, this.isRequired = false, required this.title});

  final TapSelect onSelect;
  final bool? isRequired;
  final String title;

  @override
  State<CustomDateWidget> createState() => _CustomDateWidgetState();
}

class _CustomDateWidgetState extends State<CustomDateWidget> {
  String date = '';

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
              if (widget.isRequired == true)
                const Icon(
                  Icons.star,
                  color: Colors.red,
                  size: 10,
                )
            ],
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
                  widget.onSelect(dateTime.toString());
                });
              }
            },
            child: Container(
                height: 40,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.blueDark)),
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
    );
  }
}
