import 'package:erp_system/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_text_form_field.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({super.key, required this.title, required this.typeInput});
  final String title;
  final String typeInput;
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
          CustomTextFormField(
            hintText: '',
            keyboardType: typeInput == "number"
                ? TextInputType.number
                : TextInputType.text,
          )
        ],
      ),
    );
  }
}
