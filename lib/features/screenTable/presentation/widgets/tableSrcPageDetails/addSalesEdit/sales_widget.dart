import 'package:flutter/material.dart';

class SalesWidget extends StatelessWidget {
  const SalesWidget(
      {super.key,
      this.colorBackgroundTitle,
      this.colorBackgroundWidget,
      required this.title,
      required this.child,
      this.isBorderTop = false});
  final Color? colorBackgroundTitle;
  final Color? colorBackgroundWidget;
  final String title;
  final Widget child;
  final bool? isBorderTop;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 55,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
                border: BorderDirectional(
                  end: const BorderSide(color: Colors.grey, width: .5),
                  start: const BorderSide(color: Colors.grey),
                  bottom: const BorderSide(color: Colors.grey),
                  top: isBorderTop == true
                      ? const BorderSide(color: Colors.grey)
                      : BorderSide.none,
                ),
                color: colorBackgroundTitle),
            alignment: AlignmentDirectional.centerStart,
            child: Text(title),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            height: 55,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
                border: BorderDirectional(
                  start: const BorderSide(color: Colors.grey, width: .7),
                  end: const BorderSide(color: Colors.grey),
                  bottom: const BorderSide(color: Colors.grey),
                  top: isBorderTop == true
                      ? const BorderSide(color: Colors.grey)
                      : BorderSide.none,
                ),
                color: colorBackgroundWidget),
            alignment: Alignment.center,
            child: child,
          ),
        ),
      ],
    );
  }
}
