import 'package:erp_system/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.width,
    this.height,
    this.textStyle,
    this.color,
    this.noGradient,
  });
  final String text;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final Color? color;
  final bool? noGradient;

  final void Function()? onTap;

  @override
  State<CustomButton> createState() => CustomButtonState();
}

class CustomButtonState extends State<CustomButton> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: widget.onTap,
      child: Listener(
        onPointerDown: onPointerDown,
        onPointerUp: onPointerUp,
        child: Container(
          width: widget.width,
          height: widget.height ?? 45,
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: widget.color ?? AppColors.blueDark,
            gradient: widget.noGradient != true ? gradientButton : null,
            boxShadow: isPressed
                ? null
                : [
                    BoxShadow(
                      color: AppColors.blueDark,
                      blurRadius: 3,
                    ),
                  ],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              widget.text,
              style: widget.textStyle ??
                  TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: isPressed ? 14 : 16,
                    color: Colors.white,
                  ),
            ),
          ),
        ),
      ),
    );
  }

  void onPointerDown(PointerDownEvent event) {
    setState(() {
      isPressed = true;
    });
  }

  void onPointerUp(PointerUpEvent event) {
    setState(() {
      isPressed = false;
    });
  }
}
