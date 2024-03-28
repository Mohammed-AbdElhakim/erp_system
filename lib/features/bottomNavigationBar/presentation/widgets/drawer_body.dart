import 'package:flutter/material.dart';

import '../../../home/data/models/menu_model.dart';
import 'custom_main_list_tile_in_drawer.dart';
import 'custom_sub_list_tile_in_drawer.dart';

class DrawerBody extends StatefulWidget {
  const DrawerBody({super.key, required this.list});
  final List<MenuModel> list;

  @override
  State<DrawerBody> createState() => _DrawerBodyState();
}

class _DrawerBodyState extends State<DrawerBody> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.list.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return CustomMainListTileInDrawer(
          title: widget.list[index].moduleNameAr!,
          bodyList: widget.list.map((e) {
            return CustomSubListTileInDrawer(
              title: e.nameAr!,
              icon: e.icon!,
              onTap: () {},
            );
          }).toList(),
        );
      },
    );
  }
}
