import 'package:erp_system/core/utils/service_locator.dart';
import 'package:erp_system/core/widgets/change_status_bar_color.dart';
import 'package:erp_system/features/home/data/repositories/menu/menu_repo_impl.dart';
import 'package:erp_system/features/home/presentation/manager/getMenu/get_menu_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/home_view_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return ChangeStatusBarColor(
      child: Scaffold(
        body: BlocProvider(
          create: (context) => GetMenuCubit(
            getIt.get<MenuRepoImpl>(),
          )..getMenu(),
          child: const HomeViewBody(),
        ),
      ),
    );
  }
}
