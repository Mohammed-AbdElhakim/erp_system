import 'package:erp_system/core/widgets/custom_error_massage.dart';
import 'package:erp_system/core/widgets/custom_loaging_widget.dart';
import 'package:erp_system/features/home/presentation/manager/getMenu/get_menu_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_text_form_field_search.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/menu_model.dart';
import 'home_view_header.dart';
import 'item_grid_view.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
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
          List<Pages> pagesList = [];
          for (var element in state.menu.list) {
            for (var page in element.pages) {
              if (page.isFastScreen == true) {
                pagesList.add(page);
              }
            }
          }
          return Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(
                      child: HomeViewHeader(
                        name: 'Ahmed',
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 35),
                        child: CustomTextFormFieldSearch(
                          hintText: S.of(context).search,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: pagesList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 35,
                          crossAxisSpacing: 35,
                        ),
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 16),
                        itemBuilder: (BuildContext context, int index) {
                          return ItemGridView(
                            icon: "http://${pagesList[index].icon}",
                            title: lang == AppStrings.enLangKey
                                ? pagesList[index].nameEn
                                : pagesList[index].nameAr,
                            onTap: () {
                              // GoRouter.of(context).push(listScreens[index].id);
                            },
                            key_pageId: pagesList[index].pageId.toString(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // const NavigationMenu()
            ],
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
