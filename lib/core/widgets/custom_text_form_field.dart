import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.controller,
      this.validatorMassage = 'Field is required',
      required this.label,
      this.onChanged,
      this.onSaved});
  final TextEditingController? controller;
  final String? validatorMassage;
  final String label;
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
      onChanged: onChanged,
      onSaved: onSaved,
      decoration: InputDecoration(
        label: Text(label),
        filled: true,
        fillColor: Colors.white70,
        border: buildBorder(),
        enabledBorder: buildBorder(color: Colors.cyan[500]),
        focusedBorder: buildBorder(color: Colors.cyan[900]),
      ),
    );
  }

  OutlineInputBorder buildBorder({Color? color}) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: color ?? Colors.grey,
        ));
  }
}
