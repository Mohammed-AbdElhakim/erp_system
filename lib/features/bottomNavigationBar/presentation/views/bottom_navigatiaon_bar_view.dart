import 'package:erp_system/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/change_status_bar_color.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../home/data/repositories/menu/menu_repo_impl.dart';
import '../../../home/presentation/manager/getMenu/get_menu_cubit.dart';
import '../widgets/my_drawer.dart';

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
          appBar: CustomAppBar(
            actions: [
              Stack(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_none_sharp),
                  ),
                  const Positioned(
                    right: 12,
                    top: 15,
                    child: Icon(
                      Icons.circle,
                      color: Colors.orange,
                      size: 12,
                    ),
                  )
                ],
              ),
            ],
          ),
          drawer: const MyDrawer(),
          bottomNavigationBar: navigationMenu(),
          body: getMyWidget(selectIndex),
        ),
      ),
    );
  }

  navigationMenu() {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(gradient: gradientContainer),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                selectIndex = 1;
              });
            },
            icon: Icon(
              Icons.home_outlined,
              size: 30,
              color: AppColors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                selectIndex = 2;
              });
            },
            icon: Icon(
              Icons.location_on_outlined,
              size: 30,
              color: AppColors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                selectIndex = 3;
              });
            },
            icon: Icon(
              Icons.email_outlined,
              size: 30,
              color: AppColors.white,
            ),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    selectIndex = 4;
                  });
                },
                icon: Icon(
                  Icons.person_outline,
                  size: 30,
                  color: AppColors.white,
                ),
              ),
              const Positioned(
                right: 10,
                top: 12,
                child: Icon(
                  Icons.circle,
                  color: Colors.orange,
                  size: 12,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  getMyWidget(int index) {
    switch (index) {
      case 1:
        return const HomeView();
      case 2:
        return Container(
          child: Center(
            child: Text('$selectIndex'),
          ),
        );
      case 3:
        return Container(
          child: Center(
            child: Text('$selectIndex'),
          ),
        );
      default:
        return Container(
          child: Center(
            child: Text('$selectIndex'),
          ),
        );
    }
  }
}
