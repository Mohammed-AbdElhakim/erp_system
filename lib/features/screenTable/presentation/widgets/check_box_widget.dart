import 'package:flutter/material.dart';

import '../../../../core/utils/app_styles.dart';

class CheckBoxWidget extends StatefulWidget {
  const CheckBoxWidget({super.key, required this.title});
  final String title;

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  bool checkBoxValue = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: CheckboxListTile(
        contentPadding: EdgeInsets.zero,
        value: checkBoxValue,
        onChanged: (newValue) {
          setState(() {
            checkBoxValue = newValue!;
          });
        },
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(
          widget.title,
          style: AppStyles.textStyle14.copyWith(color: Colors.grey),
        ),
      ),
    );
  }
}
