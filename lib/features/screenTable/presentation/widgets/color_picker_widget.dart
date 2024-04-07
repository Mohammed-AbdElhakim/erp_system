import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../../../core/utils/app_styles.dart';

class ColorPickerWidget extends StatelessWidget {
  const ColorPickerWidget({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyles.textStyle14.copyWith(color: Colors.grey),
          ),
          ColorPicker(
            pickerAreaHeightPercent: 0.3,
            pickerColor: Colors.white,
            enableAlpha: false,
            // showLabel: false,
            labelTypes: [],
            onColorChanged: (Color value) {},
          )
        ],
      ),
    );
  }
}
