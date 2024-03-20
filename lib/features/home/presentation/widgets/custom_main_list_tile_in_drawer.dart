import 'package:flutter/material.dart';

// typedef isOpened = void Function(bool value);

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
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      // color: Theme.of(context).primaryColor,
      elevation: val == false ? 5 : 0,
      shadowColor: Colors.white38,
      child: ExpansionTile(
        onExpansionChanged: (v) {
          isOpen(v);
          setState(() {
            val = v;
          });
        },
        title: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Text(
            widget.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color:
                  val == false ? Colors.black : Theme.of(context).primaryColor,
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
        trailing: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Icon(
            val == false ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
            color: val == false ? Colors.black : Theme.of(context).primaryColor,
            size: 27,
          ),
        ),
        backgroundColor: Colors.white24,
        children: widget.bodyList,
      ),
    );
  }

  void isOpen(bool v) {}
}
