import 'package:erp_system/core/utils/service_locator.dart';
import 'package:erp_system/core/widgets/change_status_bar_color.dart';
import 'package:erp_system/features/home/data/repositories/menu/menu_repo_impl.dart';
import 'package:erp_system/features/home/presentation/manager/getMenu/get_menu_cubit.dart';
import 'package:erp_system/features/home/presentation/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../data/models/fast_screen_model.dart';
import '../widgets/home_view_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectIndex = 0;
  List<FastScreenModel> listScreens = [
    FastScreenModel(
        id: "/attendanceView",
        image: "2",
        title: "المبيعات والعملاء",
        colorBackground: 0xFF6FC063),
    FastScreenModel(
        id: "/attendanceView",
        image: "7",
        title: "الحسابات",
        colorBackground: 0xFF7A5649),
    FastScreenModel(
        id: "/attendanceView",
        image: "1",
        title: "الإعدادات",
        colorBackground: 0xFFD94949),
    FastScreenModel(
        id: "/attendanceView",
        image: "6",
        title: "المهام",
        colorBackground: 0xFFF8951D),
    FastScreenModel(
        id: "/attendanceView",
        image: "4",
        title: "المقاولات",
        colorBackground: 0xFF9062AA),
    FastScreenModel(
        id: "/attendanceView",
        image: "3",
        title: "المشتريات والموردين ",
        colorBackground: 0xFF9062AA),
    FastScreenModel(
        id: "/attendanceView",
        image: "7",
        title: "الفاتورة الإلكترونية ",
        colorBackground: 0xFF9062AA),
    FastScreenModel(
        id: "/attendanceView",
        image: "4",
        title: "الحضور والانصراف",
        colorBackground: 0xFF9062AA),
    FastScreenModel(
        id: "/attendanceView",
        image: "5",
        title: "المخازن ",
        colorBackground: 0xFF9062AA),
  ];
  @override
  Widget build(BuildContext context) {
    return ChangeStatusBarColor(
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
        body: BlocProvider(
          create: (context) => GetMenuCubit(
            getIt.get<MenuRepoImpl>(),
          )..getMenu(),
          child: const HomeViewBody(),
        ),
      ),
    );
  }

  List iconList = [
    Icons.home_outlined,
    Icons.location_on_outlined,
    Icons.email_outlined,
    Icons.person_outlined,
  ];
  navigationMenu() {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(gradient: gradientContainer),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: iconList.map((e) {
          if (iconList.indexOf(e) == iconList.length - 1) {
            return Stack(
              children: [
                IconButton(
                  onPressed: () {},
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
            );
          } else {
            return GestureDetector(
              onTap: () {},
              child: Icon(
                e,
                size: 30,
                color: AppColors.white,
              ),
            );
          }
        }).toList(),
      ),
    );
  }
}
