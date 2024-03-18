import 'package:erp_system/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.width,
    this.height,
  });
  final String text;
  final double? width;
  final double? height;

  final void Function()? onTap;

  @override
  State<CustomButton> createState() => CustomButtonState();
}

class CustomButtonState extends State<CustomButton> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: onPointerDown,
      onPointerUp: onPointerUp,
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: widget.onTap,
        child: Container(
          width: widget.width,
          height: widget.height ?? 45,
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.buttonColor,
            boxShadow: isPressed
                ? null
                : [
                    const BoxShadow(
                      color: Colors.black54,
                      blurRadius: 10,
                      offset: Offset(0, 0),
                    ),
                  ],
            borderRadius: BorderRadius.circular(60),
          ),
          child: Center(
            child: Text(
              widget.text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
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
