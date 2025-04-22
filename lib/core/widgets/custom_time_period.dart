import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

import '../models/time_period_model.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

typedef Changed<TimePeriodModel> = void Function(TimePeriodModel value);

class CustomTimePeriod extends StatelessWidget {
  const CustomTimePeriod({super.key, required this.title, this.isRequired = false, this.initialDropValue, this.onChanged});

  final String title;
  final bool? isRequired;
  final TimePeriodModel? initialDropValue;
  final Changed<TimePeriodModel>? onChanged;

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
                title,
                style: AppStyles.textStyle14.copyWith(color: Colors.grey),
              ),
              if (isRequired == true)
                const Icon(
                  Icons.star,
                  color: Colors.red,
                  size: 10,
                ),
            ],
          ),
          StatefulBuilder(
            builder: (context, dropSetState) {
              return SizedBox(
                height: 40,
                child: CustomDropdown<TimePeriodModel>(
                  hintText: '',
                  initialItem: initialDropValue,
                  closedHeaderPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: CustomDropdownDecoration(
                    headerStyle: AppStyles.textStyle16.copyWith(color: Colors.black),
                    closedFillColor: Colors.transparent,
                    closedBorder: Border.all(color: AppColors.blueDark),
                  ),
                  items: [
                    TimePeriodModel(title: "All", id: "0"),
                    TimePeriodModel(title: "To Day", id: "1"),
                    TimePeriodModel(title: "Last Week", id: "7"),
                    TimePeriodModel(title: "Last Month", id: "30"),
                    TimePeriodModel(title: "Last quarter", id: "120"),
                    TimePeriodModel(title: "Last Year", id: "365"),
                  ],
                  onChanged: (value) {
                    if (onChanged != null) onChanged!(value as TimePeriodModel);
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
