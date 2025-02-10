import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../utils/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    this.validatorMassage,
    required this.hintText,
    this.onChanged,
    this.onSaved,
    this.isValidator = true,
    this.readOnly,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.isBorder,
    this.textStyle,
    this.filled,
    this.fillColor,
  });
  final TextEditingController? controller;
  final String? validatorMassage;
  final String hintText;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final bool? isValidator;
  final bool obscureText;
  final bool? isBorder;
  final bool? readOnly;
  final Widget? prefixIcon;
  final TextStyle? textStyle;
  final bool? filled;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        controller: controller,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        validator: isValidator == true
            ? (value) {
                if (value?.isEmpty ?? true) {
                  return validatorMassage ?? S.of(context).field_is_required;
                } else {
                  return null;
                }
              }
            : null,
        textAlign: TextAlign.center,
        onChanged: onChanged,
        onSaved: onSaved,
        keyboardType: keyboardType,
        obscureText: obscureText,
        textDirection: TextDirection.ltr,
        style: textStyle,
        readOnly: readOnly ?? false,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: AppColors.grey),
          filled: filled,
          fillColor: fillColor,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
          border: buildBorder(isBorder: isBorder),
          enabledBorder:
              buildBorder(color: AppColors.blueDark, isBorder: isBorder),
          focusedBorder:
              buildBorder(color: AppColors.blueDark, isBorder: isBorder),
          prefixIcon: prefixIcon,
        ),
      ),
    );
  }

  OutlineInputBorder buildBorder({
    Color? color,
    required bool? isBorder,
  }) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(isBorder != false ? 12 : 0),
        borderSide: isBorder != false
            ? BorderSide(
                color: color ?? Colors.grey,
              )
            : BorderSide.none);
  }
}
