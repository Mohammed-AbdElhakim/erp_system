import 'package:erp_system/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_text_form_field.dart';

typedef OnTapSave<T> = void Function(T valeu);

class NumberWidget extends StatelessWidget {
  const NumberWidget(
      {super.key,
      required this.title,
      required this.isRequired,
      required this.controller,
      required this.onTapSave});
  final String title;
  final bool isRequired;
  final TextEditingController controller;
  final OnTapSave<String> onTapSave;

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
                )
            ],
          ),
          CustomTextFormField(
            hintText: '',
            controller: controller,
            isValidator: isRequired,
            keyboardType: TextInputType.number,
            onSaved: (newValue) {
              if (newValue!.isNotEmpty) {
                onTapSave(newValue);
              }
            },
          ),
        ],
      ),
    );
  }
}
