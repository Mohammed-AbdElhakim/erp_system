import 'package:erp_system/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCircularButton extends StatefulWidget {
  const CustomCircularButton({
    super.key,
    this.onTap,
    required this.icon,
    required this.color,
  });
  final IconData icon;
  final Color color;
  final void Function()? onTap;

  @override
  State<CustomCircularButton> createState() => CustomCircularButtonState();
}

class CustomCircularButtonState extends State<CustomCircularButton> {
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
          width: 40,
          height: 40,
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: widget.color,
            boxShadow: isPressed
                ? null
                : [
                    const BoxShadow(
                      color: Colors.black87,
                      blurRadius: 8,
                    ),
                  ],
            borderRadius: BorderRadius.circular(60),
          ),
          child: Center(
            child: Icon(
              widget.icon,
              color: AppColors.white,
            ),
            // child: Text(
            //   widget.text,
            //   style: TextStyle(
            //       fontWeight: FontWeight.bold,
            //       fontSize: isPressed ? 14 : 16,
            //       color: Colors.white),
            // ),
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
