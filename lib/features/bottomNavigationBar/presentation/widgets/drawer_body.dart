import 'package:flutter/material.dart';

import '../../../../core/models/menu_model/list_module.dart';
import '../../../../core/utils/app_strings.dart';
import 'custom_main_list_tile_in_drawer.dart';
import 'custom_sub_list_tile_in_drawer.dart';

class DrawerBody extends StatefulWidget {
  const DrawerBody({super.key, required this.list});
  final List<ListModule> list;

  @override
  State<DrawerBody> createState() => _DrawerBodyState();
}

class _DrawerBodyState extends State<DrawerBody> {
  String? lang;
  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.list.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        ListModule module = widget.list[index];
        return CustomMainListTileInDrawer(
          title: lang == AppStrings.enLangKey
              ? module.moduleNameEn
              : module.moduleNameAr,
          bodyList: List.generate(
            module.pages.length,
            (pageIndex) {
              return CustomSubListTileInDrawer(
                page: module.pages[pageIndex],
              );
            },
          ),
        );
      },
    );
  }
}
