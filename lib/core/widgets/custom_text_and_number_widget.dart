import 'package:flutter/material.dart';

import '../utils/app_styles.dart';
import 'custom_text_form_field.dart';

typedef Changed<String> = void Function(String value);

class CustomTextAndNumberWidget extends StatelessWidget {
  const CustomTextAndNumberWidget({
    super.key,
    required this.title,
    this.isRequired = false,
    required this.keyboardType,
    required this.onChanged,
    this.controller,
  });

  final String title;
  final bool? isRequired;
  final TextInputType keyboardType;
  final Changed onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, tNSetState) {
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
                  if (isRequired! == true)
                    const Icon(
                      Icons.star,
                      color: Colors.red,
                      size: 10,
                    )
                ],
              ),
              CustomTextFormField(
                hintText: '',
                isValidator: isRequired!,
                keyboardType: keyboardType,
                controller: controller,
                onChanged: (value) {
                  onChanged(value);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
