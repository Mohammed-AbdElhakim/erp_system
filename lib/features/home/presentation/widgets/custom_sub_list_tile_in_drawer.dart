import 'package:flutter/material.dart';

class CustomSubListTileInDrawer extends StatelessWidget {
  const CustomSubListTileInDrawer({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Theme.of(context).primaryColor.withOpacity(.7),
      elevation: 5,
      shadowColor: Theme.of(context).primaryColor.withOpacity(.9),
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(right: 0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
        // trailing: Icon(
        //   Icons.arrow_forward_ios,
        //   size: 20,
        //   color: Colors.white,
        // ),
        onTap: () => onTap(),
      ),
    );
  }
}
