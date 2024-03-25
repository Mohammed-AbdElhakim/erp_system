import 'package:erp_system/core/utils/app_colors.dart';
import 'package:erp_system/core/utils/constants.dart';
import 'package:erp_system/core/widgets/change_status_bar_color.dart';
import 'package:erp_system/features/home/presentation/widgets/home_view_header.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_text_form_field_search.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/fast_screen_model.dart';
import '../widgets/item_grid_view.dart';
import '../widgets/my_drawer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
                Positioned(
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
        body: Stack(
          children: [
            ListView(
              children: [
                const HomeViewHeader(
                  name: 'Ahmed',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomTextFormFieldSearch(
                    hintText: S.of(context).search,
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: listScreens.length,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 35,
                      crossAxisSpacing: 35,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (BuildContext context, int index) {
                      return ItemGridView(
                        icon: listScreens[index].image,
                        title: listScreens[index].title,
                        onTap: () {
                          GoRouter.of(context).push(listScreens[index].id);
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(gradient: gradientContainer),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.home_outlined,
                      size: 30,
                      color: AppColors.white,
                    ),
                    Icon(
                      Icons.location_on_outlined,
                      size: 30,
                      color: AppColors.white,
                    ),
                    Icon(
                      Icons.email_outlined,
                      size: 30,
                      color: AppColors.white,
                    ),
                    Stack(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.person_outline,
                            size: 30,
                            color: AppColors.white,
                          ),
                        ),
                        Positioned(
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
