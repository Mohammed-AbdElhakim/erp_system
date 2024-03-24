import 'package:erp_system/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.controller,
      this.validatorMassage = 'Field is required',
      required this.hintText,
      this.onChanged,
      this.onSaved});
  final TextEditingController? controller;
  final String? validatorMassage;
  final String hintText;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return validatorMassage;
        } else {
          return null;
        }
      },
      textAlign: TextAlign.center,
      onChanged: onChanged,
      onSaved: onSaved,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.grey),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
        border: buildBorder(),
        enabledBorder: buildBorder(color: AppColors.blueDark),
        focusedBorder: buildBorder(color: AppColors.blueDark),
      ),
    );
  }

  OutlineInputBorder buildBorder({Color? color}) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: color ?? Colors.grey,
        ));
  }
}
