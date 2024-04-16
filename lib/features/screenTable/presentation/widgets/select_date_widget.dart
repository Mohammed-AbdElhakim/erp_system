import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class SelectDateWidget extends StatefulWidget {
  const SelectDateWidget({super.key, required this.title});
  final String title;

  @override
  State<SelectDateWidget> createState() => _SelectDateWidgetState();
}

class _SelectDateWidgetState extends State<SelectDateWidget> {
  late String date;
  @override
  void initState() {
    date = widget.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          selectDate();
        },
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColors.blueDark)),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            child: Text(
              date,
              textAlign: TextAlign.center,
              style: AppStyles.textStyle14.copyWith(color: Colors.black),
            )),
      ),
    );
  }

  Future<void> selectDate() async {
    DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime(2100),
    );
    if (dateTime != null) {
      setState(() {
        date = dateTime.toString().split(" ")[0];
      });
    }
  }
}
