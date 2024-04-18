import 'package:erp_system/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_text_form_field.dart';

class TextWidget extends StatefulWidget {
  const TextWidget({super.key, required this.title});
  final String title;

  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  String myValue = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: AppStyles.textStyle14.copyWith(color: Colors.grey),
          ),
          CustomTextFormField(
            hintText: '',
            keyboardType: TextInputType.text,
            onChanged: (value) {
              setState(() {
                myValue = value;
              });
            },
          )
        ],
      ),
    );
  }
}
