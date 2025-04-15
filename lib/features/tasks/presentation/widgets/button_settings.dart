import 'package:flutter/material.dart';

class ButtonSettings extends StatelessWidget {
  const ButtonSettings({super.key, required this.icon, required this.onTap});
  final IconData icon;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsetsDirectional.only(end: 25),
        decoration:  BoxDecoration(
          color: Colors.blue.shade900,
          borderRadius: const BorderRadiusDirectional.only(

            topStart: Radius.circular(15),
            bottomEnd: Radius.circular(8),
          ),
        ),
        width: 25,
        height: 25,
        alignment: Alignment.center,
        child: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
