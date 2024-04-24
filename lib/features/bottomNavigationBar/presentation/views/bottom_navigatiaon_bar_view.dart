import 'package:erp_system/features/bottomNavigationBar/presentation/widgets/navigation_helper.dart';
import 'package:erp_system/features/bottomNavigationBar/presentation/widgets/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/change_status_bar_color.dart';
import '../../../home/data/repositories/menu/menu_repo_impl.dart';
import '../../../home/presentation/manager/getMenu/get_menu_cubit.dart';

class BottomNavigationBarView extends StatefulWidget {
  const BottomNavigationBarView({super.key});

  @override
  State<BottomNavigationBarView> createState() =>
      _BottomNavigationBarViewState();
}

class _BottomNavigationBarViewState extends State<BottomNavigationBarView> {
  int selectIndex = 1;
  @override
  Widget build(BuildContext context) {
    return ChangeStatusBarColor(
      child: BlocProvider(
        create: (context) => GetMenuCubit(
          getIt.get<MenuRepoImpl>(),
        )..getMenu(),
        child: Scaffold(
          bottomNavigationBar: NavigationMenu(
            onChanged: (int value) {
              setState(() {
                selectIndex = value;
              });
            },
          ),
          body: NavigationHelper.getMyWidget(selectIndex),
        ),
        // ),
      ),
    );
  }
}
