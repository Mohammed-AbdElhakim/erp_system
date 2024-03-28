import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_error_massage.dart';
import '../../../../core/widgets/custom_loaging_widget.dart';
import '../../../home/data/models/menu_model.dart';
import '../../../home/presentation/manager/getMenu/get_menu_cubit.dart';
import 'custom_drawer_header.dart';
import 'drawer_body.dart';
import 'log_out_item.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetMenuCubit, GetMenuState>(
      builder: (context, state) {
        if (state is GetMenuSuccess) {
          List<MenuModel> listMenu = state.menu;

          return Drawer(
            width: MediaQuery.of(context).size.width * .75,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const CustomDrawerHeader(userName: 'Mohamed'),
                  DrawerBody(
                    list: listMenu,
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
