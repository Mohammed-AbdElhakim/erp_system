import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_error_massage.dart';
import '../../../../core/widgets/custom_loaging_widget.dart';
import '../../../home/data/models/menu_model.dart';
import '../../../home/presentation/manager/getMenu/get_menu_cubit.dart';
import 'custom_drawer_header.dart';
import 'custom_main_list_tile_in_drawer.dart';
import 'custom_sub_list_tile_in_drawer.dart';
import 'log_out_item.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetMenuCubit, GetMenuState>(
      builder: (context, state) {
        if (state is GetMenuSuccess) {
          List<MenuModel> listMenu = state.menu;

          return Drawer(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const CustomDrawerHeader(userName: 'Mohamed'),
                  ListView.builder(
                    itemCount: listMenu.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CustomMainListTileInDrawer(
                        title: listMenu[index].moduleNameAr!,
                        bodyList: listMenu.map((e) {
                          return CustomSubListTileInDrawer(
                            title: e.nameAr!,
                            icon: e.icon!,
                            onTap: () {},
                          );
                        }).toList(),
                      );
                    },
                  ),
                  const LogoutItem(),
                ],
              ),
            ),
          );
        } else if (state is GetMenuFailure) {
          return CustomErrorMassage(errorMassage: state.errorMassage);
        } else {
          return const CustomLoadingWidget();
        }
      },
    );
  }
}
