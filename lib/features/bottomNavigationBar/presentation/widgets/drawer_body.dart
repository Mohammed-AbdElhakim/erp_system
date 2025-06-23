import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/manager/getMenu/get_menu_cubit.dart';
import '../../../../core/models/menu_model/list_module.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_error_massage.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import 'custom_main_list_tile_in_drawer.dart';
import 'custom_sub_list_tile_in_drawer.dart';

class DrawerBody extends StatefulWidget {
  const DrawerBody({
    super.key,
  });

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
    return BlocBuilder<GetMenuCubit, GetMenuState>(
      builder: (context, state) {
        if (state is GetMenuSuccess) {
          List<ListModule> listMenu = state.menu.list;

          return ListView.builder(
            itemCount: listMenu.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              ListModule module = listMenu[index];
              return CustomMainListTileInDrawer(
                title: lang == AppStrings.enLangKey ? module.moduleNameEn : module.moduleNameAr,
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
        } else if (state is GetMenuFailure) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomErrorMassage(errorMassage: state.errorMassage),
          );
        } else {
          return const CustomLoadingWidget();
        }
      },
    );
  }
}
