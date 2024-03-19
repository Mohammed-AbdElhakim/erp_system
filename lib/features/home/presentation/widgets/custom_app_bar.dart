import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.title,
    this.leading,
    this.actions,
    this.elevation = 2.0,
  }) : super(key: key);
  final Widget? title;
  final Widget? leading;
  final double elevation;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      // child:Container(
      // decoration: const BoxDecoration(
      //   gradient: LinearGradient(
      //       colors: [Color.fromARGB(100, 0, 48, 167), Colors.amber],
      //       begin: const FractionalOffset(0.0, 1.0),
      //       end: const FractionalOffset(0.5, 0.5),
      //       stops: [0.0, 2.5],
      //       tileMode: TileMode.clamp),
      // ),
      child: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              // gradient: LinearGradient(
              //   colors: [
              //     Color(0xff48cae4),
              //     Color(0xff00b4d8),
              //     Color(0xff0096c7),
              //     Color(0xff0077b6),
              //   ],
              //   stops: [0.2, 0.3, 0.5, 1.5],
              // ),
              color: Theme.of(context).primaryColor),
        ),
        centerTitle: false,
        leading: leading,
        elevation: 0.0,
        title: title,
        backgroundColor: Colors.transparent,
        actions: actions,
      ),
      // ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
