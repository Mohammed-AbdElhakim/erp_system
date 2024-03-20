import 'package:flutter/material.dart';

class CustomMainListTileInDrawer extends StatefulWidget {
  const CustomMainListTileInDrawer({
    Key? key,
    required this.icon,
    required this.title,
    required this.bodyList,
    // required this.isOpen,
  }) : super(key: key);
  final String icon;
  final String title;
  final List<Widget> bodyList;
  // final isOpened isOpen;

  @override
  State<CustomMainListTileInDrawer> createState() =>
      _CustomMainListTileInDrawerState();
}

class _CustomMainListTileInDrawerState
    extends State<CustomMainListTileInDrawer> {
  late bool val = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      shape: Border.all(color: Colors.white, width: 0),
      collapsedShape: Border.all(color: Colors.white, width: 0),
      onExpansionChanged: (v) {
        setState(() {
          val = v;
        });
      },
      title: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Image.asset(
          "assets/images/${widget.icon}.png",
          width: 35,
          height: 35,
        ),
      ),
      trailing: SizedBox(),
      // trailing: Padding(
      //   padding: const EdgeInsets.only(left: 8),
      //   child: Icon(
      //     val == false ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
      //     color: val == false ? Colors.black : Theme.of(context).primaryColor,
      //     size: 27,
      //   ),
      // ),
      backgroundColor: Colors.white24,
      children: widget.bodyList,
    );
  }
}
